//
//  InGameController.m
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InGameController.h"


@interface InGameController ()

@end

@implementation InGameController

- (void)viewDidLoad
{
    [super viewDidLoad];
	texas =[[TexasHolemGame alloc]init];
    // Do any additional setup after loading the view.
    CGRect frame;
	frame.origin.x = 50;
	frame.origin.y = 50;
	frame.size.width = 50;
	frame.size.height = 50;
    spieler=[texas players];
    einsatzSp1=[[UILabel alloc] initWithFrame:frame];
	[self.view addSubview:einsatzSp1];
    [einsatzSp1 setBackgroundColor:[UIColor clearColor]];
    einsatzSp1.text=@"dead'n'gone";
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




@end
