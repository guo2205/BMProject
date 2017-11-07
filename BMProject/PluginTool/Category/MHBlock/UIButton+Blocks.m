//
//  UIButton+ClickBlock.m
//  MyProject
//
//  Created by admin on 16/5/23.
//  Copyright © 2016年 GMK. All rights reserved.
//

#import "UIButton+Blocks.h"
#import "UIButton+WebCache.h"
@implementation UIButton (Blocks)
static char overviewKey;

- (void)handleBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block(sender);
    }
}

- (void) sd_setImageWithUrlString:(NSString *)urlStr placeImage:(UIImage *)image{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:image];
}
@end
