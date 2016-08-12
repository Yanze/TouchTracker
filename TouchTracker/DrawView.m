//
//  DrawView.m
//  TouchTracker
//
//  Created by yanze on 8/12/16.
//  Copyright © 2016 yanzeliu. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

- (instancetype) initWithFrame:(CGRect)r {
    self = [super initWithFrame:r];
    if(self) {
        self.finishedLines = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

// define the line
- (void)strokeLine: (Line *)line {
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor]set];
    for (Line *line in self.finishedLines) {
        [self strokeLine:line];
    }
    if(self.currentLine) {
        [[UIColor redColor]set];
        [self strokeLine:self.currentLine];
    }
}

// create new line
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = [touches anyObject];
    // get location of the touch in the view's coordiantion system
    CGPoint location = [t locationInView:self];
    
    self.currentLine = [[Line alloc]init];
    self.currentLine.begin = location;
    self.currentLine.end = location;
    [self setNeedsDisplay];
}

// update the end of the currentLine
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = [touches anyObject];
    CGPoint location = [t locationInView: self];
    self.currentLine.end = location;
    [self setNeedsDisplay];
}

// add the currentLine to the finishedLines when the touch ends
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.finishedLines addObject:self.currentLine];
    self.currentLine = nil;
    [self setNeedsDisplay];
}

@end
