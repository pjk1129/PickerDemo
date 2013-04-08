//
//  FirstViewController.h
//  PickerDemo
//
//  Created by JK.Peng on 13-3-22.
//  Copyright (c) 2013年 njut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
- (IBAction)showPicker:(id)sender;
- (IBAction)picker:(id)sender;
@end
