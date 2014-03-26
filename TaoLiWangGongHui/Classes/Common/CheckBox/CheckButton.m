//
//  CheckButton.m
//  CheckBox
//
//  Created by apple on 14-3-7.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "CheckButton.h"

@implementation CheckButton
@synthesize label,icon,value,delegate,checked;

-( id )initWithFrame:( CGRect ) frame
{
    if ( self =[ super initWithFrame : frame ]) {
        icon =[[ UIImageView alloc ] initWithFrame :
               CGRectMake ( 10 , 0 , 20 , 20 )];
        [ self setStyle : CheckButtonStyleDefault ]; // 默认风格为方框（多选）样式
        //self.backgroundColor=[UIColor grayColor];
        [ self addSubview : icon ];
        label =[[ UILabel alloc ] initWithFrame : CGRectMake ( icon . frame . size . width + 24 , 0 ,
                                                              frame . size . width - icon . frame . size . width - 24 ,
                                                              frame . size . height )];
        label . backgroundColor =[ UIColor clearColor ];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label . font =[ UIFont fontWithName : @"Arial" size : 14 ];
        label . textColor =[ UIColor darkGrayColor];
        label . textAlignment = NSTextAlignmentLeft ;
        [ self addSubview : label ];
        [ self addTarget : self action : @selector ( clicked ) forControlEvents : UIControlEventTouchUpInside ];
    }
    return self ;
}
-( CheckButtonStyle )style{
    return style ;
}
-( void )setStyle:( CheckButtonStyle )st{
    style =st;
    switch ( style ) {
        case CheckButtonStyleDefault :
        case CheckButtonStyleBox :
            checkname = @"vote_selected.png" ;
            uncheckname = @"vote_normal.png" ;
            break ;
        case CheckButtonStyleRadio :
            checkname = @"radio.png" ;
            uncheckname = @"unradio.png" ;
            break ;
        default :
            break ;
    }
    [ self setChecked : checked ];
}
-( BOOL )isChecked{
    return checked ;
}
-( void )setChecked:(BOOL)b{
    if (b!= checked ){
        checked =b;
    }
    if ( checked ) {
        [ icon setImage :[ UIImage imageNamed : checkname ]];
    } else {
        [ icon setImage :[ UIImage imageNamed : uncheckname ]];
    }
}


-( void )clicked{
    [ self setChecked :! checked ];
    if ( delegate != nil ) {
        SEL sel= NSSelectorFromString (@"checkButtonClicked:");
        if ([ delegate respondsToSelector :sel]){
            SuppressPerformSelectorLeakWarning ([ delegate performSelector :sel withObject:self]);
        } 
    }
}

@end
