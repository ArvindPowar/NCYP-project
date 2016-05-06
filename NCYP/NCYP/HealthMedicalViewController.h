//
//  HealthMedicalViewController.h
//  NCYP
//
//  Created by arvind on 4/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface HealthMedicalViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)  UITableView *tableview;
@property(nonatomic,retain) NSMutableArray *filedListArray;
@property(nonatomic,retain) UIImageView *BgImg;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)UIButton *backBtn;
@property(nonatomic,retain) UIView *tabmenuView;
@property(nonatomic,retain) UIButton *refreshBtn,*searchBtn,*petrolBtn,*changeLangBtn;
@property(nonatomic,retain) UILabel *tempLbl,*usdpriceLbl,*europriceLbl,*poundpriceLbl;

@end
