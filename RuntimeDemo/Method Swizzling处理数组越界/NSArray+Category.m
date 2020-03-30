//
//  NSArray+Category.m
//  RuntimeDemo
//
//  Created by Chin on 2020/3/30.
//  Copyright © 2020 Chin. All rights reserved.
//

#import "NSArray+Category.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
@implementation NSArray (Category)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        objc_getClass("__NSSingleObjectArrayI") 以前是 __NSArrayI
        [objc_getClass("__NSSingleObjectArrayI") swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(cf_objectAtIndex:)];
    });
    
}


- (id)cf_objectAtIndex:(NSUInteger)index{
    if(index > self.count-1){
        NSLog(@"数组越界了！");
        return nil;
    }else{
        return [self cf_objectAtIndex:index];
    }
}


@end
