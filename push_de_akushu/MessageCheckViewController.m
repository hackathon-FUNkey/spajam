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
@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    mtArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"http://124.24.56.247/msg_select.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
    
    for(int i = 0;i < [array count];i++){
        NSString *encode_msg = [[array valueForKeyPath:@"msg"] objectAtIndex:i];
      //  NSLog(@"%@", [encode_msg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        [mtArray addObject:[encode_msg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    NSLog(@"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    
    // iOS6/7表示領域ズレの修正
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0f){
        for(UIView *sub in [[self view] subviews]){
            if( [NSStringFromClass([sub class]) isEqualToString:@"UINavigationBar"] ){
                [sub setFrame:CGRectMake(sub.frame.origin.x, sub.frame.origin.y, sub.frame.size.width, sub.frame.size.height+20)];
            }else{
                [sub setFrame:CGRectMake(sub.frame.origin.x, sub.frame.origin.y+20, sub.frame.size.width, sub.frame.size.height-20)];
            }
        }
    }
    
    // Do any additional setup after loading the view.
    myTableView.dataSource=self;
    myTableView.delegate=self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 * 指定されたセクションの項目数を返す
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return [mtArray count];
            break;
        default:
            break;
    }
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 * 指定されたセクションのセクション名を返す
 */
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSLog(@"%@",[mtArray objectAtIndex:2]);
    switch (section) {
        case 0:
        {
            CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
            UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 44.0)];
            
            // Add the label
            UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0, 300.0, 60.0)];
            headerLabel.backgroundColor = [UIColor clearColor];
            headerLabel.text = @"へっだー";
            headerLabel.textColor = [UIColor blackColor];
            headerLabel.highlightedTextColor = [UIColor whiteColor];
            
            //this is what you asked
            headerLabel.font = [UIFont systemFontOfSize:14];
            
            headerLabel.shadowColor = [UIColor clearColor];
            headerLabel.shadowOffset = CGSizeMake(0.0, 1.0);
            headerLabel.numberOfLines = 0;
            [headerView addSubview: headerLabel];
            
            // Return the headerView
            return headerView;
            break;
        }
        default:
            return nil;
            break;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 60;
            break;
        default:
            return 30;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier =@"Cell";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    switch (indexPath.section) {
        case 0:
            for (int p=0;p<=[mtArray count];p++) {
                if(indexPath.row == p) {
                    cell.textLabel.text = [mtArray objectAtIndex:p];
                    
                }
            }
            
        
            break;
        default:
            break;
    }
    
    //    cell.textLabel.text=[NSString stringWithFormat:@"行=%d", indexPath.row];
    return cell;
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
