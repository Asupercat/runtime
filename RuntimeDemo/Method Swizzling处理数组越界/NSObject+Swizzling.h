//
//  NSObject+Swizzling.h
//  RuntimeDemo
//
//  Created by Chin on 2020/3/30.
//  Copyright © 2020 Chin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)

+ (void)swizzleMethod:(SEL)originalSel withMethod:(SEL)swizzledSel;

@end

NS_ASSUME_NONNULL_END
