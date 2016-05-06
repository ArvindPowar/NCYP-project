//
//  VideoViewController.h
//  NCYP
//
//  Created by arvind on 5/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AsyncImageView.h"
#import "CustomIOS7AlertView.h"
#import <QuartzCore/QuartzCore.h>

@interface VideoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,retain)  UITableView *tableview;
@property(nonatomic,retain) NSMutableArray *filedListArray,*imageArray;
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
@property(nonatomic,retain) CustomIOS7AlertView *alertView;
@property(nonatomic,retain) AVPlayer *player;
@property(nonatomic,retain) NSString *videourl;
@end
