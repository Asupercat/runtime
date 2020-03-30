//
//  ViewController.m
//  RuntimeDemo
//
//  Created by Chin on 2020/3/27.
//  Copyright © 2020 Chin. All rights reserved.
//

#import "ViewController.h"
#import "Dog.h"
#import "Cat.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = @[@"1"];
    [arr objectAtIndex:2];
}

-(void)runtimeTest{
    Cat *cat = [Cat new];
    
    [cat performSelector:NSSelectorFromString(@"run")];
    [Cat performSelector:NSSelectorFromString(@"sleep")];
    
    /**
     类 Class
     objc_getClass(<#const char * _Nonnull name#>)  根据类名获取Class
     class_getName(<#Class  _Nullable __unsafe_unretained cls#>) 根据类获取类名
     objc_getMetaClass(<#const char * _Nonnull name#>)
     
     获取isa
     object_getClass(<#id  _Nullable obj#>)
     */
    
    Class cls = objc_getClass([@"Dog" UTF8String]);
    NSLog(@"class :- %@",cls);
    NSLog(@"classMame :- %s",class_getName(cls));
    
    
    /**获取成员变量列表
     去 class 的 class_ro_t 中 的 ivar_list 中获取ivar_t
     class_copyIvarList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)
     不包括分类中的属性 因为分类中的属性不会生成setter getter方法的实现和带下划线的成员变量
     ivar_getName(<#Ivar  _Nonnull v#>)
     ivar_getTypeEncoding(<#Ivar  _Nonnull v#>)  @ : object  / c : A char  / q : long long
     */
    
    Class tfClass = objc_getClass([@"UITextField" UTF8String]);
    unsigned int outCount = 0;
    Ivar *ivarList =  class_copyIvarList(tfClass, &outCount);
    NSMutableArray *arr = [NSMutableArray array];
    for (unsigned int i = 0; i < outCount; i++) {
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        NSDictionary *ivarDic = @{@"ivarName" : [NSString stringWithUTF8String:ivarName],
                                  @"ivarType" : [NSString stringWithUTF8String:ivarType]};
        [arr addObject:ivarDic];
    }
    free(ivarList);
    //    NSLog(@"%@",arr);
    
    /**获取属性列表
     去 class 的 class_rw_t 中 property_array_t  获取  property_t
     class_getProperty(<#Class  _Nullable __unsafe_unretained cls#>, <#const char * _Nonnull name#>)
     property_getName(<#objc_property_t  _Nonnull property#>)
     property_getAttributes(<#objc_property_t  _Nonnull property#>)  //属性内容
     */
    
    /**获取类方法列表
     class_copyMethodList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)
     */
    
    /**获取协议列表
     class_getProperty(<#Class  _Nullable __unsafe_unretained cls#>, <#const char * _Nonnull name#>)
     */
    
    /**动态添加变量
     class_addIvar(<#Class  _Nullable __unsafe_unretained cls#>, <#const char * _Nonnull name#>, <#size_t size#>, <#uint8_t alignment#>, <#const char * _Nullable types#>)
     到 class_ro_t 中的 ivar_list 中添加内容
     
     只能在 objc_allocateClassPairz之后 , objc_registerClassPair之前使用
     因为编译好的类 InstanceSize 因为内存布局已经确定了
     
     1.首先判断是否元类 元类无法添加
     2.已经加载进内存的类是无法添加的
     3.如果旧列表已经存在 -> 新建一个列表 添加一个变量 -> 旧列表的内容添加到新列表
     如果没有旧列表 -> 创建新列表
     
     创建类 , 并给类设置基本信息 并且关联父类元类关系
     objc_allocateClassPair(<#Class  _Nullable __unsafe_unretained superclass#>, <#const char * _Nonnull name#>, <#size_t extraBytes#>)
     
     将类名和类信息添加到全局列表中
     objc_registerClassPair(<#Class  _Nonnull __unsafe_unretained cls#>)
     */
    
    /**动态添加方法
     class_addMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>, <#IMP  _Nonnull imp#>, <#const char * _Nullable types#>)
     */
}
@end
