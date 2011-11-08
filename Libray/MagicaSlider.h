//
//  MagicaSlider.h
//
//  Created by motodimago on 11/10/21.
//
// Settings(optional)
//    defalutDeg NSString @"num" default 0
//    step NSString @"num" default 0
//
//    type: NSString @"circle" or @"bar" default @"circle"
//    color: NSString @"R,G,B,A" default @"255,204,0,1"
//    backgroundColor: NSString @"R,G,B,A" default nil if nil hide background
//    lineColor: NSString @"R,G,B,A" default nil if nil hide line
//    lineWidth: NSString @"num" default 0
//    offset: NSString @"num" default 0
//
//    if type is bar
//        vertical: NSString @"YES" or @"NO" default nil
//        barRadius: NSString @"num" default 0
//        backgroundRadius: NSString @"num" default 0

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define MI_RGBA(r, g, b, a) [[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a] retain]

@interface MagicaSlider : UIView
{
	id        MItarget;
	SEL       MImagic;
	int       MIdefaultDeg;
	int       MIstep;

	float     MIx;
	float     MIy;
	float     MIwidth;
	float     MIheight;

	// for Design
	NSString *MItype;
	UIColor  *MIcolor;
	UIColor  *MIbackgroundColor;
	UIColor  *MIlineColor;
	int       MIlineWith;
	int       MIoffset;
	BOOL      MIvertical;
	float     MIbarRadius;
	float     MIbackgroundRadius;
	
	float   MIcircleWidth;
	float   MIhalfWidth;
}

@property(nonatomic, retain) id        MItarget;
@property(nonatomic, assign) SEL       MImagic;
@property(nonatomic, assign) int       MIdefaultDeg;
@property(nonatomic, assign) int       MIstep;

// for Design
@property(nonatomic, assign) float     MIx;
@property(nonatomic, assign) float     MIy;
@property(nonatomic, assign) float     MIwidth;
@property(nonatomic, assign) float     MIheight;
@property(nonatomic, retain) NSString *MItype;
@property(nonatomic, retain) UIColor  *MIcolor;
@property(nonatomic, retain) UIColor  *MIbackgroundColor;
@property(nonatomic, retain) UIColor  *MIlineColor;
@property(nonatomic, assign) int       MIlineWith;
@property(nonatomic, assign) int       MIoffset;
@property(nonatomic, assign) BOOL      MIvertical;
@property(nonatomic, assign) float     MIbarRadius;
@property(nonatomic, assign) float     MIbackgroundRadius;

@property(nonatomic, assign) float   MIcircleWidth;
@property(nonatomic, assign) float   MIhalfWidth;


- (id)contractWithWish:(CGRect)rect wish:(NSMutableDictionary *)wish;
- (void)setWish:(NSMutableDictionary *)wish;
- (void)setMagic:(id)target magic:(SEL)magic;

//synonym
- (id)initWithFrame:(CGRect)rect;
- (void)setDesign:(NSMutableDictionary *)design;
- (void)addTarget:(id)target action:(SEL)action;

@end
