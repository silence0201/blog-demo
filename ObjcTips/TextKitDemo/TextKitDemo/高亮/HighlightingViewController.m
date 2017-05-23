//
//  HighlightingViewController.m
//  TextKitDemo
//
//  Created by 杨晴贺 on 2017/5/23.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "HighlightingViewController.h"
#import "HighlightingTextStorage.h"

@interface HighlightingViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation HighlightingViewController{
    HighlightingTextStorage *_textStorage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Replace text storage
    _textStorage = [HighlightingTextStorage new];
    [_textStorage addLayoutManager: self.textView.layoutManager];
    
    // Load iText
    [_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"iText" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
}


@end
