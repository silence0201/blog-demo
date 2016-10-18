//
//  ViewController.m
//  JSCoreDemo
//
//  Created by 杨晴贺 on 23/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *resultLabel;
@property (weak, nonatomic) IBOutlet UITextView *javascriptText;
@property (weak, nonatomic) IBOutlet UITextField *argumentText;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.javascriptText.text = [self loadJsFromFile] ;
    [self runjs] ;
}

- (NSString *)loadJsFromFile{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"greet" ofType:@"js"] ;
    NSString *jsScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] ;
    return jsScript ;
}

#pragma mark - 运行js代码
- (void)runjs{
    JSContext *context = [[JSContext alloc]init] ;
    [context evaluateScript:self.javascriptText.text] ;
    JSValue *function = context[@"greet"] ;
    JSValue *result = [function callWithArguments:@[self.argumentText.text]] ;
    self.resultLabel.text = [result toString] ;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self runjs];
}

- (IBAction)argumentValueEditingChanged:(id)sender {
    [self runjs];
}


@end
