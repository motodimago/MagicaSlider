#import "Sample2ViewController.h"

#import "MagicaSlider.h"


@implementation Sample2ViewController

@synthesize label;
@synthesize label2;
@synthesize label3;
@synthesize label4;


- (void)callBack1:(id)degree
{
    [label setText:[degree stringValue]];
    NSLog(@"callBack2-1:%d", [degree intValue]);
}

- (void)callBack2:(id)degree
{
    [label2 setText:[NSString stringWithFormat:@"STEP %@",[degree stringValue]]];

    NSArray *bg = [NSArray arrayWithObjects:
                   [UIColor blackColor],
                   [UIColor scrollViewTexturedBackgroundColor],
                   [UIColor groupTableViewBackgroundColor],
                   [UIColor darkGrayColor],
                   [UIColor grayColor],
                   [UIColor scrollViewTexturedBackgroundColor],
                   [UIColor viewFlipsideBackgroundColor],
                   nil];
    self.view.backgroundColor = [bg objectAtIndex:[degree intValue]];

    NSLog(@"callBack2-2:%d", [degree intValue]);
}

- (void)callBack3:(id)degree
{
    [label3 setText:[degree stringValue]];
    NSLog(@"callBack2-3:%d", [degree intValue]);
}

- (void)callBack4:(id)degree
{
    [label4 setText:[NSString stringWithFormat:@"STEP %@",[degree stringValue]]];
    
    NSArray *bg = [NSArray arrayWithObjects:
                   [UIColor blackColor],
                   [UIColor scrollViewTexturedBackgroundColor],
                   [UIColor groupTableViewBackgroundColor],
                   [UIColor darkGrayColor],
                   [UIColor grayColor],
                   [UIColor scrollViewTexturedBackgroundColor],
                   [UIColor viewFlipsideBackgroundColor],
                   nil];
    self.view.backgroundColor = [bg objectAtIndex:[degree intValue]];
    
    NSLog(@"callBack2-4:%d", [degree intValue]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
    /**********************************
     sample2-1
     **********************************/
    NSMutableDictionary *wish1 = [NSMutableDictionary dictionary];
	[wish1 setObject:@"90" forKey:@"defalutDeg"];

	[wish1 setObject:@"bar" forKey:@"type"];

	[wish1 setObject:@"0,0,0,0.3" forKey:@"backgroundColor"];
	MagicaSlider *soulGem1 = [[MagicaSlider alloc] contractWithWish:CGRectMake(10, 20, 300, 40) wish:wish1];
    
    // set Callback
    [soulGem1 setMagic:self magic:@selector(callBack1:)];
    
	[self.view addSubview:soulGem1];


    /**********************************
     sample2-2 set Everything for bar
     **********************************/
    NSMutableDictionary *wish2 = [NSMutableDictionary dictionary];
	[wish2 setObject:@"50" forKey:@"defalutDeg"];
    [wish2 setObject:@"6" forKey:@"step"];

	[wish2 setObject:@"bar" forKey:@"type"];
    
	[wish2 setObject:@"220,177,139,0.6" forKey:@"color"];
	[wish2 setObject:@"0,0,0,0.6" forKey:@"backgroundColor"];
    
    [wish2 setObject:@"255,255,255,0.8" forKey:@"lineColor"];
    [wish2 setObject:@"5" forKey:@"lineWidth"];
    
    [wish2 setObject:@"10" forKey:@"barRadius"];
    [wish2 setObject:@"17" forKey:@"backgroundRadius"];

    [wish2 setObject:@"10" forKey:@"offset"];
    
	[wish2 setObject:@"0,0,0,0.3" forKey:@"backgroundColor"];
	MagicaSlider *soulGem2 = [[MagicaSlider alloc] contractWithWish:CGRectMake(10, 70, 300, 40) wish:wish2];
    
    // set Callback
    [soulGem2 setMagic:self magic:@selector(callBack2:)];
    
	[self.view addSubview:soulGem2];

    
    /**********************************
     sample2-3
     **********************************/
    NSMutableDictionary *wish3 = [NSMutableDictionary dictionary];
	[wish3 setObject:@"90" forKey:@"defalutDeg"];
    
	[wish3 setObject:@"bar" forKey:@"type"];
    [wish3 setObject:@"YES" forKey:@"vertical"];

	[wish3 setObject:@"0,0,0,0.3" forKey:@"backgroundColor"];
	MagicaSlider *soulGem3 = [[MagicaSlider alloc] contractWithWish:CGRectMake(20, 140, 40, 250) wish:wish3];
    
    // set Callback
    [soulGem3 setMagic:self magic:@selector(callBack3:)];
    
	[self.view addSubview:soulGem3];
    
    
    /**********************************
     sample2-4 set Everything for bar
     **********************************/
    NSMutableDictionary *wish4 = [NSMutableDictionary dictionary];
	[wish4 setObject:@"50" forKey:@"defalutDeg"];
    [wish4 setObject:@"6" forKey:@"step"];
    
	[wish4 setObject:@"bar" forKey:@"type"];
    [wish4 setObject:@"YES" forKey:@"vertical"];

    
	[wish4 setObject:@"220,177,139,0.6" forKey:@"color"];
	[wish4 setObject:@"0,0,0,0.6" forKey:@"backgroundColor"];
    
    [wish4 setObject:@"255,255,255,0.8" forKey:@"lineColor"];
    [wish4 setObject:@"5" forKey:@"lineWidth"];
    
    [wish4 setObject:@"10" forKey:@"barRadius"];
    [wish4 setObject:@"17" forKey:@"backgroundRadius"];
    
    [wish4 setObject:@"10" forKey:@"offset"];
    
	[wish4 setObject:@"0,0,0,0.3" forKey:@"backgroundColor"];
	MagicaSlider *soulGem4 = [[MagicaSlider alloc] contractWithWish:CGRectMake(80, 140, 40, 250) wish:wish4];
    
    // set Callback
    [soulGem4 setMagic:self magic:@selector(callBack4:)];
    
	[self.view addSubview:soulGem4];
    

    
    /**********************************
     for callback1
     **********************************/
    label = [[UILabel alloc] initWithFrame:CGRectMake(225, 30, 80, 30)];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30.0]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:UITextAlignmentRight];
    [label setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:label];

    /**********************************
     for callback2
     **********************************/
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(185, 75, 110, 30)];
    [label2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25.0]];
    [label2 setTextColor:[UIColor whiteColor]];
    [label2 setTextAlignment:UITextAlignmentRight];
    [label2 setBackgroundColor:[UIColor clearColor]];    
    [self.view addSubview:label2];

    /**********************************
     for callback3
     **********************************/
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(220, 150, 80, 30)];
    [label3 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30.0]];
    [label3 setTextColor:[UIColor whiteColor]];
    [label3 setTextAlignment:UITextAlignmentRight];
    [label3 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:label3];

    /**********************************
     for callback4
     **********************************/
    label4 = [[UILabel alloc] initWithFrame:CGRectMake(180, 190, 120, 30)];
    [label4 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30.0]];
    [label4 setTextColor:[UIColor whiteColor]];
    [label4 setTextAlignment:UITextAlignmentRight];
    [label4 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:label4];
}

@end
