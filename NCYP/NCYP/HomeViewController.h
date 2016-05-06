//
//  HomeViewController.h
//  NCYP
//
//  Created by arvind on 4/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"

@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate, UISearchBarDelegate,NSXMLParserDelegate>{
    BOOL isSearching;
}

@property(nonatomic,retain) UIImageView *BgImg,*goImg1,*plusImg2,*searchImg3,*discountImg4,*centerImg,*verticalImg;
@property(nonatomic,retain) UIButton *showBtn,*firstBtn,*sendBtn,*thirdBtn,*fourBtn,*backBtn;
@property(nonatomic,retain) UIView *tabmenuView;
@property(nonatomic,retain) UIButton *refreshBtn,*searchBtn,*petrolBtn,*changeLangBtn,*bannerImg;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) UILabel *tempLbl,*usdpriceLbl,*europriceLbl,*poundpriceLbl;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AsyncImageView *bannerAsyncimg;
@property(nonatomic,retain) NSString *characters,*searchString,*currentElement,*itemStr,*itemfound;
@property (nonatomic, retain) NSMutableString *currentElementData;

@end


