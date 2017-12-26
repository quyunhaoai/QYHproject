//
//  AlterView.m
//  aaa
//
//  Created by 云书网 on 2017/12/5.
//  Copyright © 2017年 云书网. All rights reserved.
//

#import "QyhAlterView.h"
#import "JKCountDownButton.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;

@interface QyhAlterView ()
@property(nonatomic,assign)NSInteger secondsCountDown;
@property (nonatomic,strong)NSTimer* countDownTimer;
@property (weak, nonatomic) IBOutlet UIView *alterBg_view;
@property (weak, nonatomic) IBOutlet UIImageView *statueIcon_image;
@property (weak, nonatomic) IBOutlet UILabel *statueDec_lab;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet JKCountDownButton *continueBtn;
@property (weak, nonatomic) IBOutlet UIView *alterAlpha_view;
@property (weak, nonatomic) IBOutlet UILabel *countDown_Lab;
@property (assign, nonatomic) BOOL isContinue;
@end
@implementation QyhAlterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (QyhAlterView *)sharedView {
    static QyhAlterView *sharedView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedView == nil) {
            sharedView = [[[NSBundle mainBundle] loadNibNamed:@"QyhAlterView" owner:self options:nil] lastObject];
            sharedView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            sharedView.backgroundColor = [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:0.4];
 
        }
    });
    return sharedView;
}



+ (void)showAlterViewStatue:(AlterViewStatue)statue message:(NSString*) message topImageUrl:(NSString*)imageUrl cancelButtonTitle:(NSString*) cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle times:(NSInteger)times onDismiss:(DismissBlock) dismissed onCancel:(CancelBlock) cancelled
{
    [self sharedView].isContinue = NO;
    [[self sharedView] exit];
    _cancelBlock  = [cancelled copy];
    _dismissBlock  = [dismissed copy];
    [UIView animateWithDuration:.3f animations:^{
        [self sharedView].alterBg_view.alpha = 1;
        [self sharedView].alterAlpha_view.alpha = 0.3;
    }];
    [self sharedView].alterBg_view.layer.cornerRadius = 5;
    [self sharedView].alterBg_view.layer.masksToBounds = YES;
    [self sharedView].cancleBtn.layer.cornerRadius = 15;
    [self sharedView].cancleBtn.layer.borderWidth = 1;
    [self sharedView].cancleBtn.layer.borderColor = [UIColor colorWithRed:0.94 green:0.33 blue:0.40 alpha:1].CGColor;
    [self sharedView].cancleBtn.layer.masksToBounds = YES;
    [[self sharedView].cancleBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [self sharedView].continueBtn.layer.cornerRadius = 15;
    [self sharedView].continueBtn.layer.masksToBounds = YES;
    [[self sharedView].continueBtn setTitle:otherButtonTitle forState:UIControlStateNormal];
    if (statue == COUNTDOWN)
    {
        [self sharedView].statueDec_lab.text = message;
        [self sharedView].statueIcon_image.hidden = YES;
        [self sharedView].countDown_Lab.hidden = NO;
        [self sharedView].countDown_Lab.text = [NSString stringWithFormat:@"%lds",(long)times];
        [[self sharedView] countDown:times];
    }
    else
    {
        
        [[self sharedView].continueBtn startCountDownWithSecond:times];
        
        [[self sharedView].continueBtn countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"%@(%zd)",otherButtonTitle,second];
            return title;
        }];
        [[self sharedView].continueBtn countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            if (![self sharedView].isContinue) {
               [[self sharedView] cancel];
            }
            return [NSString stringWithFormat:@"%@(%ld)",otherButtonTitle,(long)times];
            
        }];
        
        [self sharedView].countDown_Lab.hidden = YES;
        [self sharedView].statueIcon_image.hidden = NO;
        [self sharedView].statueIcon_image.image = [UIImage imageNamed:imageUrl];
        if (statue == NORMALSTYLE)
        {
            [self sharedView].statueDec_lab.text = message;
        }
        else if(statue == SHOWORIGIN)
        {
            NSString* statueDec = [NSString stringWithFormat:@"●●● %@ ●●●",message];
            NSMutableAttributedString *statueDecAttri = [[NSMutableAttributedString alloc] initWithString:statueDec];
            
            [[self sharedView] setOriginAttri:statueDecAttri Color:[UIColor colorWithRed:0.80 green:0.55 blue:0.71 alpha:1] range:NSMakeRange(0,1)];
            [[self sharedView] setOriginAttri:statueDecAttri Color:[UIColor colorWithRed:0.23 green:0.48 blue:0.70 alpha:1] range:NSMakeRange(1,1)];
            
            [[self sharedView] setOriginAttri:statueDecAttri Color:[UIColor colorWithRed:0.53 green:0.85 blue:0.79 alpha:1] range:NSMakeRange(2,1)];
            
            [[self sharedView] setOriginAttri:statueDecAttri Color:[UIColor colorWithRed:0.80 green:0.55 blue:0.71 alpha:1] range:NSMakeRange([statueDec length]-3,1)];
            [[self sharedView] setOriginAttri:statueDecAttri Color:[UIColor colorWithRed:0.23 green:0.48 blue:0.70 alpha:1] range:NSMakeRange([statueDec length]-2,1)];
            [[self sharedView] setOriginAttri:statueDecAttri Color:[UIColor colorWithRed:0.53 green:0.85 blue:0.79 alpha:1] range:NSMakeRange([statueDec length]-1,1)];
            [self sharedView].statueDec_lab.attributedText =statueDecAttri;
        }
    }
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:[self sharedView]];
}
-(void)setOriginAttri:(NSMutableAttributedString*)statueDecAttri  Color:(UIColor*)color range:(NSRange)rangge
{
    [statueDecAttri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15.0] range:rangge];
    [statueDecAttri addAttribute:NSForegroundColorAttributeName value:color range:rangge];
}
-(void)exit
{
    //判断是否有定时器
    if (self.countDownTimer)
   {
        [self.countDownTimer invalidate];
    }
    [self removeFromSuperview];
    
//    [UIView animateWithDuration:.3f animations:^{
//       self.alterBg_view.alpha = 0;
//       self.alterAlpha_view.alpha = 0 ;
//    }];
//    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.3f];
//    [self.alterAlpha_view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.3f];
}
- (IBAction)cancleBtn:(id)sender
{
    self.isContinue = NO;
    [self cancel];
}
-(void)cancel
{
    [self exit];
    _cancelBlock();
}
- (IBAction)continueBtn:(id)sender
{
    self.isContinue = YES;
    [self exit];
    UIButton* btn = (UIButton*)sender;
   _dismissBlock(btn.tag - 100);
}
-(void)countDown:(NSInteger)time
{
    self.secondsCountDown = time;
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Resetcaptcha) userInfo:nil repeats:YES];
}
-(void) Resetcaptcha
{
    self.secondsCountDown--;
    self.countDown_Lab.text =[NSString stringWithFormat:@"%lds",self.secondsCountDown];
    if(self.secondsCountDown <= 0){
        [self cancel];
    }
}
@end
