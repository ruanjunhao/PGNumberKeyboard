//
//  PGNumberKeyboard.m
//  edetection
//
//  Created by piggybear on 2017/6/29.
//  Copyright © 2017年 piggybear. All rights reserved.
//

#import "PGNumberKeyboard.h"
#define keyboardScreenWidth   [UIScreen mainScreen].bounds.size.width
#define keyboardScreenHeight  [UIScreen mainScreen].bounds.size.height
#define keyboardColor(r,g,b) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f]

@implementation PGNumberKeyboard

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor greenColor];
        self.frame = CGRectMake(0, keyboardScreenHeight - 150, keyboardScreenHeight, 150);
        [self setupKeyBoard];
    }
    return self;
}

- (void)setupKeyBoard {
    self.frame=CGRectMake(0, keyboardScreenHeight-243, keyboardScreenWidth, 243);
    int space = 1;
    NSInteger leftSpace = 1;
    for (int i=0; i< 9; i++) {
        NSString *str=[NSString stringWithFormat:@"%d",i+1];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        if (i<3) {
            button.frame=CGRectMake(i%3*(keyboardScreenWidth/4)+leftSpace, i/3*61, keyboardScreenWidth/4-1, 60);
        }
        else{
            button.frame=CGRectMake(i%3*(keyboardScreenWidth/4)+leftSpace, i/3*60+i/3*space, keyboardScreenWidth/4-1, 60);
        }
        button.backgroundColor=[UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:24];
        [button setTitle:str forState:UIControlStateNormal];
        button.tag = i + 1;
        [button addTarget:self action:@selector(keyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 0 || i == 3 || i == 6) {
            button.frame=CGRectMake(0, button.frame.origin.y, button.frame.size.width + 1, button.frame.size.height);
        }
        [self mapButton:i button:button];
    }
    
    UIButton *dotButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dotButton.frame=CGRectMake(0, 60*3+3 ,keyboardScreenWidth/4, 60);
    dotButton.backgroundColor=[UIColor whiteColor];
    [dotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    dotButton.titleLabel.font=[UIFont systemFontOfSize:24];
    [dotButton addTarget:self action:@selector(keyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
    [dotButton setTitle:@"." forState:UIControlStateNormal];
    dotButton.tag = 11;
    [self addSubview:dotButton];
    self.dotButton = dotButton;
    
    UIButton *zeroButton = [UIButton buttonWithType:UIButtonTypeSystem];
    zeroButton.frame = CGRectMake(keyboardScreenWidth/4+1*space,60*3+3, keyboardScreenWidth/4-1, 60);
    zeroButton.backgroundColor = [UIColor whiteColor];
    [zeroButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zeroButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [zeroButton setTitle:@"0" forState:UIControlStateNormal];
    zeroButton.tag = 0;
    [zeroButton addTarget:self action:@selector(keyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:zeroButton];
    self.zeroButton = zeroButton;
    
    UIButton *minusButton=[UIButton buttonWithType:UIButtonTypeSystem];
    minusButton.frame=CGRectMake(keyboardScreenWidth/4*2+space,60*3+3, keyboardScreenWidth/4-1, 60);
    minusButton.backgroundColor=[UIColor whiteColor];
    [minusButton setTitle:@"-" forState:UIControlStateNormal];
    [minusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    minusButton.tag=12;
    [minusButton addTarget:self action:@selector(keyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:minusButton];
    self.minusButton = minusButton;
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    deleteButton.backgroundColor = [UIColor redColor];
    deleteButton.frame=CGRectMake(keyboardScreenWidth/4*3 + space, 0, keyboardScreenWidth/4, 122);
    [deleteButton addTarget:self action:@selector(keyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
    deleteButton.tag=10;
    UIImageView *deleteImage=[[UIImageView alloc]initWithFrame:CGRectMake((keyboardScreenWidth/4-1 - 28) * 1.0 / 2, 50, 28, 20)];
    deleteImage.image=[UIImage imageNamed:@"keyboardDelete"];
    [deleteButton addSubview:deleteImage];
    [self addSubview:deleteButton];
    self.deleteButton = deleteButton;
    
    UIButton *confirmbutton=[UIButton buttonWithType:UIButtonTypeSystem];
    confirmbutton.frame=CGRectMake(keyboardScreenWidth/4*3 + space, 61*2, keyboardScreenWidth/4, 122);
    confirmbutton.backgroundColor = [UIColor grayColor];
    [confirmbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmbutton.titleLabel.font=[UIFont systemFontOfSize:20];
    [confirmbutton setTitle:@"确 定" forState:UIControlStateNormal];
    [confirmbutton addTarget:self action:@selector(keyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
    confirmbutton.tag=13;
    [self addSubview:confirmbutton];
    self.confirmButton = confirmbutton;
}

- (void)mapButton:(NSInteger)index button:(UIButton *)button {
    switch (index) {
        case 0:
            self.oneButton = button;
            break;
        case 1:
            self.twoButton = button;
            break;
        case 2:
            self.threeButton = button;
            break;
        case 3:
            self.fourButton = button;
            break;
        case 4:
            self.fiveButton = button;
            break;
        case 5:
            self.sixButton = button;
            break;
        case 6:
            self.sevenButton = button;
            break;
        case 7:
            self.eightButton = button;
            break;
        case 8:
            self.nineButton = button;
            break;
            
        default:
            break;
    }
}

- (void)keyBoardAction:(UIButton *)sender {
    UIButton* btn = (UIButton*)sender;
    
    NSInteger number = btn.tag;
    
    if (nil == _delegate) {
        return;
    }
    if (number <= 9 && number >= 0) { // 0 - 9数字
        [_delegate numberKeyBoard:number];
        return;
    }
    
    if (10 == number) { //删除
        [_delegate cancelKeyBoard];
        return;
    }
    if (11 == number) { //点
        [_delegate periodKeyBoard];
        return;
    }
    if (12 == number) { //负号
        [_delegate minusKeyBoard];
        return;
    }
    
    if (13 == number) { //确定
        [_delegate finishKeyBoard];
        return;
    }
}

@end
