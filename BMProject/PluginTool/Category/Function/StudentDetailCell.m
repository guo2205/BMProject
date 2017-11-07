//
//  StudentDetailCell.m
//  MHProject
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 MengHuan. All rights reserved.
//

#import "StudentDetailCell.h"

@implementation StudentDetailCell

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    
    return self;
}

-(void)initView{
    _titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 45)];
    _titleLB.textColor = color_hex(0x333333);
    _titleLB.font = DEF_Font(13);
    [self addSubview:_titleLB];
    
    _contentLB = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2-10, 0, DEF_SCREEN_WIDTH/2, 45)];
    _contentLB.textColor = color_hex(0x666666);
    _contentLB.textAlignment = NSTextAlignmentRight;
    _contentLB.font = DEF_Font(13);
    [self addSubview:_contentLB];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 45-SINGLE_LINE_WIDTH, DEF_SCREEN_WIDTH, SINGLE_LINE_WIDTH)];
    lineView.backgroundColor = color_hex(0xf6f6f6);
    [self addSubview:lineView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
