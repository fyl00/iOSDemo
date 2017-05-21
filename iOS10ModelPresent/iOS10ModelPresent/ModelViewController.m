//
//  ModelViewController.m
//  iOS10ModelPresent
//
//  Created by SlowWalker on 18/05/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import "ModelViewController.h"

@interface ModelViewController ()


@end

@implementation ModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_dismisButton addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissSelf {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
