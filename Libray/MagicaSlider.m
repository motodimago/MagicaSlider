//
//  MagicaSlider.m
//
//  Created by motodimago on 11/10/21.
//

#import "MagicaSlider.h"

#define MI_PI 3.14159265358979323846
#define MI_MD(__key) [wish objectForKey:__key]

static inline float radians(double degrees) { return degrees * MI_PI / 180; }


@interface MagicaSlider()

@property(nonatomic, assign) int     MIdegree;
@property(nonatomic, assign) int     MIstepDeg;
@property(nonatomic, assign) float   MIhalfLineWidth;
@property(nonatomic, assign) float   MIlineRectWidth;
@property(nonatomic, assign) float   MIlineRectHeight;

// for Circle
@property(nonatomic, assign) BOOL    MIlock;
@property(nonatomic, assign) int     MIdirection;
@property(nonatomic, assign) float   MIprevDeg;

// for Bar
@property(nonatomic, assign) float   MIbarY;


// for Touch
@property(nonatomic, assign) CGPoint MItouchPoint;


- (UIColor *)getUIColor:(NSString *)color;
- (void)drawCircle;
- (void)drawBar;
- (void)drawBarRoundCorner:(CGContextRef)ctx rect:(CGRect)rect mode:(CGPathDrawingMode)mode radius:(float) radius;
- (float)setBarSize:(int)frameSize touchPoint:(float)point def:(int)def target:(BOOL)target;
- (float)setBarOffset:(float)size frame:(float)frame offset:(int)offset;
@end


@implementation MagicaSlider

@synthesize 
	MIx                = _MIx,
	MIy                = _MIy,
	MIwidth            = _MIwidth,
	MIheight           = _MIheight,

	MItarget           = _MItarget,
	MImagic            = _MImagic,
	MIdefaultDeg       = _MIdefaultDeg,
	MIstep             = _MIstep,

	MItype             = _MItype,
	MIcolor            = _MIcolor,
	MIbackgroundColor  = _MIbackgroundColor,
	MIlineColor        = _MIlineColor,
	MIlineWith         = _MIlineWith,
	MIoffset           = _MIoffset,
	MIvertical         = _MIvertical,
	MIbarRadius        = _MIbarRadius,
	MIbackgroundRadius = _MIbackgroundRadius,

	MIdegree           = _MIdegree,
    MIstepDeg          = _MIstepDeg,
    MIcircleWidth      = _MIcircleWidth,
    MIbarY             = _MIbarY,

    MIhalfWidth        = _MIhalfWidth,
    MIhalfLineWidth    = _MIhalfLineWidth,
    MIlineRectWidth    = _MIlineRectWidth,
    MIlineRectHeight   = _MIlineRectHeight,
	MIlock             = _MIlock,
	MIdirection        = _MIdirection,
	MIprevDeg          = _MIprevDeg,
	MItouchPoint       = _MItouchPoint;


- (id)contractWithWish:(CGRect)rect wish:(NSMutableDictionary *)wish
{
	_MIx      = CGRectGetMinX(rect);
	_MIy      = CGRectGetMinY(rect);
	_MIwidth  = CGRectGetWidth(rect);
	_MIheight = CGRectGetHeight(rect);
		
    self = [super initWithFrame:rect];
    if (self) {
		self.backgroundColor = MI_RGBA(0, 0, 0,	0);
		[self setWish:wish];
    }
    return self;
}

- (void)setWish:(NSMutableDictionary *)wish
{
	_MIlock = NO;
	_MIdefaultDeg = (MI_MD(@"defalutDeg") != nil)? [MI_MD(@"defalutDeg") intValue] : 0;
	_MIstep = (MI_MD(@"step") != nil)? [MI_MD(@"step") intValue] : 0;
	_MItype = (MI_MD(@"type") != nil && ![MI_MD(@"type") isEqualToString:@"circle"])? MI_MD(@"type") : @"circle";
	_MIcolor = (MI_MD(@"color") != nil)? [self getUIColor:MI_MD(@"color")] : MI_RGBA(255, 144, 151 ,1);
	_MIbackgroundColor = (MI_MD(@"backgroundColor") != nil)? [self getUIColor:MI_MD(@"backgroundColor")] : nil;
	_MIlineColor = (MI_MD(@"lineColor") != nil)? [self getUIColor:MI_MD(@"lineColor")] : nil;
	_MIlineWith = (MI_MD(@"lineWidth") != nil)? [MI_MD(@"lineWidth") intValue] : 0;	
	_MIoffset = (MI_MD(@"offset")) != nil? [MI_MD(@"offset") intValue] : 0;
	_MIvertical = ([MI_MD(@"vertical") isEqualToString:@"YES"])? YES : NO;
	_MIbarRadius = (MI_MD(@"barRadius") != nil)? [MI_MD(@"barRadius") floatValue] : 0.0;
	_MIbackgroundRadius = (MI_MD(@"backgroundRadius") != nil)? [MI_MD(@"backgroundRadius") floatValue] : 0.0;
    
    _MIhalfLineWidth = _MIlineWith / 2.0;
    _MIlineRectWidth  = _MIwidth - _MIlineWith;
    _MIlineRectHeight = _MIheight - _MIlineWith;
        
	if ([_MItype isEqualToString:@"circle"]) {
        _MIstepDeg = (_MIstep != 0)? 360 / _MIstep : 0;
        _MIhalfWidth = _MIwidth / 2.0;
        _MIcircleWidth =  _MIwidth / 2.0 - _MIoffset * 2.0;

        
		self.frame = CGRectMake(CGRectGetMinX(self.frame), 
								CGRectGetMinY(self.frame), 
								CGRectGetWidth(self.frame), 
								CGRectGetWidth(self.frame));
    } else {
        _MIstepDeg = (_MIvertical)? _MIheight / _MIstep : _MIwidth / _MIstep;
        _MIbarY =  (_MIvertical)? _MIheight - _MIoffset : _MIoffset;
    }
}

- (void)setMagic:(id)target magic:(SEL)magic
{
	_MItarget = target;
	_MImagic  = magic;
}

- (UIColor *)getUIColor:(NSString *)color
{
	NSArray *colorArray = [color componentsSeparatedByString:@","];
	return MI_RGBA([[colorArray objectAtIndex:0] floatValue],
				   [[colorArray objectAtIndex:1] floatValue],
				   [[colorArray objectAtIndex:2] floatValue],
				   [[colorArray objectAtIndex:3] floatValue]);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	_MIprevDeg = 0;
	_MIdirection = 0;
	_MIlock = NO;

    UITouch *touch = [touches anyObject];
	_MItouchPoint = [touch locationInView:self];
	[self setNeedsDisplay];	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	_MItouchPoint = [touch locationInView:self];
	[self setNeedsDisplay];	
}

- (void)drawRect:(CGRect)rect
{
	if (![_MItype isEqualToString:@"circle"]) {
		[self drawBar];
	} else {
		[self drawCircle];
	}
}

- (void)drawCircle
{	
	float circleStart = -90.0;
	float circleFinish = 0;

	// set Default
	if (_MItouchPoint.x && _MIdefaultDeg == 0) {
		circleFinish = (((atan2((_MItouchPoint.x - _MIwidth / 2) , (_MItouchPoint.y - _MIwidth / 2)))*180)/MI_PI) * -1 + 180;
	} else if (_MIprevDeg) {
		circleFinish = _MIprevDeg;
	} else if (_MIdefaultDeg) {
		circleFinish = _MIdefaultDeg;
		_MIdefaultDeg = 0;
	}

	if (_MIlock) {
		if (135 < circleFinish && 0 < _MIdirection) {
			_MIlock = NO;
		}
		if (circleFinish < 225 && _MIdirection < 0) {
			_MIlock = NO;
		}
	}
	
	float difference = fabs(circleFinish - _MIprevDeg);

	if (difference > 0.6 && difference < 300 && !_MIlock) {
		if (_MIprevDeg < circleFinish) {
			_MIdirection = 1;
		} else if (circleFinish < _MIprevDeg) {
			_MIdirection = -1;
		}
	}

	if (300 < difference || _MIlock) {
		if (0 < _MIdirection) {	
			if (circleFinish < _MIprevDeg) {
				circleFinish = 360.0;
				_MIlock = YES;
			}
		}
		if (_MIdirection < 0) {
			if (_MIprevDeg  < circleFinish) {
				circleFinish = 0.0;
				_MIlock = YES;
			}
		}
	}

	if (!_MIlock) {
		_MIprevDeg = circleFinish;
	}

	// Step
	if (_MIstep && _MIstep != 0) {
		_MIdegree = (int)ceil(circleFinish / _MIstepDeg);
		circleFinish = _MIstepDeg * _MIdegree;
		if (360 - circleFinish < _MIstepDeg) {
			circleFinish = 360;
		}
	} else {
		_MIdegree = (int)circleFinish;
	}

    // Callback
	if (_MItarget != nil && _MImagic != nil) {
        [_MItarget performSelector:_MImagic withObject:[NSNumber numberWithInteger:_MIdegree]];
	}	
	
	int circleX = _MIhalfWidth;
	int circleY = _MIhalfWidth;

    CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	// draw Background
	if (_MIbackgroundColor) {
		CGContextSetFillColor(ctx, CGColorGetComponents([_MIbackgroundColor CGColor]));
		CGRect background = CGRectMake(0, 0, _MIwidth, _MIwidth); 
		CGContextFillEllipseInRect(ctx, background);
	}
	
	// draw Circle
	CGContextSetFillColor(ctx, CGColorGetComponents([_MIcolor CGColor]));
	CGContextMoveToPoint(ctx, circleX, circleY);
	CGContextAddArc(ctx, circleX, circleY, _MIcircleWidth, radians(circleStart), radians(circleFinish - 90.0), 0);
	CGContextClosePath(ctx);
	CGContextFillPath(ctx);

	// draw Line
	if (_MIlineColor) {
		CGContextSetStrokeColor(ctx, CGColorGetComponents([_MIlineColor CGColor]));
		CGContextSetLineWidth(ctx, _MIlineWith);
		CGRect line = CGRectMake(_MIhalfLineWidth, _MIhalfLineWidth, _MIlineRectWidth, _MIlineRectWidth); 
		CGContextStrokeEllipseInRect(ctx, line);
	}
}

- (void)drawBar
{
	float barWidth;
	float barHeight;

    double pointX = 0;
    double pointY = 0;

	// set Default
	if (_MItouchPoint.x && _MIdefaultDeg == 0) {
        pointX = _MItouchPoint.x;
        pointY = _MItouchPoint.y;
    } else {
		if (_MIvertical) {
            pointY = _MIheight - _MIdefaultDeg;
        } else {
            pointX = _MIdefaultDeg;
        }
		_MIdefaultDeg = 0;
	}
    
	// Size
	barWidth  = [self setBarSize:_MIwidth touchPoint:pointX def:_MIdefaultDeg target:!_MIvertical];
	barHeight = [self setBarSize:_MIheight touchPoint:pointY def:_MIdefaultDeg target:_MIvertical];

	// Step
	if (_MIstep && _MIstep != 0) {
		if (_MIvertical) {
            _MIdegree = round(barHeight / _MIstepDeg);
			barHeight = _MIdegree * _MIstepDeg;
			if (_MIheight - barHeight < _MIstepDeg) {
				barHeight = _MIheight;
			}
			_MIdegree = _MIstep - _MIdegree;
		} else {
            _MIdegree = round(barWidth / _MIstepDeg); 
			barWidth = _MIdegree * _MIstepDeg;
			if (_MIwidth - barWidth < _MIstepDeg) {
				barWidth = _MIwidth;
			}			
		}
	} else {
		if (_MIvertical) {
			_MIdegree = (int) barHeight;		
		} else {
			_MIdegree = (int) barWidth;
		}
	}

	// Offset
	if (_MIoffset) {
		barWidth = [self setBarOffset:barWidth frame:_MIwidth offset:_MIoffset];
		barHeight = [self setBarOffset:barHeight frame:_MIheight offset:_MIoffset];
	}

    // Callback
	if (_MItarget != nil && _MImagic != nil) {
		[_MItarget performSelector:_MImagic withObject:[NSNumber numberWithInteger:_MIdegree]];
	}
	
    CGContextRef ctx = UIGraphicsGetCurrentContext();

	if (_MIvertical) {
		barHeight = (_MIheight - barHeight - _MIoffset * 2) * -1;
	}
    
	// draw Background
    if (_MIbackgroundColor) {
		CGContextSetFillColor(ctx, CGColorGetComponents([_MIbackgroundColor CGColor]));
		[self drawBarRoundCorner:ctx
							rect:CGRectMake(0.0, 0.0, _MIwidth, _MIheight)
							mode:kCGPathFill
						  radius:_MIbackgroundRadius+_MIlineWith];
	}
	
	// draw Bar
	CGContextSetFillColor(ctx, CGColorGetComponents([_MIcolor CGColor]));

	float setRadius = (_MIbarRadius * 2 >= fabs(barHeight))? fabs(barHeight) / 2 : _MIbarRadius;

	[self drawBarRoundCorner:ctx
						rect:CGRectMake(_MIoffset, _MIbarY, barWidth, barHeight)
						mode:kCGPathFill
					  radius:setRadius];
	 
	// draw Line
	if (_MIlineColor) {
		CGContextSetStrokeColor(ctx, CGColorGetComponents([_MIlineColor CGColor]));
		CGContextSetLineWidth(ctx, _MIlineWith);
		[self drawBarRoundCorner:ctx
							rect:CGRectMake(_MIhalfLineWidth, _MIhalfLineWidth, _MIlineRectWidth, _MIlineRectHeight)
							mode:kCGPathStroke
						  radius:_MIbackgroundRadius];
	}
}

- (void)drawBarRoundCorner:(CGContextRef)ctx rect:(CGRect)rect mode:(CGPathDrawingMode)mode radius:(float) radius 
{
	CGFloat minx = CGRectGetMinX(rect);
	CGFloat midx = CGRectGetMidX(rect);
	CGFloat maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect);
	CGFloat midy = CGRectGetMidY(rect);
	CGFloat maxy = CGRectGetMaxY(rect);

	CGContextMoveToPoint(ctx, minx, midy);
	CGContextAddArcToPoint(ctx, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(ctx, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(ctx, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(ctx, minx, maxy, minx, midy, radius);
	CGContextClosePath(ctx);
	CGContextDrawPath(ctx, mode);
}

- (float)setBarSize:(int)frameSize touchPoint:(float)point def:(int)def target:(BOOL)target
{
    point = (point < 0)? 0 : point;
    point = (frameSize < point)? frameSize : point;
    
	if (!target) {
		return frameSize;
	} else {
		if ((point || point == 0.0) && !def) {
			return point;
		} else {
			_MIdefaultDeg = 0;
			return def;
		}
	}
}

- (float)setBarOffset:(float)size frame:(float)frame offset:(int)offset
{
	size -= offset;
	if (size < 0) {
		size = 0.0;
	}
	if (frame - offset * 2 < size) {
		size = frame - offset * 2;
	}
	
	return size;
}

- (void)dealloc
{
    [super dealloc];
}

/*******************************************************
 synonym
 *******************************************************/
- (id)initWithFrame:(CGRect)rect
{
	return [self contractWithWish:rect wish:nil];
}

- (void)setDesign:(NSMutableDictionary *)design
{
	[self setWish:design];
}

- (void)addTarget:(id)target action:(SEL)action
{
	[self setMagic:target magic:action];
}

@end
