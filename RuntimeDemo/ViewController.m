//
//  ViewController.m
//  RuntimeDemo
//
//  Created by Chin on 2020/3/27.
//  Copyright © 2020 Chin. All rights reserved.
//

#import "ViewController.h"
#import "Dog.h"
#import "Cat.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Cat *cat = [Cat new];

    [cat performSelector:NSSelectorFromString(@"run")];
    
    [Cat performSelector:NSSelectorFromString(@"sleep")];
}


@end
