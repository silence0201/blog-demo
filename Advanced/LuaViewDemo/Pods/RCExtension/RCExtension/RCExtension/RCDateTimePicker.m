//
//  RCDateTimePicker.m
//  HaitaoERP
//
//  Created by Developer on 15/7/13.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//

#import "RCDateTimePicker.h"


#define currentMonth [currentMonthString integerValue]

@interface RCDateTimePicker()<UIPickerViewDelegate,UIPickerViewDataSource>

@end
@implementation RCDateTimePicker
{
    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *DaysArray;
//    NSArray *amPmArray;
    NSArray *hoursArray;
    NSMutableArray *minutesArray;
    
    NSString *currentMonthString;
    
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    NSInteger selectedDayRow;
    
    BOOL firstTimeLoad;
    UIControl *control;
}
- (id)init {
    CGRect screen_bounds = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:screen_bounds];
    if (self) {
        control = [[UIControl alloc]initWithFrame:screen_bounds];
        control.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        [self addSubview:control];
        [self configDatePicker];
        [self configToobar];
        [control addTarget:self action:@selector(actionCancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)actionCancel:(id)sender {
    [self removeFromSuperview];
}
- (void)actionConfirm:(id)sender {
    if ([self.delegate respondsToSelector:@selector(picker:didSelectedTime:)]) {
        NSString *date = [NSString stringWithFormat:@"%d-%.2d-%.2d %.2d:%.2d",
                                                    (int)[_picker selectedRowInComponent:0] + 1970,
                                                    (int)[_picker selectedRowInComponent:1]%12 + 1,
                                                    (int)[_picker selectedRowInComponent:2]+1,
                                                    (int)[_picker selectedRowInComponent:3]%24,
                                                    (int)[_picker selectedRowInComponent:4]%60];
        
        [self.delegate picker:self didSelectedTime:date];
    }
    [self removeFromSuperview];
}
- (void)configToobar {
    CGRect screen_bounds = [[UIScreen mainScreen] bounds];
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(screen_bounds)- 230, screen_bounds.size.width, 40)];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    UIBarButtonItem *itemDone  = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(actionConfirm:)];
    UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(actionCancel:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:itemCancel, space, itemDone, nil]];
    [control insertSubview:toolbar aboveSubview:_picker];
}
- (void)configDatePicker {
    CGRect screen_bounds = [[UIScreen mainScreen] bounds];
    _picker = [[UIPickerView alloc]init];
    _picker.backgroundColor = [UIColor whiteColor];
    _picker.frame = CGRectMake(0, screen_bounds.size.height-216, screen_bounds.size.width, 216);
    [control addSubview:_picker];
    firstTimeLoad = YES;
    _picker.delegate = self;
    NSDate *date = [NSDate date];
    
    // Get Current Year
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:date]];
    
    
    // Get Current  Month
    [formatter setDateFormat:@"MM"];
    currentMonthString = [NSString stringWithFormat:@"%d",[[formatter stringFromDate:date] intValue]];
    // Get Current  Date
    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    // Get Current  Hour
    [formatter setDateFormat:@"HH"];
    NSString *currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    // Get Current  Minutes
    [formatter setDateFormat:@"mm"];
    NSString *currentMinutesString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    // Get Current  AM PM
    
//    [formatter setDateFormat:@"a"];
//    NSString *currentTimeAMPMString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    // PickerView -  Years data
    
    yearArray = [[NSMutableArray alloc]init];
    
    
    for (int i = 1970; i <= 2050 ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    
    // PickerView -  Months data
    
    
    monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    
    
    // PickerView -  Hours data
    
    
    hoursArray = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
    
    
    // PickerView -  Hours data
    
    minutesArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 60; i++)
    {
        
        [minutesArray addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }
    
    
    // PickerView -  AM PM data
    
//    amPmArray = @[@"AM",@"PM"];
    
    
    
    // PickerView -  days data
    
    DaysArray = [[NSMutableArray alloc]init];
    
    for (int i = 1; i <= 31; i++)
    {
        [DaysArray addObject:[NSString stringWithFormat:@"%.2d",i]];
        
    }
    
    
    // PickerView - Default Selection as per current Date
    
    [_picker selectRow:[yearArray indexOfObject:currentyearString] inComponent:0 animated:YES];
    
    [_picker selectRow:[monthArray indexOfObject:currentMonthString] + 24  inComponent:1  animated:YES];
    
    [_picker selectRow:[DaysArray indexOfObject:currentDateString] inComponent:2 animated:YES];
    
    [_picker selectRow:[hoursArray indexOfObject:currentHourString]+48 inComponent:3 animated:YES];
    
    [_picker selectRow:[minutesArray indexOfObject:currentMinutesString]+120 inComponent:4 animated:YES];

    
//    [_picker selectRow:[amPmArray indexOfObject:currentTimeAMPMString] inComponent:5 animated:YES];
    

    
    
}


#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    if (component == 0)
    {
        selectedYearRow = row;
        [_picker reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [_picker reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        
        [_picker reloadAllComponents];
        
    }
    [self checkDateAvailable];
}
- (void)checkDateAvailable {
    if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
    {
        // do nothing
    }
    else if (selectedMonthRow%12 == 1)
    {
        int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
        
        if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
            if (selectedDayRow > 28) {
                [_picker selectRow:28 inComponent:2 animated:YES];
            }
        }
        else
        {
            if (selectedDayRow > 27) {
                [_picker selectRow:27 inComponent:2 animated:YES];
            }
        }
        
    }
    else
    {
        if (selectedDayRow > 29) {
            [_picker selectRow:29 inComponent:2 animated:YES];
        }
    }
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect screen_bounds = [[UIScreen mainScreen] bounds];
        CGFloat width = (screen_bounds.size.width -20)/5;
        CGRect frame = CGRectMake(0.0, 0.0, width, 40);
        if (component == 0 ) {
            frame.size.width = width + 20;
        }
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:17.0f]];
    }
    
    if (component == 0)
    {
        pickerLabel.text = [NSString stringWithFormat:@"%@年",[yearArray objectAtIndex:row]]; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text =  [NSString stringWithFormat:@"%@月", [monthArray objectAtIndex:row % 12]];  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [NSString stringWithFormat:@"%@日", [DaysArray objectAtIndex:row]]; // Date
        
    }
    else if (component == 3)
    {
        pickerLabel.text =  [NSString stringWithFormat:@"%@时", [hoursArray objectAtIndex:row % 24]]; // Hours
    }
    else if (component == 4)
    {
        pickerLabel.text =  [NSString stringWithFormat:@"%@分", [minutesArray objectAtIndex:row % 60]]; // Mins
    }
//    else
//    {
//        pickerLabel.text =  [amPmArray objectAtIndex:row]; // AM/PM
//    }
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 5;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    else if (component == 1)
    {
        return [monthArray count]*10;
    }
    else if (component == 2)
    { // day
        
        if (firstTimeLoad)
        {
            if (currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12)
            {
                return 31 ;
            }
            else if (currentMonth == 2)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    
                    return 29 ;
                }
                else
                {
                    return 28 ; // or return 29
                }
                
            }
            else
            {
                return 30 ;
            }
            
        }
        else
        {
            
            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
            {
                return 31 ;
            }
            else if (selectedMonthRow == 1)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29 ;
                }
                else
                {
                    return 28 ; // or return 29
                }
                
                
                
            }
            else
            {
                return 30 ;
            }
            
        }
        
        
    }
    else if (component == 3)
    { // hour
        
        return 24 * 10;
        
    }
    else if (component == 4)
    { // min
        return 60 * 10;
    }
//    else
//    { // am/pm
//        return 2;
//        
//    }
    
    return 0;
    
}


@end
