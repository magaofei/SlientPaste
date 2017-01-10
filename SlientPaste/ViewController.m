//
//  ViewController.m
//  SlientPaste
//
//  Created by MAMIAN on 2017/1/10.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITextView *pasteTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextView *pasteTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 150, 220, 70)];
    [self.view addSubview:pasteTextView];
    self.pasteTextView = pasteTextView;
    
    pasteTextView.text = @"剪贴板的内容";
    pasteTextView.font = [UIFont systemFontOfSize:17];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pasteBoardChanged) name:UIPasteboardChangedNotification object:nil];
    
    
}

- (void)pasteBoardChanged {
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    self.pasteTextView.text = [pasteBoard string];
    [self.pasteTextView sizeToFit];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
