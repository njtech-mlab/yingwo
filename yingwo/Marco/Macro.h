//
//  Macro.h
//  yingwo
//
//  Created by apple on 16/7/10.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//


/*
 *  全局宏，所有文件共享的宏都放在这里
 */
#ifndef Macro_h
#define Macro_h
/********************************Color************************************************/
#define THEME_COLOR_1    @"#1DD2A6"
#define THEME_COLOR_2    @"#3A3A3A"
#define THEME_COLOR_3    @"#8E8E8E"
#define THEME_COLOR_4    @"#BBBBBB"
#define THEME_COLOR_5    @"#DEDFED"
#define BACKGROUND_COLOR @"F3F3F3"
#define RED_COLOR        @"E92D52"
/********************************Color************************************************/


/********************************Count************************************************/
#define COUNT_DOWN_TIME 5
/********************************Count************************************************/


/********************************storyboard identifier************************************************/

#define CONTROLLER_OF_MAINVC_IDENTIFIER         @"MainController"
#define CONTROLLER_OF_LOGINVC_IDENTIFIER        @"LoginController"
#define CONTROLLER_OF_HOME_IDENTIFIER           @"HomeController"
#define CONTROLLER_OF_DISCOVERY_IDENTIFIER      @"DiscoveryController"
#define CONTROLLER_OF_PERSONNAL_CENTER_IDENTIFY @"PersonalCenter"
#define CONTROLLER_OF_ANNOUNCE_IDENTIFIER       @"AnnounceController"
/********************************storyboard identifier************************************************/


/********************************segue identify************************************************/
#define SEGUE_IDENTIFY_LOGIN          @"login"
#define SEGUE_IDENTIFY_RESET          @"reset"
#define SEGUE_IDENTIFY_REGISTER       @"register"
#define SEGUE_IDENTIFY_VERFIFCATION   @"verification"
#define SEGUE_IDENTIFY_RESETPASSWORD  @"resetPassword"
#define SEGUE_IDENTIFY_WRITENICKNAME  @"writeNickname"
#define SEGUE_IDENTIFY_WRITESIGNATURE @"writeSignature"
#define SEGUE_IDENTIFY_PERFECTINFO    @"perfectInfo"
#define SEGUE_IDENTIFY_CONFIGURATION  @"cofiguration"
#define SEGUE_IDENTIFY_MODIFY         @"modify"
#define SEGUE_IDENTIFY_BASEINFO       @"baseInfo"
/********************************segue identify************************************************/


/********************************* URL ******************************************************/
#define BASE_URL        @"http://yw.zhibaizhi.com/yingwophp/api/v1"
#define LOGIN_URL       @"/User/Login"
#define REGISTER_URL    @"/login/register"
#define SMS_URL         @"/login/getRegisterSMS"
#define HEADIMAGE_URL   @"/Public/uploads/"
#define TIEZI_URL       @"/post/post_get_list"
#define ANNOUNCE_FRESH_THING_URL @"/post/post_add"

#define QINIU_BASE_URL @"http://obabu2buy.bkt.clouddn.com"
#define QINIU_TOKEN_URL @"/qiniu/getAT"
/********************************* URL ******************************************************/

/********************************* 七牛图片模式 imageView2 model**************************/
//居中裁剪图片的模式，网络较差时图片渐进显示
#define QINIU_SQUARE_IMAGE_MODEL @"?imageView2/1/w/%d/interlace/1"
//图片等比缩放,这里我限定宽度和长度，替2g网节省流量😊，其中参数中的长和宽都是像素值！(1pt=2px)
#define QINIU_PROPORTION_IMAGE_MODEL @"?imageView2/0/w/%d/h/%d/interlace/1"
/********************************* 七牛图片模式 imageView2 model**************************/


/********************************* network status code ******************************************/
#define SUCCESS_STATUS 200
#define FAILURE_STATUS 403
#define ILLEGAL_TOKEN_STATUS 401
/********************************* network status code ******************************************/

/********************************* key ******************************************************/
//登录、注册
#define USERNAME     @"name"
#define PASSWORD     @"password"
#define VERFIFCATION @"verification"
#define MOBILE       @"mobile"

//贴子
#define CAT_ID @"cat_id"
/********************************* key ******************************************************/

/********************************* 魔数 ******************************************************/
#define MOSHU @"123456789"

/********************************* 设备物理尺寸 ************************************************/
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width   //屏幕宽度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height   //屏幕高度
#define INPUTTEXTFIELD_WIDTH ([[UIScreen mainScreen] bounds].size.width - 20 ) //输入框宽度
#define IPHONE_5_INPUTTEXTFIELD_HEIGHT 40    //iphone5上的输入框高度
/********************************* 设备物理尺寸 ************************************************/


/********************************* 设备类别 ************************************************/
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )960) < DBL_EPSILON )
/********************************* 设备类别 ************************************************/


/******************************* 第三方框架需要尺寸，有些数据会与之前定义的宏重复 ****************************/
#define ScreenSize [UIScreen mainScreen].bounds.size
#define kThumbnailLength    ([UIScreen mainScreen].bounds.size.width - 5*5)/4
#define kThumbnailSize      CGSizeMake(kThumbnailLength, kThumbnailLength)
#define DistanceFromTopGuiden(view) (view.frame.origin.y + view.frame.size.height)
#define DistanceFromLeftGuiden(view) (view.frame.origin.x + view.frame.size.width)
#define ViewOrigin(view)   (view.frame.origin)
#define ViewSize(view)  (view.frame.size)
/******************************* 第三方框架需要尺寸，有些数据会与之前定义的宏重复 ****************************/


#endif /* Macro_h */
