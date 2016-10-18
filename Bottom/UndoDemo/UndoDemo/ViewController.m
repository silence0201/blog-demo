//
//  ViewController.m
//  UndoDemo
//
//  Created by 杨晴贺 on 8/26/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSInteger _a ;
    NSUndoManager *_undomanager ;
}
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _undomanager = [[NSUndoManager alloc]init] ;
    _a = 0 ;
}

- (IBAction)method1:(id)sender {
    _a++ ;
    [self setMyObjectTitle:[NSString stringWithFormat:@"%ld",(long)_a]] ;
}

- (IBAction)method2:(id)sender {
    _a++ ;
    [self setMyLabelText:[NSString stringWithFormat:@"%ld",(long)_a]] ;
}

- (IBAction)Undo:(id)sender {
    [_undomanager undo] ;
}


- (IBAction)Redo:(id)sender {
    [_undomanager redo] ;
}

- (void)setMyObjectTitle:(NSString *)newTitle {
    
    NSString *currentTitle = self.numberLabel.text;
    if (newTitle != currentTitle) {
        [_undomanager registerUndoWithTarget:self
                                    selector:@selector(setMyObjectTitle:)
                                      object:self.numberLabel.text];
        [self.numberLabel setText:newTitle];
        _a = [self.numberLabel.text integerValue];
    }
}

-(void)setMyLabelText:(NSString*)newText{
    NSString *currentTitle = self.numberLabel.text;
    if (newText != currentTitle) {
        [[_undomanager prepareWithInvocationTarget:self] setMyLabelText:self.numberLabel.text];
        self.numberLabel.text = newText;
        _a = [newText integerValue];
    }
    
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature * methodSignature  = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    NSLog(@"%s",__func__);
    return methodSignature;
}



@end
