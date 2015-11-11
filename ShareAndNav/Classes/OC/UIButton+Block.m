//
//  UIButton+Block.m
//  ShareAndNav
//
//  Created by 徐成 on 15/11/11.
//  Copyright © 2015年 徐成. All rights reserved.
//

#import "UIButton+Block.h"

@implementation UIButton (Block)

static char overViewKey;

- (void) handleCOntrolEvent:(UIControlEvents)event withBlock:(void (^)(UIButton *))block {
    objc_setAssociatedObject(self, &overViewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

- (void) callActionBlock:(UIButton*)button {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overViewKey);
    if (block) {
        block(button);
    }
}

- (void) setup:(NSString*)title fontsize:(CGFloat)size fontColor:(UIColor*)fcolor bkColor:(UIColor*)bkcolor  {
    self.frame = CGRectMake(0, 0, size * title.length + 10, size + 5);
    [self setTitle:title forState:UIControlStateNormal];
    self.backgroundColor = bkcolor;
    self.layer.cornerRadius = 5;
    [self setTitleColor:fcolor forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:size];
}

- (void) setup:(UIImage*)image framesize:(CGSize)size {
    self.frame = CGRectMake(0, 0, size.width, size.height);
    [self setImage:image forState:UIControlStateNormal];
}

@end
