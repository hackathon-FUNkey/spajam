//
//  SelectViewController.h
//  push_de_akushu
//
//  Created by 河辺雅史 on 2015/06/06.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"



@interface SelectViewController : UIViewController<SKPSMTPMessageDelegate>{

}
- (IBAction)LineButtonAction:(id)sender;
- (IBAction)AdressButtonAction:(id)sender;

@end
