//
//  LayoutingViewController.m
//  TextKitDemo
//
//  Created by 杨晴贺 on 2017/5/23.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "LayoutingViewController.h"
#import "LinkDetectingTextStorage.h"
#import "OutliningLayoutManager.h"


@interface LayoutingViewController () <NSLayoutManagerDelegate>
{
    // Text storage must be held strongly, only the default storage is retained by the text view.
    LinkDetectingTextStorage *_textStorage;
}
@end

@implementation LayoutingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create componentes
    _textStorage = [LinkDetectingTextStorage new];
    
    NSLayoutManager *layoutManager = [OutliningLayoutManager new];
    [_textStorage addLayoutManager: layoutManager];
    
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize: CGSizeZero];
    [layoutManager addTextContainer: textContainer];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectInset(self.view.bounds, 5, 20) textContainer: textContainer];
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    textView.translatesAutoresizingMaskIntoConstraints = YES;
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    [self.view addSubview: textView];
    
    
    // Set delegate
    layoutManager.delegate = self;
    
    // Load layout text
    [_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"layout" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
}


#pragma mark - Layout

- (BOOL)layoutManager:(NSLayoutManager *)layoutManager shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex
{
    NSRange range;
    NSURL *linkURL = [layoutManager.textStorage attribute:NSLinkAttributeName atIndex:charIndex effectiveRange:&range];
    
    // Do not break lines in links unless absolutely required
    if (linkURL && charIndex > range.location && charIndex <= NSMaxRange(range))
        return NO;
    else
        return YES;
}

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect
{
    return floorf(glyphIndex / 100);
}

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager paragraphSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect
{
    return 10;
}

@end

