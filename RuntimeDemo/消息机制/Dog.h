//
//  Dog.h
//  RuntimeDemo
//
//  Created by Chin on 2020/3/27.
//  Copyright © 2020 Chin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject

@property(nonatomic ,assign) NSInteger age;
@property(nonatomic ,strong) NSString *name;

-(void)eat;

+(void)sleep;

-(void)run;
@end

NS_ASSUME_NONNULL_END
