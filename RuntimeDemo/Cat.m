//
//  Cat.m
//  RuntimeDemo
//
//  Created by Chin on 2020/3/27.
//  Copyright © 2020 Chin. All rights reserved.
//

#import "Cat.h"
#import "Dog.h"

#import <objc/runtime.h>
#import <objc/message.h>
@implementation Cat

+(void)catSleep{
    NSLog(@"catSleep");
}

//1.动态方法解析 添加一个方法实现
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == NSSelectorFromString(@"run")){
//        class_addMethod(objc_getClass("Cat"), sel, [[Dog new] methodForSelector:@selector(eat)], "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(sleep)) {
        Method method = class_getClassMethod(self, @selector(catSleep));
        class_addMethod(object_getClass(self), sel, method_getImplementation(method), method_getTypeEncoding(method));
        return YES;
    }
    return [super resolveClassMethod:sel];
}


//2. 如果上一步返回NO 进入消息转发流程 让其他类去相应消息
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    if (aSelector == NSSelectorFromString(@"run")){
//        return [Dog new];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

//3.如果上一步没有实现 就会进入方法签名流程
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == NSSelectorFromString(@"run")){
        return [[Dog new] methodSignatureForSelector:@selector(run)];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    if (anInvocation.selector == NSSelectorFromString(@"run")){
        return [anInvocation invokeWithTarget:[Dog new]];
    }
    return [super forwardInvocation:anInvocation];
}

@end
