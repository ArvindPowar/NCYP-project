//
//  PlaceDetalisViewController.h
//  NCYP
//
//  Created by arvind on 5/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "PlaceVo.h"
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

@interface PlaceDetalisViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,retain) UIImageView *BgImg;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)UIButton *backBtn;
@property(nonatomic,retain) UIView *tabmenuView;
@property(nonatomic,retain) UIButton *refreshBtn,*searchBtn,*petrolBtn,*changeLangBtn;
@property(nonatomic,retain) UIImageView *bannerImg;
@property(nonatomic,retain) UILabel *tempLbl,*usdpriceLbl,*europriceLbl,*poundpriceLbl;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AsyncImageView *bannerAsyncimg,*discountasycimg;
@property(nonatomic,retain) PlaceVo *placeVO;
@property(nonatomic,retain) IBOutlet MKMapView *mapView;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property(nonatomic,readwrite) CLLocationCoordinate2D currentLocation;
@property(nonatomic,retain) MKPointAnnotation *annotation;
@property(nonatomic,retain)UIButton *bannerImgBtn,*findrouteBtn;

@end
