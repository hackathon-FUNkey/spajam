//
//  MessageViewController.m
//  push_de_akushu
//
//  Created by 河辺雅史 on 2015/06/06.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import "MessageViewController.h"
#import "SVProgressHUD.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
NSMutableArray *messageArray;
NSArray *positiveMessage;
NSArray *negativeMessage;
int score;
const int maxScore = 10;
NSArray *imageArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTextField.delegate = self;
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    messageArray = [NSMutableArray array];
    positiveMessage = [NSArray arrayWithObjects:@"ごめん", @"反省", @"仲直り", @"和解", nil];
    negativeMessage = [NSArray arrayWithObjects:@"嫌い", @"ない", @"ムカつく", @"この野郎", nil];
    score = 9;
    
    imageArray = [NSArray arrayWithObjects:@"move_hand00.png", @"move_hand01.png", @"move_hand02.png", @"move_hand03.png", @"move_hand04.png", @"move_hand05.png", nil];
    
    //UIImageを格納するNSMutableArrayを確保
    NSMutableArray *uiImageArray = [NSMutableArray array];
    //_imageArrayのイメージをuiImageArrayに追加
    for(NSString *imageStr in imageArray) {
        [uiImageArray addObject:[UIImage imageNamed:imageStr]];
    }
    
    //self.myImageView.image = [UIImage imageNamed:@"move_hands00.png"];
    
    //uiImageArrayを_imageView.animationImagesにセット
    self.myImageView.animationImages = uiImageArray;
    self.myImageView.animationRepeatCount = 0;
    self.myImageView.animationDuration = 1;
    self.myImageView.userInteractionEnabled = YES;
    [self.myImageView startAnimating];
    
    [self showGuageImage];
}

- (BOOL)textFieldShouldReturn:(UITextField *)targetTextField {
    [self.myTextField resignFirstResponder];
    [messageArray addObject:self.myTextField.text];
    //    for(int i=0; i<[messageArray count]; i++) {
    //        NSLog([messageArray objectAtIndex:i]);
    //    }
    for(int i = 0; i < [positiveMessage count]; i++) {
        if([[messageArray objectAtIndex:[messageArray count] - 1] rangeOfString: [positiveMessage objectAtIndex:i]].location != NSNotFound) {
            NSLog(@"succcess");
            score += 1;
            if(score>=maxScore){
                [self sendEmailInBackground];
            }
        } else {
            NSLog(@"fail");
        }
    }
    for(int i = 0; i < [negativeMessage count]; i++) {
        if([[messageArray objectAtIndex:[messageArray count] - 1] rangeOfString: [negativeMessage objectAtIndex:i]].location != NSNotFound) {
            NSLog(@"succcess");
            score -= 1;
        } else {
            NSLog(@"fail");
        }
    }
    NSLog(@"%d", score);
    [self httpGetComm];
    [self showGuageImage];
    
    return YES;
}

-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.myTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpGetComm {
    NSString *urlAsString = @"http://124.24.56.247/msg_insert.php";
    //urlAsString = [urlAsString
    //stringByAppendingString:@"?title=test1"];
    NSString *message = [NSString stringWithFormat:@"?message=%@", self.myTextField.text];
    NSString *after_message = [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    urlAsString = [urlAsString stringByAppendingString:after_message];
    NSLog(urlAsString);
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    NSLog(@"GET");
    [NSURLConnection
     sendSynchronousRequest:urlRequest
     returningResponse:nil error:nil];
    //[[UIApplication sharedApplication] openURL:url];
}

- (void)showGuageImage {
    for(int i = 0;i < 10;i++){
        if(score == i){
            NSString *imageName = [NSString stringWithFormat:@"gage0%d.png", i];
            self.guageImageView.image = [UIImage imageNamed:imageName];
        }
    }
}

-(void) sendEmailInBackground
{
    NSLog(@"Start Sending");
    [SVProgressHUD show];
    [SVProgressHUD showWithStatus:@"メール送信中・・・" maskType:SVProgressHUDMaskTypeGradient];

    SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
    emailMessage.fromEmail = @"pushdeakushu@gmail.com"; //送信者メールアドレス（Gmailのアカウント）
    emailMessage.toEmail = @"b1012187@fun.ac.jp";                //宛先メールアドレス
    // emailMessage.toEmail = email;                //宛先メールアドレス
    
    //emailMessage.ccEmail =@"cc@address";             //ccメールアドレス
    //emailMessage.bccEmail =@"bcc@address";         //bccメールアドレス
    emailMessage.requiresAuth = YES;
    emailMessage.relayHost = @"smtp.gmail.com";
    emailMessage.login = @"pushdeakushu@gmail.com";         //ユーザ名（Gmailのアカウント）
    emailMessage.pass = @"funkey123";                       //パスワード（Gmailのアカウント）
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
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"メール送信完了"];
}

// 送信エラー時にCallされる（エラー時の処理をコーディングする）
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    NSLog(@"Gmail送信失敗 - error(%d): %@", [error code], [error localizedDescription]);
    //アラート表示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gmail送信失敗!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}





/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
