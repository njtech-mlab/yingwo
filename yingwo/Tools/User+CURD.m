//
//  User+CURD.m
//  yingwo
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "User+CURD.h"

@implementation User (CURD)

+ (void)saveCustomerByUser:(User *)user {
    
    Customer *customer = [Customer MR_createEntity];

    customer.userId        = user.userId;
    customer.username      = user.username;
    customer.nickname      = user.nickname;
    customer.nickname_py   = user.nickname_py;
    customer.head_img      = user.head_img;
    customer.age           = user.age;
    customer.telphone      = user.telphone;
    customer.address       = user.address;
    customer.register_time = user.register_time;
    customer.status        = user.status;
    customer.college       = user.college;
    customer.major         = user.major;
    customer.grade         = user.grade;
    customer.gender        = user.gender;
    customer.school        = user.school;
    customer.sessionid     = user.sessionid;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+ (void)deleteCustoer {
    Customer *customer = [Customer MR_findFirst];
    [customer MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+ (Customer *)findCustomer {
    
    Customer *customer = [Customer MR_findFirst];
    
    return customer;
}

+ (void)modifyCustomerByKey:(NSString *)key value:(NSString *)value {
   
    Customer *customer = [Customer MR_findFirst];
    [customer setValue:value forKey:key];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

}

/***********************************login cookie**************************************************/

+ (BOOL)saveLoginInformationWithUsernmae:(NSString *)phone password:(NSString *)password {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:phone forKey:USERNAME];
    [userDefaults setObject:password forKey:PASSWORD];
    
    return YES;
}

+ (BOOL)haveExistedLoginInformation {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username           = [userDefaults objectForKey:USERNAME];
    if (username.length != 0) {
        return YES;
    }
    return NO;
}

+ (NSString *)getUsername {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username           = [userDefaults objectForKey:USERNAME];

    return username;
}

+ (NSString *)getPasswoord {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *password           = [userDefaults objectForKey:PASSWORD];
    
    return password;
}

+ (void)deleteLoginInformation {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:USERNAME];
    [userDefaults setObject:nil forKey:PASSWORD];
    
}

@end
