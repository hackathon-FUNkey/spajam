//
//  MessageViewController.m
//  push_de_akushu
//
//  Created by 河辺雅史 on 2015/06/06.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
NSMutableArray *messageArray;
NSArray *positiveMessage;
NSArray *negativeMessage;
int score;
const int maxScore = 30;

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
    score = 0;
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
            score += 5;
        } else {
            NSLog(@"fail");
        }
    }
    for(int i = 0; i < [negativeMessage count]; i++) {
        if([[messageArray objectAtIndex:[messageArray count] - 1] rangeOfString: [negativeMessage objectAtIndex:i]].location != NSNotFound) {
            NSLog(@"succcess");
            score -= 5;
        } else {
            NSLog(@"fail");
        }
    }
    NSLog(@"%d", score);
    [self httpGetComm];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
