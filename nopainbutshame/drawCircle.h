//
//  View.h
//  testCircle
//
//  Created by Robert Frank on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawCircle : UIView
{
    IBOutlet UILabel *lol;
}

@property (nonatomic,assign) BOOL canDraw;
@property int activeplayer;
@end
