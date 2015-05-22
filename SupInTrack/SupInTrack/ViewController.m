//
//  ViewController.m
//  SupInTrack
//
//  Created by Alvin Meimoun on 22/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#import "ViewController.h"

#import "SupinfoServices.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //TEST
    NSError* error;
    [SupinfoServices getCampusesFromSupinfoWebsite:error];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
