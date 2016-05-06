//
//  GoViewController.h
//  NCYP
//
//  Created by arvind on 4/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "AsyncImageView/AsyncImageView.h"
@interface GoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,retain) NSString *longitudeLabel,*latitudeLabel;
@property(nonatomic,retain)  UITableView *tableview;
@property(nonatomic,retain) NSMutableArray *filedListArray;
@property(nonatomic,retain) UIImageView *BgImg;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)UIButton *backBtn;
@property(nonatomic,retain) UIView *tabmenuView;
@property(nonatomic,retain) UIButton *refreshBtn,*searchBtn,*petrolBtn,*changeLangBtn;
@property(nonatomic,retain) UIImageView *bannerImg;
@property(nonatomic,retain) UILabel *tempLbl,*usdpriceLbl,*europriceLbl,*poundpriceLbl;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AsyncImageView *bannerAsyncimg;
@property(nonatomic,retain)UIButton *bannerImgBtn;

@end
