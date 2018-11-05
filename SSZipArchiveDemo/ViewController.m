//
//  ViewController.m
//  SSZipArchiveDemo
//
//  Created by niujf on 2018/11/5.
//  Copyright © 2018年 niujf. All rights reserved.
//

#import "ViewController.h"
#import "NJF_SSUNZip.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image = [NJF_SSUNZip getImageWithImageName:@"photo1.png"];
    NSLog(@"获取到的图片：%@",image);
}


@end
