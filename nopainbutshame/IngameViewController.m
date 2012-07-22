//
//  IngameViewController.m
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 12.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IngameViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface IngameViewController ()

@end

@implementation IngameViewController

NSString *playerid;
CGPoint startpoint;
UIImage *cardlefttemp;
UIImage *cardrighttemp;
int duhast5sek=5;
bool foldmaybe;


- (void)viewDidLoad
{
    cardlefttemp=[[UIImage alloc] init];
    cardrighttemp=[[UIImage alloc] init];
  //  opencard=[[NSArray alloc] initWithArray:player.twoCards];     
   // opencard1=[[NSString alloc]initWithFormat:@"%i",[opencard objectAtIndex:0]];
    //opencard2=[[NSString alloc]initWithFormat:@"%i",[opencard objectAtIndex:1]];
opencard1 = @"1";
opencard2 = @"3";
    


    CGRect newFrame = CGRectMake(0, 0, 480, 480); // Frame of the view to be animated
    UIView * viewToBeAnimated = [[UIView alloc] initWithFrame:newFrame];
    viewToBeAnimated.backgroundColor = [UIColor clearColor];
    
    // Gesture recognizer for single finger pan (drag) of this view
    UIPanGestureRecognizer *singleFingerPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    singleFingerPanGestureRecognizer.maximumNumberOfTouches = 1;
    [viewToBeAnimated addGestureRecognizer: singleFingerPanGestureRecognizer];
    
    [self.view addSubview:viewToBeAnimated]; 
   
    point= (CGPoint *)malloc(sizeof(const CGPoint));
 
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(binichdran) userInfo:nil repeats:YES];
    
    myChip50Center = CGPointMake(80, 240);
    myChip100Center = CGPointMake(180, 220);
    
    chip50image =[UIImage imageNamed:@"pokerchip50.png"];
    mychip50=[[UIImageView alloc] initWithImage:chip50image];
    [mychip50 setFrame:CGRectMake(30, 190, 100, 100)];
    [[self view]addSubview:mychip50];
    
    chip100image =[UIImage imageNamed:@"pokerchip100.png"];
    mychip100=[[UIImageView alloc] initWithImage:chip100image];
    [mychip100 setFrame:CGRectMake(130, 170, 100, 100)];
    [[self view]addSubview:mychip100];
    
    tempimage =[UIImage imageNamed:@"slidetofold.png"];
    slidetofold=[[UIImageView alloc] initWithImage:tempimage];
    [slidetofold setFrame:CGRectMake(280, 130, 150, 50)];
    [self.view addSubview:slidetofold];
    
    CGFloat nameSize = 18;
    
    hastgewonnen=[[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    [self.view addSubview:hastgewonnen];
    [hastgewonnen setBackgroundColor:[UIColor clearColor]];
    hastgewonnen.font = [UIFont fontWithName:@"Arial" size:nameSize+12];
    [hastgewonnen setTextColor:[UIColor whiteColor]];

    
    spielereins=[[UILabel alloc] initWithFrame:CGRectMake(5, 50, 140, 30)];
    [self.view addSubview:spielereins];
    [spielereins setBackgroundColor:[UIColor clearColor]];
    spielereins.font = [UIFont fontWithName:@"Arial" size:nameSize];
    [spielereins setTextColor:[UIColor whiteColor]];
    if([GameController sharedInstance].maxPlayers>1)spielereins.text=[[[GameController sharedInstance].playerList objectAtIndex:0] playerId];

    spielerzwei=[[UILabel alloc] initWithFrame:CGRectMake(50, 0, 140, 30)];
    [self.view addSubview:spielerzwei];
    [spielerzwei setBackgroundColor:[UIColor clearColor]];
    spielerzwei.font = [UIFont fontWithName:@"Arial" size:nameSize];
    [spielerzwei setTextColor:[UIColor whiteColor]];
    if([GameController sharedInstance].maxPlayers>1)spielerzwei.text=[[[GameController sharedInstance].playerList objectAtIndex:1] playerId];
    
    spielerdrei=[[UILabel alloc] initWithFrame:CGRectMake(193, 0, 140, 30)];
    [self.view addSubview:spielerdrei];
    [spielerdrei setBackgroundColor:[UIColor clearColor]];
    spielerdrei.font = [UIFont fontWithName:@"Arial" size:nameSize];
    [spielerdrei setTextColor:[UIColor whiteColor]];
    if([GameController sharedInstance].maxPlayers>2)spielerdrei.text=[[[GameController sharedInstance].playerList objectAtIndex:2] playerId];
    
    spielervier=[[UILabel alloc] initWithFrame:CGRectMake(370, 00, 140, 30)];
    [self.view addSubview:spielervier];
    [spielervier setBackgroundColor:[UIColor clearColor]];
    spielervier.font = [UIFont fontWithName:@"Arial" size:nameSize];
    [spielervier setTextColor:[UIColor whiteColor]];
    if([GameController sharedInstance].maxPlayers>3)spielervier.text=[[[GameController sharedInstance].playerList objectAtIndex:3] playerId];
    
    spielerfunf=[[UILabel alloc] initWithFrame:CGRectMake(415.0, 50, 140, 30)];
    [self.view addSubview:spielerfunf];
    [spielerfunf setBackgroundColor:[UIColor clearColor]];
    spielerfunf.font = [UIFont fontWithName:@"Arial" size:nameSize];
    [spielerfunf setTextColor:[UIColor whiteColor]];
    if([GameController sharedInstance].maxPlayers>4)spielerfunf.text=[[[GameController sharedInstance].playerList objectAtIndex:4] playerId];
    
    
    //###########################################################################################
    spielereinsCHOICE = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, 60, 30)];
    [self.view addSubview:spielereinsCHOICE];
    [spielereinsCHOICE setBackgroundColor:[UIColor blueColor]];
    spielereinsCHOICE.textAlignment = UITextAlignmentCenter;
    spielereinsCHOICE.font = [UIFont fontWithName:@"Arial" size:16];
    [spielereinsCHOICE setTextColor:[UIColor whiteColor]];
    spielereinsCHOICE.hidden = YES;
    
    spielerzweiCHOICE = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 60, 30)];
    [self.view addSubview:spielerzweiCHOICE];
    [spielerzweiCHOICE setBackgroundColor:[UIColor blueColor]];
    spielerzweiCHOICE.textAlignment = UITextAlignmentCenter;
    spielerzweiCHOICE.font = [UIFont fontWithName:@"Arial" size:16];
    [spielerzweiCHOICE setTextColor:[UIColor whiteColor]];
    spielerzweiCHOICE.hidden = YES;
    
    spielerdreiCHOICE = [[UILabel alloc] initWithFrame:CGRectMake(193, 0, 60, 30)];
    [self.view addSubview:spielerdreiCHOICE];
    [spielerdreiCHOICE setBackgroundColor:[UIColor blueColor]];
    spielerdreiCHOICE.textAlignment = UITextAlignmentCenter;
    spielerdreiCHOICE.font = [UIFont fontWithName:@"Arial" size:16];
    [spielerdreiCHOICE setTextColor:[UIColor whiteColor]];
    spielerdreiCHOICE.hidden = YES;
    
    spielervierCHOICE = [[UILabel alloc] initWithFrame:CGRectMake(370, 0, 60, 30)];
    [self.view addSubview:spielervierCHOICE];
    [spielervierCHOICE setBackgroundColor:[UIColor blueColor]];
    spielervierCHOICE.textAlignment = UITextAlignmentCenter;
    spielervierCHOICE.font = [UIFont fontWithName:@"Arial" size:16];
    [spielervierCHOICE setTextColor:[UIColor whiteColor]];
    spielervierCHOICE.hidden = YES;
    
    spielerfunfCHOICE = [[UILabel alloc] initWithFrame:CGRectMake(415, 50, 60, 30)];
    [self.view addSubview:spielerfunfCHOICE];
    [spielerfunfCHOICE setBackgroundColor:[UIColor blueColor]];
    spielerfunfCHOICE.textAlignment = UITextAlignmentCenter;
    spielerfunfCHOICE.font = [UIFont fontWithName:@"Arial" size:16];
    [spielerfunfCHOICE setTextColor:[UIColor whiteColor]];
    spielerfunfCHOICE.hidden = YES;
    //###########################################################################################   
    
    
    spielereinsstat=[[UILabel alloc] initWithFrame:CGRectMake(100, 150, 140, 30)];
    [self.view addSubview:spielereinsstat];
    [spielereinsstat setBackgroundColor:[UIColor clearColor]];
    spielereinsstat.font = [UIFont fontWithName:@"Arial" size:nameSize];
    [spielereinsstat setTextColor:[UIColor whiteColor]];
    spielereinsstat.text=[NSString stringWithFormat:@"Stack:%i", [GameController sharedInstance].pot];

    
    backofcardsleft1 =[UIImage imageNamed:@"backofcards.png"];
    backofcardsleft=[[UIImageView alloc] initWithImage:backofcardsleft1];
    [backofcardsleft setFrame:CGRectMake(250, 140, 90, 132)];
    [[self view]addSubview:backofcardsleft];

    backofcardsright1 =[UIImage imageNamed:@"backofcards.png"];
    backofcardsright=[[UIImageView alloc] initWithImage:backofcardsright1];
    [backofcardsright setFrame:CGRectMake(350, 125, 90, 132)];
    [[self view]addSubview:backofcardsright];
    

    player1status=[[UIView alloc]initWithFrame:CGRectMake(5, 80, 20, 20)];
    player1status.backgroundColor=[UIColor redColor];
    player1status.layer.cornerRadius=10;
    [self.view addSubview:player1status];

    player2status=[[UIView alloc]initWithFrame:CGRectMake(85, 25, 20, 20)];
    player2status.backgroundColor=[UIColor yellowColor];
    player2status.layer.cornerRadius=10;
    [self.view addSubview:player2status];
    
    player3status=[[UIView alloc]initWithFrame:CGRectMake(265, 5, 20, 20)];
    player3status.backgroundColor=[UIColor greenColor];
    player3status.layer.cornerRadius=10;
    [self.view addSubview:player3status];
    
    player4status=[[UIView alloc]initWithFrame:CGRectMake(375, 25, 20, 20)];
    player4status.backgroundColor=[UIColor yellowColor];
    player4status.layer.cornerRadius=10;
    [self.view addSubview:player4status];
    
    player5status=[[UIView alloc]initWithFrame:CGRectMake(450, 80, 20, 20)];
    player5status.backgroundColor=[UIColor yellowColor];
    player5status.layer.cornerRadius=10;
    [self.view addSubview:player5status];
    
   
    opencard1imageview=[[UIImageView alloc] init];
    [opencard1imageview setFrame:CGRectMake(205, 80, 40, 60)];
    [[self view]addSubview:opencard1imageview];
    
 
    opencard2imageview=[[UIImageView alloc] init];
    [opencard2imageview setFrame:CGRectMake(250, 80, 40, 60)];
    [[self view]addSubview:opencard2imageview];
    
    
    opencard3imageview=[[UIImageView alloc] init];
    [opencard3imageview setFrame:CGRectMake(295, 80, 40, 60)];
    [[self view]addSubview:opencard3imageview];
    
   
    opencard4imageview=[[UIImageView alloc] init];
    [opencard4imageview setFrame:CGRectMake(340, 80, 40, 60)];
    [[self view]addSubview:opencard4imageview];
    
    
    opencard5imageview=[[UIImageView alloc] init];
    [opencard5imageview setFrame:CGRectMake(385, 80, 40, 60)];
    [[self view]addSubview:opencard5imageview];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(statusupdate) userInfo:nil repeats:YES];    [super viewDidLoad];

    int opencardindex=0;
   
    for (int anfang=0; anfang<52; anfang++) {
        
        if ([[PackOfCards sharedInstance] whogotthecard:anfang]==2) {
            NSString *cardImageFileName = [NSString stringWithFormat:@"%i.png", anfang+1];
            if (opencardindex==0) cardlefttemp=[UIImage imageNamed:cardImageFileName];
            if (opencardindex==1) cardrighttemp=[UIImage imageNamed:cardImageFileName];
            opencardindex++;
        }
    }
	// Do any additional setup after loading the view, typically from a nib.
    [[[[GameController sharedInstance] playerList] objectAtIndex:0] setMoneyRest:[[GameController sharedInstance] totalMoney]/5];
}


-(void)updateTextLabel:(UILabel *)label
{
    label.hidden = YES;
}

-(void)textLabelChanger:(UILabel *)label
{
    
    [self performSelector:@selector(updateTextLabel:) withObject:label afterDelay:2];
    
}

-(void) statusupdate{
    mychip50.center=myChip50Center;
    mychip100.center=myChip100Center;
    Pot.text=[NSString stringWithFormat:@"%i",[[GameController sharedInstance] pot]];
    if ([GameController sharedInstance].maxPlayers>1) {
   
    if ([[GameController sharedInstance].activePlayer playerId]==@"Player1") {
        player1status.backgroundColor=[UIColor greenColor];
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:0] playerState]==@"FOLD") {
        player1status.backgroundColor=[UIColor grayColor];
        spielereinsCHOICE.text= @"FOLD";
        spielereinsCHOICE.hidden = NO;
        [self textLabelChanger:spielereinsCHOICE];
//      sleep(4);
//      spielereinsFOLD.hidden = YES;
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:0] playerState]==@"RAISE")
    {
       
        spielereinsCHOICE.text= @"RAISE";
        spielereinsCHOICE.hidden = NO;
        [self textLabelChanger:spielereinsCHOICE];
//        spleep(4);
//        spielereinsRAISE.hidden = YES;
//      sleep(4);
//      spielereinsFOLD.hidden = YES;          
//        spielereins.text=@"RAISE";
//        sleep(4);
//    spielereins.text=[[[GameController sharedInstance].playerList objectAtIndex:0] playerId];
        
       
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:0] playerState]==@"CALL"){
        spielereinsCHOICE.text= @"CALL";
        spielereinsCHOICE.hidden = NO;
        [self textLabelChanger:spielereinsCHOICE];
        player1status.backgroundColor=[UIColor yellowColor];
    }
    else{
        //do nothing
    }
    }
    
    
    
    if ([GameController sharedInstance].maxPlayers>1) {
        
    if ([[GameController sharedInstance].activePlayer playerId]==@"Player2") {
        player2status.backgroundColor=[UIColor greenColor];
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:1] playerState]==@"FOLD") {
        player2status.backgroundColor=[UIColor grayColor];
        spielerzweiCHOICE.text = @"FOLD";
        spielerzweiCHOICE.hidden = NO;
        [self textLabelChanger:spielerzweiCHOICE];
//        sleep(3);
//        spielerzweiCHOICE.hidden = YES;
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:1] playerState]==@"RAISE"){
       
        spielerzweiCHOICE.text=@"RAISE";
        spielerzweiCHOICE.hidden = NO;
        [self textLabelChanger:spielerzweiCHOICE];
//        sleep(3);
//        spielerzweiCHOICE.hidden = YES;
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:1] playerState]==@"CALL"){
        spielerzweiCHOICE.text=@"CALL";
        spielerzweiCHOICE.hidden = NO;
        [self textLabelChanger:spielerzweiCHOICE];
//            sleep(3);
//            spielerzweiCHOICE.hidden = YES;
        player2status.backgroundColor=[UIColor yellowColor];
    }
    else {
        //do nothing
    }
    }
    
    
    
    if ([GameController sharedInstance].maxPlayers>2) {
        
    if ([[GameController sharedInstance].activePlayer playerId]==@"Player3") {
        player3status.backgroundColor=[UIColor greenColor];
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:2] playerState]==@"FOLD") {
        player3status.backgroundColor=[UIColor grayColor];
        spielerdreiCHOICE.text=@"FOLD";
        spielerdreiCHOICE.hidden = NO;
        [self textLabelChanger:spielerdreiCHOICE];
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:2] playerState]==@"RAISE"){
        spielerdreiCHOICE.text=@"RAISE";
        spielerdreiCHOICE.hidden = NO;
        [self textLabelChanger:spielerdreiCHOICE];
//        spielerdrei.text=@"RAISE";
//        sleep(4);
//        spielerdrei.text=[[[GameController sharedInstance].playerList objectAtIndex:2] playerId];
    }
    
    else if(([[[[GameController sharedInstance] playerList] objectAtIndex:2] playerState]==@"CALL")){
        player3status.backgroundColor=[UIColor yellowColor];
        spielerdreiCHOICE.text=@"CALL";
        spielerdreiCHOICE.hidden = NO;
        [self textLabelChanger:spielerdreiCHOICE];
    }
    else {
        //do nothing
    }
    }
    
    
    
    if ([GameController sharedInstance].maxPlayers>3) {
        
    if ([[GameController sharedInstance].activePlayer playerId]==@"Player4") {
        player4status.backgroundColor=[UIColor greenColor];
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:3] playerState]==@"FOLD") {
        player4status.backgroundColor=[UIColor grayColor];
        spielervierCHOICE.text=@"FOLD";
        spielervierCHOICE.hidden = NO;
        [self textLabelChanger:spielervierCHOICE];
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:3] playerState]==@"RAISE"){
        spielervierCHOICE.text=@"RAISE";
        spielervierCHOICE.hidden = NO;
        [self textLabelChanger:spielervierCHOICE];
//        spielervier.text=@"RAISE";
//        sleep(4);
//        spielervier.text=[[[GameController sharedInstance].playerList objectAtIndex:3] playerId];
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:3] playerState]==@"CALL"){
        player4status.backgroundColor=[UIColor yellowColor];
        spielervierCHOICE.text=@"CALL";
        spielervierCHOICE.hidden = NO;
        [self textLabelChanger:spielervierCHOICE];
    }
    else {
        //do nothing
    }
    }
    
    
    if ([GameController sharedInstance].maxPlayers>4) {
    if ([[GameController sharedInstance].activePlayer playerId]==@"Player5") {
        player5status.backgroundColor=[UIColor greenColor];
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:4] playerState]==@"FOLD") {
        spielerfunfCHOICE.text=@"FOLD";
        spielerfunfCHOICE.hidden = NO;
        [self textLabelChanger:spielerfunfCHOICE];
        player5status.backgroundColor=[UIColor grayColor];
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:4] playerState]==@"RAISE"){
        spielerfunfCHOICE.text=@"RAISE";
        spielerfunfCHOICE.hidden = NO;
        [self textLabelChanger:spielerfunfCHOICE];
        
//        spielerfunf.text=@"RAISE";
//        sleep(4);
//        spielerfunf.text=[[[GameController sharedInstance].playerList objectAtIndex:4] playerId];
    }
    else if([[[[GameController sharedInstance] playerList] objectAtIndex:4] playerState]==@"CALL"){
        spielerfunfCHOICE.text=@"CALL";
        spielerfunfCHOICE.hidden = NO;
        [self textLabelChanger:spielerfunfCHOICE];
        player5status.backgroundColor=[UIColor yellowColor];
    }
    else {
    //do nothing
    }
    
    
        }
}

-(void)endiwinnaiz:(NSString*) lol{
    hastgewonnen.text=lol;
    sleep(5);
    opencard1imageview.image = nil;
    opencard2imageview.image = nil;
    opencard3imageview.image = nil;
    opencard4imageview.image = nil;
    opencard5imageview.image = nil;
    backofcardsleft.image = nil;
    backofcardsright.image = nil;
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   //this is a comment
    UITouch *betouched = [touches anyObject];
    startpoint = [betouched locationInView:self.view];

    if ( [[[[GameController sharedInstance] playerList]objectAtIndex:0]playerState]!=@"FOLD") {
        
    
    if ((startpoint.x < 480 && startpoint.x > 330) &&
        (startpoint.y < 150 && startpoint.y > 100)) {
        foldmaybe=true;
    }else {
        foldmaybe=false;
    }
    
    
    if(startpoint.x>150 && startpoint.x<250 &&startpoint.y>50 &&startpoint.y<110){
        [[GameController sharedInstance] activateNextPlayer];

    }
    
    if ((startpoint.x < mychip50.center.x + 20.0 && startpoint.x > mychip50.center.x - 20.0) &&
        (startpoint.y < mychip50.center.y + 20.0 && startpoint.y > mychip50.center.y - 20.0)) {
            coinStuff=1;
    }
    else if ((startpoint.x < mychip100.center.x + 20.0 && startpoint.x > mychip100.center.x - 20.0) &&
            (startpoint.y < mychip100.center.y + 20.0 && startpoint.y > mychip100.center.y - 20.0)) {
            coinStuff=2;
    }
    else {
        coinStuff= 0;
    }
        }
    
}


-(void)binichdran{
  
    int handcardindex=0;
    for (int anfang=0; anfang<52; anfang++) {

        if ([[PackOfCards sharedInstance] whogotthecard:anfang]==1) {
            NSString *cardImageFileName = [NSString stringWithFormat:@"%i.png", anfang+1];
            if (handcardindex==0) opencard1imageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.png", anfang+1]];
            
            if (handcardindex==1) opencard2imageview.image=[UIImage imageNamed:cardImageFileName];
            if (handcardindex==2) opencard3imageview.image=[UIImage imageNamed:cardImageFileName];
            if (handcardindex==3) opencard4imageview.image=[UIImage imageNamed:cardImageFileName];
            if (handcardindex==4) opencard5imageview.image=[UIImage imageNamed:cardImageFileName];
            handcardindex++;
        }
      
        
    }
   
    if ( [[GameController sharedInstance].activePlayer playerId]!=@"Player1" ) {
     

    [self performSegueWithIdentifier:@"tobot" sender:nil];
    }

}


int iba=1;
int flipcardleft=1;
int flipcardback=0;
int canwin=0;

-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer{
    
    
if ( [[[[GameController sharedInstance] playerList]objectAtIndex:0]playerState]!=@"FOLD") {
   
    CGPoint locationInView = [recognizer locationInView:self.view];
 //   NSLog(@"lol:,%i",locationInView.x);
    
    if(coinStuff==1)mychip50.center = locationInView;
    if(coinStuff==2)mychip100.center = locationInView;
    
    if (startpoint.x>380&&locationInView.x>380) {
        backofcardsleft.image=[UIImage imageNamed:@"backofcards"];
        backofcardsright.image=[UIImage imageNamed:@"backofcards"];
   //     NSLog(@"zweig1,%i",flipcardleft);
        flipcardleft=1;
    }
     
    if (locationInView.x<381 && locationInView.x>280 && flipcardleft==1) {
        backofcardsleft.image=[UIImage imageNamed:@"backofcardslinks"];
        backofcardsright.image=[UIImage imageNamed:@"backofcardsrechts"];
        flipcardleft=2;
    //    NSLog(@"zweig2,%i",flipcardleft);
    }
                    
    if (locationInView.x>260 && locationInView.x<281 && (flipcardleft==2||flipcardback==1) ) {
                        backofcardsleft.image=[UIImage imageNamed:@"backofcardslinks2"];
                        backofcardsright.image=[UIImage imageNamed:@"backofcards2"];
                        flipcardleft=3;
      
        
  //      NSLog(@"zweig3,%i",flipcardleft);
        flipcardback=0;
                            }
    
    if ( locationInView.x<261 && flipcardleft==3 ) {
       
        backofcardsleft.image=cardlefttemp;
        backofcardsright.image=cardrighttemp;
        flipcardleft=1;
        flipcardback=1;
        //NSLog(@"zweig4,%i",flipcardleft);
       // int playerIDint=[playerid intValue];
        
        
}
        
    }
  
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
            
        
        
         backofcardsleft.image=[UIImage imageNamed:@"backofcards"];
         backofcardsright.image=[UIImage imageNamed:@"backofcards"];
        flipcardleft=1;
        CGPoint velocity = [ recognizer velocityInView:self.view];
        CGFloat magnitude= sqrtf(1+(velocity.y* velocity.y));
        CGFloat slideMult= magnitude /1000;
        float slidefactor = 0.2 * slideMult;
        
        
        if (foldmaybe==true&&[[[GameController sharedInstance] activePlayer] playerId]==@"Player1")
        {
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{ backofcardsleft.frame=CGRectMake(backofcardsleft.frame.origin.x, 100, backofcardsleft.frame.size.width/1.5, backofcardsleft.frame.size.height/1.5);} completion:nil];
            
                        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{ backofcardsright.frame=CGRectMake(backofcardsright.frame.origin.x-60, 100, backofcardsright.frame.size.width/1.5, backofcardsright.frame.size.height/1.5);} completion:nil];
            
            CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            animation2.fromValue = [NSNumber numberWithFloat:0.0f];
            animation2.toValue = [NSNumber numberWithFloat: 22.2];
            animation2.duration = 1.0f;
            [backofcardsright.layer addAnimation:animation2 forKey:@"MyAnimation"];
               
            
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            animation.fromValue = [NSNumber numberWithFloat:0.0f];
            animation.toValue = [NSNumber numberWithFloat: 32.2];
            animation.duration = 1.2f;
            [backofcardsleft.layer addAnimation:animation forKey:@"MyAnimation"];

            
                [[GameController sharedInstance] changePlayerState:@"FOLD" forPlayer:[[GameController sharedInstance].playerList objectAtIndex:0]];
            foldmaybe=false;
            
        }else {
            foldmaybe=false;
        }
        
  
        if ( magnitude>1000 &&  [[GameController sharedInstance].activePlayer playerId]==@"Player1") {
            CGPoint finalpoint = CGPointMake(recognizer.view.center.x, recognizer.view.center.y+(velocity.y*slidefactor));
            if(coinStuff==1){
            [UIView animateWithDuration:slidefactor*2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{ mychip50.frame=CGRectMake(mychip50.frame.origin.x, finalpoint.y, mychip50.frame.size.width, mychip50.frame.size.height);} completion:nil];
            //    [ chooseBet:50];
                
             [[GameController sharedInstance] changePlayerState:@"CALL" forPlayer:[[GameController sharedInstance].playerList objectAtIndex:0]];
         
            }
            if(coinStuff==2){
                [UIView animateWithDuration:slidefactor*2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{ mychip100.frame=CGRectMake(mychip100.frame.origin.x, finalpoint.y, mychip100.frame.size.width, mychip100.frame.size.height);} completion:nil];
          //      [player chooseBet:100];
                
                       [[GameController sharedInstance] changePlayerState:@"RAISE" forPlayer:[[GameController sharedInstance].playerList objectAtIndex:0]];
                //   Pot.text=[NSString stringWithFormat:@"Pot:%i",canwin];
            }
       coinStuff=0;
            iba++;
        }   
            else {
                if(coinStuff==1)mychip50.center=myChip50Center;
                if(coinStuff==2)mychip100.center=myChip100Center;
            coinStuff=0;
                
            }
    }
}






- (void)viewDidUnload
{
 

//    Pot = nil;

    [super viewDidUnload];
  //  [myView setCanDraw:NO];

    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
