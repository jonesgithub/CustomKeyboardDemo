//
//  FirstViewController.m
//  TestCustomKeyboard
//
//  Created by ccf on 13-1-29.
//  Copyright (c) 2013年 ccf. All rights reserved.
//

#import "FirstViewController.h"


#define UpperKeyboardViewHeight         40

@interface FirstViewController (){
    UITextField *_textField;
    UIView *_keyboardView;
    UIView *_coverView;
    
    float _keyboardHeight;
}

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView{
    [super loadView];
    UIView *upperKeyboardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, UpperKeyboardViewHeight)];
    upperKeyboardView.backgroundColor = [UIColor redColor];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake((320 - 100)/2.0, 20, 100, 40)];
    _textField.backgroundColor = [UIColor grayColor];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.inputAccessoryView = upperKeyboardView;
    [self.view addSubview:_textField];
    
    [_textField becomeFirstResponder];
    
    UIButton *showFaceKeyboardBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 60, 30)];
    showFaceKeyboardBtn.backgroundColor = [UIColor grayColor];
    [showFaceKeyboardBtn setTitle:@"表情" forState:UIControlStateNormal];
    [showFaceKeyboardBtn addTarget:self action:@selector(showFaceKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [upperKeyboardView addSubview:showFaceKeyboardBtn];
    
    UIButton *hideFaceKeyboardBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 5, 60, 30)];
    hideFaceKeyboardBtn.backgroundColor = [UIColor grayColor];
    [hideFaceKeyboardBtn setTitle:@"键盘" forState:UIControlStateNormal];
    [hideFaceKeyboardBtn addTarget:self action:@selector(hideFaceKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [upperKeyboardView addSubview:hideFaceKeyboardBtn];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardDidShow:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    _keyboardHeight = keyboardSize.height;
    
    NSArray *windowsArray = [UIApplication sharedApplication].windows;
    for (UIView *tmpWindow in windowsArray) {
        NSArray *viewArray = [tmpWindow subviews];
        for (UIView *tmpView  in viewArray) {
            if ([[NSString stringWithUTF8String:object_getClassName(tmpView)] isEqualToString:@"UIPeripheralHostView"]) {
                _keyboardView = tmpView;
                break;
            }
        }
        
        if (_keyboardView != nil) {
            break;
        }
    }
    
}

- (void)keyboardWillHide:(NSNotification *)noti{
    _keyboardView = nil;
}

#pragma mark - Events
- (void)showFaceKeyboard{
    if (_keyboardView != nil) {
        if (_coverView == nil) {
            _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, UpperKeyboardViewHeight, 320, _keyboardHeight - UpperKeyboardViewHeight)];
            _coverView.backgroundColor = [UIColor redColor];
            [_keyboardView addSubview:_coverView];
        }
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 50, 50)];
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_coverView addSubview:btn];
    }
}

- (void)hideFaceKeyboard{
    if (_coverView != nil) {
        [_coverView removeFromSuperview];
        _coverView = nil;
    }
}

- (void)btnClicked{
    NSLog(@"fsef");
}

@end
