//
//  RadioGroup.m
//  CheckBox
//
//  Created by apple on 14-3-7.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "RadioGroup.h"

@implementation RadioGroup

@synthesize text,value;
-( id )init{
    if ( self =[super init]){
        children =[[ NSMutableArray alloc ] init ];
    }
    return self ;
}
-( void )add:(CheckButton *)cb{
    cb.delegate = self ;
    if (cb.checked) {
        text =cb. label . text ;
        value =cb. value ;
    }
    [ children addObject :cb];
}
-( void )checkButtonClicked:( id )sender{
    CheckButton * cb=( CheckButton *)sender;
//    if (!cb.checked) {
        // 实现单选
        for ( CheckButton * each in children ){
//            if (each.checked ) {
                [each setChecked : NO ];
//            }
        }
        [cb setChecked : YES ];
        // 复制选择的项
        text =cb. label . text ;
        value =cb. value ;
//    }else{
    
//    }
    NSLog ( @"text:%@,value:%d" , text ,[( NSNumber *) value intValue ]);
}

@end
