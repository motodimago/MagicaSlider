#import "Sample3ViewController.h"

#import "MagicaSlider.h"


@implementation Sample3ViewController

@synthesize soulGem1;
@synthesize soulGem2;

@synthesize C1;
@synthesize C2;
@synthesize C2Deg;

- (void)callBack1:(id)degree
{
    float size = [degree floatValue] / 2 + 60;
    if (size < 80) {
        size = 80;
    }
    if (240 < size) {
        size = 240;
    }
    
    if (!C2) {
        C1 = YES;
		soulGem2.MIdefaultDeg = C2Deg;
        soulGem2.MIx      = 10 + (300 - size)/2;
        soulGem2.MIy      = 20 + (300 - size)/2;
        soulGem2.MIwidth  = size;
        soulGem2.MIheight = size;
        soulGem2.MIhalfWidth = size / 2.0;
        soulGem2.MIcircleWidth =  size / 2.0 - 10 * 2.0;

        soulGem2.frame = CGRectMake(10 + (300 - size)/2, 20 + (300 - size)/2, size, size);
        [soulGem2 setNeedsDisplay];
    } else {
        C2 = NO;
    }

    NSLog(@"callBack3-1:%d", [degree intValue]);
}

- (void)callBack2:(id)degree
{
	C2Deg = [degree intValue];
    if (!C1) {
        C2 = YES;
        soulGem1.MIcolor = [[UIColor colorWithHue:[degree floatValue]/360 saturation:1 brightness:1 alpha:1] retain];
        [soulGem1 setNeedsDisplay];
    } else {
        C1 = NO;
    }
    NSLog(@"callBack3-2:%d", [degree intValue]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    C1 = NO;
    C2 = NO;
    
    /**********************************
     sample3-1
     **********************************/
    NSMutableDictionary *wish1 = [NSMutableDictionary dictionary];
	[wish1 setObject:@"270" forKey:@"defalutDeg"];
	[wish1 setObject:@"0,0,0,0.5" forKey:@"backgroundColor"];
    [wish1 setObject:@"10" forKey:@"offset"];

	soulGem1 = [[MagicaSlider alloc] contractWithWish:CGRectMake(10, 20, 300, 300) wish:wish1];
    
    // set Callback
    [soulGem1 setMagic:self magic:@selector(callBack1:)];
    
	[self.view addSubview:soulGem1];
    
    
    /**********************************
     sample3-2 set Everything for circle
     **********************************/
    NSMutableDictionary *wish2 = [NSMutableDictionary dictionary];
	[wish2 setObject:@"90" forKey:@"defalutDeg"];

	[wish2 setObject:@"220,177,139,0.6" forKey:@"color"];
	[wish2 setObject:@"0,0,0,1" forKey:@"backgroundColor"];
    [wish2 setObject:@"10" forKey:@"offset"];
    
	soulGem2 = [[MagicaSlider alloc] contractWithWish:CGRectMake(80, 90, 160, 160) wish:wish2];
    
    // set Callback
    [soulGem2 setMagic:self magic:@selector(callBack2:)];
    
    [self.view addSubview:soulGem2];
}

@end
