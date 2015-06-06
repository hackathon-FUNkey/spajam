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
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>



@interface SelectViewController : UIViewController<SKPSMTPMessageDelegate,ABPeoplePickerNavigationControllerDelegate>{
NSString *email;
}


- (IBAction)LineButtonAction:(id)sender;
- (IBAction)AdressButtonAction:(id)sender;

@end
