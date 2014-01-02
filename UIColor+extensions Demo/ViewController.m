//
//  ViewController.m
//  UIColor+extensions Demo
//
//  Created by Matthew Inman on 30/12/2013.
//  Copyright (c) 2013 Matthew Inman. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor colorWithGradientColorForTop:[UIColor chocolateColor]
                                                                   bottom:[UIColor beigeColor]
                                                                    frame:[[self view] frame]]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
