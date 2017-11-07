//
//  DurgNameView.h
//  Ylh
//
//  Created by CNBJCHENRJM041 on 16/2/21.
//  Copyright © 2016年 Feikol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DurgNameDelegate <NSObject>

- (void) returnDurgNamecode:(NSString *)code;

@end

@interface DurgNameView : UIView

@property (nonatomic, strong) id<DurgNameDelegate> delegate;

-(void)showDurgView;

@end
