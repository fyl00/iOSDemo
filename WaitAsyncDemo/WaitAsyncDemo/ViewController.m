//
//  ViewController.m
//  WaitAsyncDemo
//
//  Created by SlowWalker on 13/03/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import "ViewController.h"
#import "WaitAsync.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAlert:)];
    [self.view addGestureRecognizer:tap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"TEST" message:@"TEST" preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
    
- (IBAction)performDefault:(id)sender {
    NSLog(@"💭Perform DEFAULT...");
    [WaitAsync default];
}
    
- (IBAction)performSemaphore:(id)sender {
    NSLog(@"💭Perform SEMAPHORE...");
    [WaitAsync semaphore];
}

- (IBAction)performGroup:(id)sender {
    NSLog(@"💭Perform GROUP...");
    [WaitAsync group];
}

@end
