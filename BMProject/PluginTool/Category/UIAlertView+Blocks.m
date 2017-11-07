//
//  UIAlertView+Blocks.m
//  MyProject
//
//  Created by admin on 16/5/23.
//  Copyright © 2016年 GMK. All rights reserved.
//

#import "UIAlertView+Blocks.h"

@implementation UIAlertView (Blocks)

static char alertViewKey;

- (void) handleBlock:(ActionBlocks)action{
    self.delegate = self;
    objc_setAssociatedObject(self, &alertViewKey, action, OBJC_ASSOCIATION_COPY);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    ActionBlocks block = objc_getAssociatedObject(self, &alertViewKey);
    
    if (block) {
        block(buttonIndex);
    }
}
@end
