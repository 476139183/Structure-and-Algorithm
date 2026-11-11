//
//  NSObject+KCKVO.m
//  002---KVO自定义
//
//  Created by Cooci on 2018/5/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "NSObject+KCKVO.h"
#import <objc/message.h>

static NSString *const kKCKVOPrefix = @"KCKVO_";
static NSString *const kKCKVOAssioKey = @"kKVOAssociatedKey";

@interface KC_Info:NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, copy) KCKVOBlock handleBlock;

@end

@implementation KC_Info

- (instancetype)initWithObserver:(NSObject *)observer keyPath:(NSString *)keyPath handle:(KCKVOBlock)handleBlock{
    if (self = [super init]) {
        _observer = observer;
        _keyPath = keyPath;
        _handleBlock = handleBlock;
    }
    return self;
}

- (void)dealloc{
    NSLog(@"KCInfo销毁");
}

@end


@implementation NSObject (KCKVO)

- (void)kc_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath handler:(KCKVOBlock)block{
    
    //0:刷掉实例--> setter
    //keypath: name ==> setName:
    SEL setterSeletor = NSSelectorFromString(setterfromGetter(keyPath));
    
    Method setterMethod = class_getInstanceMethod(object_getClass(self), setterSeletor);
    
    if (!setterMethod) {
        
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%@ not have %@ setterMethod",self,keyPath] userInfo:nil];
    }
    
    //1: NSKVONotifying_Person自动生成一个动态子类
    
    Class superClass = object_getClass(self);
    Class newClass;
    NSString *superName = NSStringFromClass(superClass);
    if (![superName hasPrefix:kKCKVOPrefix]) {
        
        newClass = [self creatClassFromSuperName:superName];

        object_setClass(self, newClass);
    }

    //2: 调用了Setter方法 子类重写
    
    
    if (![self hasSeletor:setterSeletor]) {
        const char *type = method_getTypeEncoding(setterMethod);
        class_addMethod(newClass, setterSeletor, (IMP)KCKVO_Setter, type);
    }

    
    //保存数据
    KC_Info *info = [[KC_Info alloc] initWithObserver:observer keyPath:keyPath handle:block];
    
    NSMutableArray *mArray = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kKCKVOAssioKey));
    
    if (!mArray) {
        mArray = [NSMutableArray arrayWithCapacity:1];
        
        objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(kKCKVOAssioKey), mArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [mArray addObject:info];
    
    //交换方法
    
    Method myDelloc = class_getInstanceMethod(newClass, @selector(myDealloc));
    Method delloc = class_getInstanceMethod(newClass, NSSelectorFromString(@"dealloc"));
    method_exchangeImplementations(myDelloc, delloc);
    

}


- (Class)creatClassFromSuperName:(NSString *)superName{
    
    //创建 KCKVO_子类
    
    /**
     1:根据父类创建子类
     2:什么名字
     3:开辟的内存空间
     */
    
    //Person
    Class superClass = NSClassFromString(superName);
    //KCKVO_Person
    NSString *newClassName = [kKCKVOPrefix stringByAppendingString:superName];
    Class newClass = NSClassFromString(newClassName);
    if (newClass) {return newClass;}
    
    newClass = objc_allocateClassPair(superClass, newClassName.UTF8String, 0);
    
    //添加class方法
    
    /**
     1:给谁添加方法
     2:SEL 方法选择器 方法编号 ---> 方法
     3:IMP: 方法实现的函数指针
     4:type
     */
    
    Method superClassMethod = class_getClassMethod(superClass, @selector(class));
    
    const char *type = method_getTypeEncoding(superClassMethod);
    
    class_addMethod(newClass, @selector(class), (IMP)KCKVO_Class, type);
    
    //注册类
    objc_registerClassPair(newClass);
    
    return newClass;
}


- (BOOL)hasSeletor:(SEL)selector{
    
    Class observedClass = object_getClass(self);
    unsigned int methodCount = 0;
    
    //得到一堆方法的名字列表  //class_copyIvarList 实例变量  //class_copyPropertyList 得到所有属性名字
    Method *methodList = class_copyMethodList(observedClass, &methodCount);
    
    for (int i = 0; i<methodCount; i++) {
        SEL sel = method_getName(methodList[i]);
        if (selector == sel) {
            free(methodList);
            return YES;
        }
    }
    free(methodList);
    return NO;
}

- (void)myDealloc{
    
    NSString *nowClassName = NSStringFromClass(object_getClass(self));
    
    NSString *superClassName = [nowClassName stringByReplacingOccurrencesOfString:kKCKVOPrefix withString:@""];
    
    Class superClass = NSClassFromString(superClassName);
    object_setClass(self, superClass);
    
    NSMutableArray *mArray = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kKCKVOAssioKey));
    [mArray removeAllObjects];
    
    [self myDealloc];
}





#pragma mark - 函数区域

static void KCKVO_Setter(id self,SEL _cmd,id newValue){
    
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterfromSetter(setterName);
    if (!getterName) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%@ not have getterName",self] userInfo:nil];
    }
    
    id oldValue = [self valueForKey:getterName];
    
    [self willChangeValueForKey:getterName];
    //消息转发
    
    struct objc_super superClassStruct = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*KCSendSuperMessage)(void *, SEL, id) = (void *)objc_msgSendSuper;
    
    KCSendSuperMessage(&superClassStruct,_cmd,newValue);
    
    [self didChangeValueForKey:getterName];
    
//    NSLog(@"%@",newValue);
    
    NSMutableArray *mArray = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kKCKVOAssioKey));
    
    for (KC_Info *info in mArray) {
        
        if ([info.keyPath isEqualToString:getterName]) {
            
            dispatch_async(dispatch_queue_create(0, 0), ^{
               
                info.handleBlock(info.observer, info.keyPath, newValue, oldValue);
            });
        }
    }

    
}

static Class KCKVO_Class(id self,SEL _cmd){
    return class_getSuperclass(object_getClass(self));
}

//name ===>> setName:
static NSString * setterfromGetter(NSString * getter){
    
    if (getter.length <= 0) { return nil;}
    //name
    NSString *firtString = [[getter substringToIndex:1] uppercaseString];
    NSString *leaveString = [getter substringFromIndex:1]; //ame
    
    return [NSString stringWithFormat:@"set%@%@:",firtString,leaveString];
    
}


//setName: ===>>> name
static NSString * getterfromSetter(NSString * setter){
    
    if (setter.length <= 0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) { return nil;}
    
    //setName:  ===>> Name:  ====> Name ==> name
    NSRange range = NSMakeRange(3, setter.length-4);
    NSString *getter = [setter substringWithRange:range];
    NSString *firstString = [[getter substringToIndex:1] lowercaseString]; //n
    getter = [getter stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstString];
    
    return getter;
}

@end
