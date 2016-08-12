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

@end
