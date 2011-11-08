#import "Sample1ViewController.h"

#import "MagicaSlider.h"


@implementation Sample1ViewController

@synthesize label;
@synthesize label2;

- (void)callBack1:(id)degree
{
    [label setText:[degree stringValue]];
    NSLog(@"callBack1-1:%d", [degree intValue]);
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
    
    NSLog(@"callBack1-2:%d", [degree intValue]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**********************************
    sample1-1
    **********************************/
    NSMutableDictionary *wish1 = [NSMutableDictionary dictionary];
	[wish1 setObject:@"90" forKey:@"defalutDeg"];
	[wish1 setObject:@"0,0,0,0.3" forKey:@"backgroundColor"];
	MagicaSlider *soulGem = [[MagicaSlider alloc] contractWithWish:CGRectMake(10, 20, 170, 170) wish:wish1];

    // set Callback
    [soulGem setMagic:self magic:@selector(callBack1:)];

	[self.view addSubview:soulGem];


    /**********************************
     sample1-2 set Everything for circle
    **********************************/
    NSMutableDictionary *wish2 = [NSMutableDictionary dictionary];
	[wish2 setObject:@"60" forKey:@"defalutDeg"];
	[wish2 setObject:@"6" forKey:@"step"];

	[wish2 setObject:@"220,177,139,0.6" forKey:@"color"];
	[wish2 setObject:@"0,0,0,0.6" forKey:@"backgroundColor"];
    
    [wish2 setObject:@"255,255,255,0.8" forKey:@"lineColor"];
    [wish2 setObject:@"10" forKey:@"lineWidth"];

    [wish2 setObject:@"10" forKey:@"offset"];
    
	MagicaSlider *soulGem2 = [[MagicaSlider alloc] contractWithWish:CGRectMake(10, 220, 170, 170) wish:wish2];

    // set Callback
    [soulGem2 setMagic:self magic:@selector(callBack2:)];

    [self.view addSubview:soulGem2];
    
    
    
    /**********************************
     for callback1
     **********************************/
    label = [[UILabel alloc] initWithFrame:CGRectMake(200, 90, 80, 30)];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30.0]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:UITextAlignmentRight];
    [label setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:label];
    
    /**********************************
     for callback2
     **********************************/
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(195, 290, 110, 30)];
    [label2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30.0]];
    [label2 setTextColor:[UIColor whiteColor]];
    [label2 setTextAlignment:UITextAlignmentRight];
    [label2 setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:label2];
    
}

@end
