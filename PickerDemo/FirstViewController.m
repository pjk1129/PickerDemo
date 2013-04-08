//
//  FirstViewController.m
//  PickerDemo
//
//  Created by JK.Peng on 13-3-22.
//  Copyright (c) 2013年 njut. All rights reserved.
//

#import "FirstViewController.h"
#import "QBActionSheet.h"

#define kTagActionSheetForAge       1
#define kTagActionSheetForSex       2

@interface FirstViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, retain) QBActionSheet    *ageActionSheet;
@property (nonatomic, retain) QBActionSheet    *sexActionSheet;

@end

@implementation FirstViewController
@synthesize ageActionSheet = _ageActionSheet;
@synthesize sexActionSheet = _sexActionSheet;
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPicker:(id)sender {
    [self.ageActionSheet show];
}

- (IBAction)picker:(id)sender {
    [self.sexActionSheet show];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"actionSheet: %@ \n buttonIndex: %d",actionSheet,buttonIndex);

    if (buttonIndex == 0) {
        return;
    }
    
    //You can uses location to your application.
    if (actionSheet == _ageActionSheet) {
        NSLog(@"==========_ageActionSheet=============");
        UIDatePicker *datePicker = (UIDatePicker *)[_ageActionSheet viewWithTag:kTagActionSheetForAge];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString  *dateStr = [dateFormatter stringFromDate:[datePicker date]];
        [dateFormatter release];
        
        NSArray   *array = [dateStr componentsSeparatedByString:@"-"];
        NSLog(@"array: %@",array);
        
    }else if (actionSheet == _sexActionSheet){
        NSLog(@"==========_sexActionSheet=============");
        
        UIPickerView *picker = (UIPickerView *)[_sexActionSheet viewWithTag:kTagActionSheetForSex];
        NSInteger  selectedRow = [picker selectedRowInComponent:0];
        NSLog(@"selectedRow: %d",selectedRow);
    }
    
}

#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return 2;
}

#pragma mark Picker Delegate Methods
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
    genderLabel.text = [row == 0 ? NSLocalizedString(@"男", @"") : NSLocalizedString(@"女", @"") uppercaseString];
    genderLabel.textAlignment = UITextAlignmentCenter;
    genderLabel.backgroundColor = [UIColor clearColor];
    genderLabel.font = [UIFont systemFontOfSize:18.0f];
    
    UIView *rowView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 32)] autorelease];
    
    [rowView addSubview:genderLabel];
    [genderLabel release];
    
    return rowView;
}

#pragma mark - getter
- (QBActionSheet *)ageActionSheet{
    if (!_ageActionSheet) {
        _ageActionSheet = [[QBActionSheet alloc] initWithTitle:@"日期选择" delegate:self];
        UIDatePicker  *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.tag = kTagActionSheetForAge;
        [_ageActionSheet addSubview:datePicker];
        [datePicker release],datePicker = nil;
    }
    return _ageActionSheet;
}

- (QBActionSheet *)sexActionSheet{
    if (!_sexActionSheet) {
        _sexActionSheet = [[QBActionSheet alloc] initWithTitle:@"性别选择" delegate:self];
        UIPickerView  *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
        pickerView.tag = kTagActionSheetForSex;
        pickerView.delegate = self;
        pickerView.dataSource = self;
        pickerView.showsSelectionIndicator = YES;
        [_sexActionSheet addSubview:pickerView];
        [pickerView release],pickerView = nil;
    }
    return _sexActionSheet;
}

- (void)dealloc {
    [_toolBar release];
    [_ageActionSheet release];
    [super dealloc];
}
@end
