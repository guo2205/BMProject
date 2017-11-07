//
//  AlertLabel.h
//  MyProject
//
//  Created by 郭梦珂 on 15/12/3.
//  Copyright © 2015年 GMK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertLabel : UIScrollView
+ (AlertLabel*)sharedManager;
-(void)showTextWith:(NSString *)msg fromView:(id)view;
@end
