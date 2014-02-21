//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Vincent Pillinger on 2/21/14.
//  Copyright (c) 2014 Vincent Pillinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView
@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) CGFloat faceCardScaleFactor;
- (CGFloat)cornerScaleFactor ;
- (CGFloat)cornerRadius ;
- (CGFloat)cornerOffset ;

@end
