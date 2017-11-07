//
//  DurgNameView.m
//  Ylh
//
//  Created by CNBJCHENRJM041 on 16/2/21.
//  Copyright © 2016年 Feikol. All rights reserved.
//

#import "DurgNameView.h"
//#import <QuartzCore/QuartzCore.h>

static const CGFloat during_time = 0.1;
static NSString * const AnimationKey = @"animationKey";

@interface DurgNameView ()<UITextFieldDelegate,CAAnimationDelegate>
{
    CGFloat mainWidth;
    CGFloat mainHeight;
    
    CGFloat bottomWidth;
    CGFloat bottomHeight;
    
    UITextField * nameTextField;
}
//底视图
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation DurgNameView

-(instancetype)init
{
    mainWidth = [UIScreen mainScreen].bounds.size.width;
    mainHeight = [UIScreen mainScreen].bounds.size.height;
    
    self = [super initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight)];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        
        // 给背景添加一个透明的大button
//        UIButton * backGroundButton = [[UIButton alloc]initWithFrame:self.frame];
//        [backGroundButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:backGroundButton];
        
        // 定义底部的view
        bottomWidth = mainWidth * 0.8;
        bottomHeight = 150;
        
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(mainWidth / 2 - bottomWidth / 2,mainHeight / 2 - bottomHeight / 2 - 60, bottomWidth, bottomHeight)];
        _bottomView.backgroundColor = [UIColor clearColor];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.cornerRadius = 5;
        _bottomView.layer.masksToBounds = YES;
        [self addSubview:_bottomView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, bottomWidth, 30)];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"请输入条形码编码";
        [_bottomView addSubview:label];
        
        nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) + 10, bottomWidth - 20, 30)];
        nameTextField.delegate = self;
        nameTextField.returnKeyType = UIReturnKeyDone;
        nameTextField.textAlignment = NSTextAlignmentCenter;
//        textField.placeholder = @"请输入药品名称";
        nameTextField.font = [UIFont systemFontOfSize:13];
        nameTextField.layer.cornerRadius = 8;
        nameTextField.layer.masksToBounds = YES;
        nameTextField.keyboardType = UIKeyboardTypePhonePad;
        nameTextField.layer.borderColor = [UIColor grayColor].CGColor;
        nameTextField.layer.borderWidth = 0.5;
        [_bottomView addSubview:nameTextField];
        
        
        UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.frame = CGRectMake(30,CGRectGetMaxY(nameTextField.frame) + 20, (bottomWidth - 90) / 2, 30);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        cancelButton.layer.borderWidth = 0.5;
        cancelButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        cancelButton.layer.cornerRadius = 5;
        cancelButton.layer.masksToBounds = YES;
        [_bottomView addSubview:cancelButton];
        
        UIButton * okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [okButton addTarget:self action:@selector(chooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        okButton.frame = CGRectMake(bottomWidth/2 + 15,CGRectGetMaxY(nameTextField.frame) + 20, (bottomWidth - 90) / 2, 30);
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        okButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [okButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        okButton.layer.borderWidth = 0.5;
        okButton.layer.borderColor = [UIColor blueColor].CGColor;
        okButton.layer.cornerRadius = 5;
        okButton.layer.masksToBounds = YES;
        [_bottomView addSubview:okButton];
        
        self.hidden = YES;
    }
    return self;
}

//显示视图方法
-(void)showDurgView
{
    
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        [UIView animateWithDuration:during_time animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
            
            CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            [basic setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [basic setFromValue:[NSNumber numberWithFloat:0.1]];
            [basic setToValue:[NSNumber numberWithFloat:1]];
            [basic setDuration:0.4f];
            [basic setDelegate:self];
            
            _bottomView.hidden = NO;
            [_bottomView.layer addAnimation:basic forKey:AnimationKey];
            self.hidden = NO;
        } completion:^(BOOL finished) {
            [nameTextField becomeFirstResponder];
        }];
    });
}

//取消按钮的点击事件
-(void)cancelButtonClick
{
    [nameTextField resignFirstResponder];
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        [UIView animateWithDuration:during_time animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            
            CATransition *transtion = [CATransition animation];
            transtion.duration = 0.4f;
            [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
            [transtion setType:@"suckEffect"];
            _bottomView.hidden = YES;
            self.hidden = YES;
            [transtion setSubtype:kCATransitionFromTop];
            [self.layer addAnimation:transtion forKey:@"transtionKey"];
        }];
    });
}

//button点击事件
-(void)chooseButtonClick:(UIButton *)sender
{
    if (nameTextField.text.length == 0) {
//        [AppDelegate showHUDAndHide:@"请输入条形码数码" view:[AppDelegate appDelegate].window];
        return;
    }
    
    [nameTextField resignFirstResponder];
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        [UIView animateWithDuration:during_time animations:^{
            
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            
            _bottomView.hidden = YES;
            self.hidden = YES;
            
        }completion:^(BOOL finished) {
            if ([_delegate respondsToSelector:@selector(returnDurgNamecode:)]) {
                [self.delegate returnDurgNamecode: nameTextField.text];
            }
        }];
    });
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
//    if (nameTextField.text.length == 0) {
//        [AppDelegate showHUDAndHide:@"请输入条形码数码" view:[AppDelegate appDelegate].window];
//        return NO;
//    }
    if (textField == nameTextField) {
        [nameTextField resignFirstResponder];
    }
    [self chooseButtonClick:nil];
    return YES;
}

@end
