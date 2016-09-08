//
//  User+CURD.m
//  yingwo
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "User+CURD.h"
#import "Test.h"
@implementation User (CURD)

+ (void)saveCustomerByUser:(User *)user {
    
    Customer *customer = [Customer MR_findFirst];
    
    if (customer == nil) {
        customer = [Customer MR_createEntity];
    }

    customer.userId          = user.userId;
    customer.mobile          = user.mobile;
    customer.name            = user.name;
    customer.signature       = user.signature;
    customer.sex             = user.sex;
    customer.face_img        = user.face_img;
    customer.academy_id      = user.academy_id;
    customer.academy_name    = user.academy_name;
    customer.school_id       = user.school_id;
    customer.school_name     = user.school_name;
    customer.register_status = user.register_status;
    customer.grade           = user.grade;
    customer.create_time     = user.create_time;

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
