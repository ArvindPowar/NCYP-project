//
//  AppDelegate.h
//  NCYP
//
//  Created by arvind on 4/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) NSMutableArray *allfieldsimgArray,*allfieldsNameArray,*allfielssubNameArray,*healthmedidetalisTxtArray,*healthmedidetalisimgArray,*healthmedInfoimgArray,*healthmedicalTxtArray,*plusSettingTXTArray,*plusSettingIMGArray,*emergencyTxtArray,*emergencyImagArray;
@property(nonatomic,readwrite) BOOL isSqurethemes,*isenglishselected,ishome;
@property(nonatomic,retain) NSString *currentlocation;
@property(nonatomic,retain) NSString *cityId;
@property(nonatomic,retain)NSString  *parentcategoryidStr,*backcategoryid;
@property(nonatomic,retain)NSString *backidStr,*backtoplacedetaliStr;
@property(nonatomic,retain)NSString *usdstr,*eurostr,*gbpstr,*tempstrl;
@property(nonatomic,readwrite)BOOL ishomenewBtnclick,ishomeaboutbtnclick;
-(void)gettempanddollerrate;

@end

