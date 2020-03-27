//
//  ViewController.m
//  数字小数点正则
//
//  Created by xuzhiyong on 2020/3/27.
//  Copyright © 2020 xxx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<
UITextFieldDelegate
>
{
    BOOL isHavePoint;
    BOOL isHaveZero;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(moneyTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    NSLog(@"收起键盘 = %@",self.textField.text);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"shouldChangeCharactersInRange");
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound) { isHavePoint = NO; }
    if ([textField.text rangeOfString:@"0"].location == NSNotFound) { isHaveZero = NO; }
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0]; //当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') { //数据格式正确
            if ([textField.text length] == 0) { //首字母不能为0和小数点
                if (single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    NSLog(@"第一个数字不能为小数点!");
                    return NO;
                }
            }
            if (single == '.') { //输入的字符是否是小数点
                if (!isHavePoint) { //text中还没有小数点
                    isHavePoint = YES;
                    return YES;
                } else {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    NSLog(@"已经输入过小数点了!");
                    return NO;
                }
            }
        }
        return YES;
    }
    else {
        return YES;
    }
    
}
-(void)moneyTextFieldDidChange:(UITextField *)theTextField{
    NSString *str = [theTextField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSLog(@"str = %@",str);
    
    if (str.length >= 2) {
        NSString *sencondStr = [str substringWithRange:NSMakeRange(1,1)];
        NSString *firstStr = [str substringWithRange:NSMakeRange(0,1)];
        if ([firstStr isEqualToString:@"0"]&&
            [sencondStr isEqualToString:@"0"]) { // 000 -> 0
            str = @"0";
            theTextField.text = str;
        }
        else if ([sencondStr isEqualToString:@"."]) {
            
        }
        else {
            if ([firstStr isEqualToString:@"0"]) { // 0111 -> 111
                str = sencondStr;
                theTextField.text = sencondStr;
            }
        }
    }
    if (str.length >= 8) { // 限限制最多8位
        NSString *eightStr = [str substringWithRange:NSMakeRange(0,8)];
        str = eightStr;
        theTextField.text = eightStr;
        NSLog(@"最多输入8位数");
//        CGFloat strFloat = [str floatValue];
//        NSLog(@"strFloat = %f",strFloat);
    }

}

@end
