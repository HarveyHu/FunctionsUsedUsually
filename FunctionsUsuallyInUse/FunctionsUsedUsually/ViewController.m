//
//  ViewController.m
//  FunctionsUsedUsually
//
//  Created by HarveyHu on 2014/3/27.
//  Copyright (c) 2014年 HarveyHu. All rights reserved.
//

#import "ViewController.h"
#import "UsefulMethods.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 320, 20)];
    label.attributedText = [UsefulMethods onSaleString];
    [self.view addSubview:label];
    
    NSLog(@"%@",[UsefulMethods formatNumberWithComma:@12132.678]);
    
    NSLog(@"1111 MD5 :%@",[UsefulMethods MD5:@"1111"]);
    
    NSLog(@"現在時刻:%@",[UsefulMethods formatedDate:[NSDate date] dateFormat:@"yyyy-MMM-dd"]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
