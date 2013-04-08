//
//  QBActionSheet.m
//  PickerDemo
//
//  Created by JK.Peng on 13-3-22.
//  Copyright (c) 2013年 njut. All rights reserved.
//

#import "QBActionSheet.h"

#define kDuration 0.3

@interface QBActionSheet()

@property (nonatomic, retain) UIToolbar    *myToolBar;
@property (nonatomic, retain) UIView       *maskView;
@property (nonatomic, retain) UILabel      *lblTitle;
@end

@implementation QBActionSheet
@synthesize myToolBar = _myToolBar;
@synthesize maskView = _maskView;
@synthesize lblTitle = _lblTitle;

- (void)dealloc{
    [_myToolBar release], _myToolBar = nil;
    [_maskView release], _maskView = nil;
    [_lblTitle release], _lblTitle = nil;
    [super dealloc];
}


- (id)initWithTitle:(NSString *)title delegate:(id)delegate{
    
    self = [super initWithFrame:CGRectMake(0, 0, 320, 260)];
    if (self) {
        self.delegate = delegate;
        self.myToolBar.alpha = 0.0f;
        self.lblTitle.text = title?title:@"";
    }
    return self;
}

- (void)show
{
    UIWindow  *keyWindow = [[UIApplication sharedApplication] keyWindow];
    self.maskView.alpha = 0.0f;
    self.maskView.frame = CGRectMake(0, 20, keyWindow.bounds.size.width, keyWindow.bounds.size.height-20);
    [keyWindow addSubview:self.maskView];
    self.frame = CGRectMake(0, self.maskView.bounds.size.height, self.frame.size.width, self.frame.size.height);
    [self.maskView addSubview:self];
        
    [UIView animateWithDuration:kDuration
                     animations:^{
                         [self setAlpha:1.0f];
                         self.frame = CGRectMake(0, self.maskView.bounds.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
                         self.myToolBar.alpha = 1.0f;
                         self.maskView.alpha = 1.0f;

                     } completion:^(BOOL finished) {

                     }];
}

#pragma mark - getter
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectZero];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.3];
    }
    return _maskView;
}

- (UIToolbar *)myToolBar{
    if (!_myToolBar) {
        _myToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        //创建工具栏
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
        UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                       style:UIBarButtonItemStyleDone target:self
                                                                      action:@selector(confirm:)];
        UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                      style:UIBarButtonItemStyleBordered target:self
                                                                     action:@selector(cancel:)];
        [items addObject:cancelBtn];
        [items addObject:flexibleSpaceItem];
        [items addObject:confirmBtn];
        [cancelBtn release];
        [flexibleSpaceItem release];
        [confirmBtn release];

        _myToolBar.barStyle = UIBarStyleBlackTranslucent;
        _myToolBar.items = items;
        [items release],items = nil;
        
        [self addSubview:_myToolBar];
    }
    return _myToolBar;
}

- (UILabel *)lblTitle{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 7, 200, 30)];
        _lblTitle.backgroundColor = [UIColor clearColor];
        _lblTitle.font = [UIFont systemFontOfSize:16.0f];
        _lblTitle.textColor = [UIColor whiteColor];
        _lblTitle.textAlignment = UITextAlignmentCenter;
        [self addSubview:_lblTitle];
    }
    return _lblTitle;
}

#pragma mark - Button lifecycle

- (IBAction)cancel:(id)sender {
    [UIView animateWithDuration:kDuration animations:^{
        self.frame = CGRectMake(0, self.maskView.bounds.size.height, self.frame.size.width, self.frame.size.height);
        [self setAlpha:0.0f];
        self.maskView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        
        if([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
            [self.delegate actionSheet:self clickedButtonAtIndex:0];
        }
    }];
}

- (IBAction)confirm:(id)sender {    
    [UIView animateWithDuration:kDuration animations:^{
        self.frame = CGRectMake(0, self.maskView.bounds.size.height, self.frame.size.width, self.frame.size.height);
        [self setAlpha:0.0f];
        self.maskView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];

        if([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
            [self.delegate actionSheet:self clickedButtonAtIndex:1];
        }
    }];
}
@end
