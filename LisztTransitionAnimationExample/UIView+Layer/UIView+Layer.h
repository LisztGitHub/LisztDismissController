//
//  UIView+Layer.h
//  TourismProject
//
//  Created by Liszt on 2017/5/15.
//  Copyright © 2017年 Liszt. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE  //动态刷新

@interface UIView (Layer)
@property (nonatomic,assign)IBInspectable CGFloat borderWidth;

@property (nonatomic,strong)IBInspectable UIColor *borderColor;

@property (nonatomic,assign)IBInspectable CGFloat cornerRadius;
@end
