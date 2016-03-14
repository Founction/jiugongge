//
//  shopInfo.h
//  九宫格
//
//  Created by 李胜营 on 16/3/14.
//  Copyright (c) 2016年 dasheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shopInfo : NSObject
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *icon;

+ (instancetype)shopWithDic:(NSDictionary *)dic;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
