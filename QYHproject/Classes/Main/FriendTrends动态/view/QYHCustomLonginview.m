//
//  QYHCustomLonginview.m
//  xibLearn
//
//  Created by hao on 2017/11/25.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHCustomLonginview.h"
#import "QYH.h"
@interface QYHCustomLonginview()
@property (weak, nonatomic) IBOutlet UIButton *myLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *myRegister;

@end
@implementation QYHCustomLonginview
-(void)awakeFromNib
{
    [super awakeFromNib];
    UIImage *RegisterImage = _myRegister.currentBackgroundImage;
    RegisterImage= [RegisterImage stretchableImageWithLeftCapWidth:RegisterImage.size.width * 0.5 topCapHeight:RegisterImage.size.height * 0.5];
    [_myRegister setBackgroundImage:RegisterImage forState:UIControlStateNormal];
    UIImage *image =_myLoginButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height *0.5];
    [_myLoginButton setBackgroundImage:image forState:UIControlStateNormal];

}
+(instancetype)fastLoadLongView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
+(instancetype)fastRegisterView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (IBAction)loginAndRegister:(UIButton *)sender {
    if (sender.tag == 1) {
        [self makeToast:@"登陆成功，功能开发中" duration:3 position:@"bottom"];
    }else{
          [self makeToast:@"注册成功，功能开发中" duration:3 position:nil];
    }
    
}

@end
