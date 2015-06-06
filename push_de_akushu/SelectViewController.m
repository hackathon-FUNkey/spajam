//
//  SelectViewController.m
//  push_de_akushu
//
//  Created by 河辺雅史 on 2015/06/06.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void) sendEmailInBackground
{
    NSLog(@"Start Sending");
    SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
    emailMessage.fromEmail = @"ttt.ttt.7733@gmail.com"; //送信者メールアドレス（Gmailのアカウント）
    emailMessage.toEmail = @"b1012187@fun.ac.jp";                //宛先メールアドレス
    //emailMessage.ccEmail =@"cc@address";             //ccメールアドレス
    //emailMessage.bccEmail =@"bcc@address";         //bccメールアドレス
    emailMessage.requiresAuth = YES;
    emailMessage.relayHost = @"smtp.gmail.com";
    emailMessage.login = @"ttt.ttt.7733@gmail.com";         //ユーザ名（Gmailのアカウント）
    emailMessage.pass = @"uwck2u4t";                       //パスワード（Gmailのアカウント）
    //2段階認証プロセスを利用する場合、アプリパスワードを使用する
    emailMessage.subject =@"件名に記載する内容";
    emailMessage.wantsSecure = YES;
    emailMessage.delegate = self;
    NSString *messageBody = @"メール本文に記載する内容";
    NSDictionary *plainMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey, messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    emailMessage.parts = [NSArray arrayWithObjects:plainMsg,nil];
    [emailMessage send];
}

// E-Mail送信成功時にCallされる（成功時の処理をコーディングする）
-(void)messageSent:(SKPSMTPMessage *)message
{
    NSLog(@"Gmail送信完了");
    //アラート表示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gmail送信完了" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

// 送信エラー時にCallされる（エラー時の処理をコーディングする）
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    NSLog(@"Gmail送信失敗 - error(%d): %@", [error code], [error localizedDescription]);
    //アラート表示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gmail送信失敗!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}






- (IBAction)LineButtonAction:(id)sender {
    
    NSString *lineString = @"LINEtest";
    
    NSString *contentKey = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (CFStringRef)lineString,
                                                                                        NULL,
                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                        kCFStringEncodingUTF8 );
    
    NSString *contentType = @"text";
    
    NSString *urlString = [NSString
                           stringWithFormat: @"http://line.naver.jp/R/msg/%@/?%@",
                           contentType, contentKey];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[UIApplication sharedApplication] openURL:url];
    
}

- (IBAction)AdressButtonAction:(id)sender {
    
    [self sendEmailInBackground];
}
@end
