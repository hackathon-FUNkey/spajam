//
//  MessageViewController.h
//  push_de_akushu
//
//  Created by 河辺雅史 on 2015/06/06.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController <UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;


@end
