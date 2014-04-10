  //
//  Harpy.m
//  Harpy
//
//  Created by Arthur Ariel Sabintsev on 11/14/12.
//  Copyright (c) 2012 Arthur Ariel Sabintsev. All rights reserved.
//

#import "LBHarpy.h"
#import "LBHarpyConstants.h"

#define kHarpyCurrentVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]

@interface LBHarpy ()

//+ (void)showAlertWithAppStoreVersion:(NSString*)appStoreVersion;
+ (void)showAlertWithAppStoreVersion:(NSString *)currentAppStoreVersion updateContent:(NSString *)content;

@end

@implementation LBHarpy

#pragma mark - Public Methods

+ (NSString *)getAppStoreVersion:(id)delegate{
    // Asynchronously query iTunes AppStore for publically available version
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", kHarpyAppID];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if ( [data length] > 0 && !error ) { // Success
            
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // All versions that have been uploaded to the AppStore
                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
//                NSArray *updateContentArray = [[appData valueForKey:@"results"] valueForKey:@"releaseNotes"];
                if ( ![versionsInAppStore count] ) { // No versions of app in AppStore
                    
                    return;
                    
                } else {
                    NSString *currentAppStoreVersion  = nil;
                    if ([versionsInAppStore count ] > 0) {
                        currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
                    }
                    
                    NSLog(@"%@",kHarpyCurrentVersion);
                    
                    if ([kHarpyCurrentVersion compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending) {
		                if (delegate && [delegate respondsToSelector:@selector(getAppStoreVersionSuccess:)]) {
                            [delegate getAppStoreVersionSuccess:currentAppStoreVersion];
                        }
                    }
                    else {
                        
                        // Current installed version is the newest public version or newer
                        
                    }
                }
                
            });
        }
        
    }];
    
    return nil;
}

static NSString *currentAppStoreVersion  = nil;
static UIAlertView *loadingAlertView  = nil;

+ (void)checkVersion
{

    // Asynchronously query iTunes AppStore for publically available version
    
    loadingAlertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"\n\n正在检测新版本...\n\n\n"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [loadingAlertView show];
    
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", kHarpyAppID];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
       
        if ( [data length] > 0 && !error ) { // Success
            
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

            dispatch_async(dispatch_get_main_queue(), ^{
                
                // All versions that have been uploaded to the AppStore
                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                NSArray *updateContentArray = [[appData valueForKey:@"results"] valueForKey:@"releaseNotes"];
                if ( ![versionsInAppStore count] ) { // No versions of app in AppStore
                    [loadingAlertView dismissWithClickedButtonIndex:0 animated:NO];

                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"\n您现在正在使用最新版本\n\n" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    return;
                    
                } else {
                    if ([versionsInAppStore count] > 0) {
                       currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
                    }
                    
                    NSLog(@"%@",kHarpyCurrentVersion);
                    
                    if ([kHarpyCurrentVersion compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending) {
		                
                        [LBHarpy showAlertWithAppStoreVersion:currentAppStoreVersion updateContent:[updateContentArray lastObject]];
	                
                    } else {
		            
                        // Current installed version is the newest public version or newer
                        [loadingAlertView dismissWithClickedButtonIndex:0 animated:NO];

                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"\n您现在正在使用最新版本\n\n" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                }
            });
        }
    }];
}

#pragma mark - Private Methods
+ (void)showAlertWithAppStoreVersion:(NSString *)currentAppStoreVersion updateContent:(NSString *)content{
//    NSString *ignoredVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"ignoredVersion"];
//    if (!ignoredVersion || ![ignoredVersion isEqualToString:currentAppStoreVersion]) {
    [loadingAlertView dismissWithClickedButtonIndex:0 animated:NO];
    loadingAlertView = nil;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"\n\n%@\n\n",kHarpyAlertViewTitle] message:nil delegate:self cancelButtonTitle:kHarpyCancelButtonTitle otherButtonTitles:kHarpyUpdateButtonTitle, nil];
        [alertView show];
//    }
}

#pragma mark - UIAlertViewDelegate Methods
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ( harpyForceUpdate ) {
        NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", kHarpyAppID];
        NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
        [[UIApplication sharedApplication] openURL:iTunesURL];
    } else {
        switch ( buttonIndex ) {
            case 0:{ // Cancel / Not now
//                [[NSUserDefaults standardUserDefaults] setObject:currentAppStoreVersion forKey:@"ignoredVersion"];
            } break;
            case 1:{ // Update
                NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", kHarpyAppID];
                NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
                [[UIApplication sharedApplication] openURL:iTunesURL];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ignoredVersion"];
            } break;
                
            default:
                break;
        }
    }
}

@end
