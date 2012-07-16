//
//  spieleinstellungen.h
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 16.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameController.h"

@interface spieleinstellungen : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *budget;
@property (strong, nonatomic) IBOutlet UISegmentedControl *blindhohe;
@property (strong, nonatomic) IBOutlet UISegmentedControl *blindprorunden;
- (IBAction)budgethohesetzen:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *blindhohesetzen;
@property (strong, nonatomic) IBOutlet UISegmentedControl *blindprorundesetzen;

@end
