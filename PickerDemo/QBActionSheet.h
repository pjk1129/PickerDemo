//
//  QBActionSheet.h
//  PickerDemo
//
//  Created by JK.Peng on 13-3-22.
//  Copyright (c) 2013年 njut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBActionSheet : UIActionSheet

- (id)initWithTitle:(NSString *)title delegate:(id)delegate;
- (void)show;

@end
