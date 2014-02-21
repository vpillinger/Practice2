//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Vincent Pillinger on 2/21/14.
//  Copyright (c) 2014 Vincent Pillinger. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView
@synthesize faceCardScaleFactor = _faceCardScaleFactor;
#define DEFAULT_FACE_CARD_FACTOR 0.9

- (CGFloat) faceCardScaleFactor {
    if (!_faceCardScaleFactor) {
        _faceCardScaleFactor = DEFAULT_FACE_CARD_FACTOR;
    }
    return _faceCardScaleFactor;
}

- (void) setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

-(void)setSuit:(NSString *)suit {
    _suit = suit;
    [self setNeedsDisplay];
}
-(void)setRank:(NSUInteger)rank {
    _rank = rank;
    [self setNeedsDisplay];
}
-(void)setFaceUp:(BOOL)faceUp {
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius {
    return CORNER_RADIUS * [self cornerScaleFactor];
}
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0 ;}

- (NSString *)rankAsString {
    return [@[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"] objectAtIndex:[self.rank]];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = UITextAlignmentCenter;
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    NSString *cornerString = [NSString stringWithFormat:@"%@\n%@",[self rankAsString], self.suit];
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:cornerString attributes:@{NSFontAttributeName: cornerFont, NSParagraphStyleAttributeName:paragraphStyle}];
    CGRect textBounds;
    textBounds.size = [cornerText size];
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    [cornerText drawInRect:textBounds];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx,self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(ctx, M_PI);
    [cornerText drawInRect:textBounds];
    
    
}

- (void) drawPips {
    
}
- (void) setup {
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}
-(void)awakeFromNib {
    [self setup];
}
@end
