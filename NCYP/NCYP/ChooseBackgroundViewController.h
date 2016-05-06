//
//  ChooseBackgroundViewController.h
//  NCYP
//
//  Created by arvind on 4/26/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"
@interface ChooseBackgroundViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) UIImageView *BgImg;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)UIButton *backBtn;
@property(nonatomic,retain) UIView *tabmenuView;
@property(nonatomic,retain) UIButton *refreshBtn,*searchBtn,*petrolBtn,*changeLangBtn,*btnImag1,*btnImag7,*btnImag2,*btnImag3,*btnImag4,*btnImag5,*btnImag6,*btnImag8,*btnImag9;
@property(nonatomic,retain) UIImageView *bannerImg;
@property(nonatomic,retain) UILabel *tempLbl,*usdpriceLbl,*europriceLbl,*poundpriceLbl;
@property(nonatomic,retain) AsyncImageView *bannerAsyncimg;
@property(nonatomic,retain)UIButton *bannerImgBtn;

@end
