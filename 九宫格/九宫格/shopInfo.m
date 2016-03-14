//
//  shopInfo.m
//  九宫格
//
//  Created by 李胜营 on 16/3/14.
//  Copyright (c) 2016年 dasheng. All rights reserved.
//

#import "shopInfo.h"

@implementation shopInfo
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.icon = dic[@"icon"];
        self.name = dic[@"name"];
    }
    return self;
}

+ (instancetype)shopWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}


@end
