//
//  DailyHoroscopeViewController.h
//  NCYP
//
//  Created by arvind on 5/6/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "ItemVO.h"

@interface DailyHoroscopeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate, UISearchBarDelegate,NSXMLParserDelegate>
@property(nonatomic,retain)  UITableView *tableview;
@property(nonatomic,retain) NSMutableArray *horoscopeArraylist;
@property(nonatomic,retain) UIImageView *BgImg;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)UIButton *backBtn;
@property(nonatomic,retain) UIView *tabmenuView;
@property(nonatomic,retain) UIButton *refreshBtn,*searchBtn,*petrolBtn,*changeLangBtn;
@property(nonatomic,retain) UILabel *tempLbl,*usdpriceLbl,*europriceLbl,*poundpriceLbl;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AsyncImageView *bannerAsyncimg;
@property(nonatomic,retain)UIButton *bannerImgBtn;
@property(nonatomic,retain)NSString *backidStr;
@property(nonatomic,retain) NSString *characters,*searchString,*currentElement,*itemStr,*itemfound;
@property (nonatomic, retain) NSMutableString *currentElementData;
@property(nonatomic,retain) ItemVO * itemVO;

@end
