//
//  RadioGroup.h
//  CheckBox
//
//  Created by apple on 14-3-7.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckButton.h"

@interface RadioGroup : NSObject{
    NSMutableArray * children ;
    NSString * text ;
    id value ;
}
@property ( readonly )NSString* text;
@property ( readonly ) id value;

-( void )add:( CheckButton *)cb;
-( void )checkButtonClicked:( id )sender;

@end
