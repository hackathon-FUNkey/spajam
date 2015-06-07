//
//  MessageCheckViewController.m
//  push_de_akushu
//
//  Created by Masahiko Hyodo on 2015/06/07.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import "MessageCheckViewController.h"

@interface MessageCheckViewController ()

@end

@implementation MessageCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"http://124.24.56.247/msg_select.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingAllowFragments error:nil];
    //NSLog(@"json:%@",jsonObject);
    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
    
    for(int i = 0;i < [array count];i++){
        NSString *encode_msg = [[array valueForKeyPath:@"msg"] objectAtIndex:i];
        NSLog(@"%@", [encode_msg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    }
    
    //NSString *encode_msg = [[array valueForKeyPath:@"msg"] objectAtIndex:0];
    //NSLog(@"%@", [encode_msg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    
    //NSArray *msg = [jsonObject objectForKey:@"msg"];
    //    NSString *encodedString = [[jsonObject objectForKey:@"msg"] stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    //NSLog(@"%@", msg);
    
    //var jsonData = NSURLConnection.sendSynchronousRequest(jsonRequest,
    //returningResponse: nil, error: nil)
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

@end
