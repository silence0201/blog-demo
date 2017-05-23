//
//  ConfigurationViewController.m
//  TextKitDemo
//
//  Created by 杨晴贺 on 2017/5/23.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ConfigurationViewController.h"

@interface ConfigurationViewController ()
@property (weak, nonatomic) IBOutlet UITextView *originalTextView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@end

@implementation ConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载文字
    NSTextStorage *sharedTextStorage = self.originalTextView.textStorage;
    [sharedTextStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"lorem" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
    
    // 创建Text
    NSLayoutManager *otherLayoutManager = [[NSLayoutManager alloc]init] ;
    [sharedTextStorage addLayoutManager:otherLayoutManager] ;
    
    NSTextContainer *otherTextContainer = [[NSTextContainer alloc]init] ;
    [otherLayoutManager addTextContainer:otherTextContainer] ;
    
    UITextView *otherTextView = [[UITextView alloc] initWithFrame:self.secondView.bounds textContainer:otherTextContainer];
    otherTextView.backgroundColor = self.secondView.backgroundColor;
    otherTextView.translatesAutoresizingMaskIntoConstraints = YES;
    otherTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    otherTextView.scrollEnabled = NO;
    
    [self.secondView addSubview: otherTextView];
}

@end
