//
//  UIButton+Block.h
//  ShareAndNav
//
//  Created by 徐成 on 15/11/11.
//  Copyright © 2015年 徐成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^ActionBlock)(UIButton* button);

@interface UIButton (Block)

- (void) handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock) block;
- (void) setup:(NSString*)title fontsize:(CGFloat)size fontColor:(UIColor*)fcolor bkColor:(UIColor*)bkcolor;
- (void) setup:(UIImage*)image framesize:(CGSize)size;

@end
