//
//  SuggestNewLocationViewController.h
//  NCYP
//
//  Created by arvind on 4/26/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import "AsyncImageView.h"
@interface SuggestNewLocationViewController : UIViewController<UITextFieldDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,retain) UIImageView *BgImg;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)UIButton *backBtn,*submitBtn;
@property(nonatomic,retain) UIView *tabmenuView;
@property(nonatomic,retain) UIButton *refreshBtn,*searchBtn,*petrolBtn,*changeLangBtn;
@property(nonatomic,retain) UIImageView *bannerImg;
@property(nonatomic,retain) UILabel *tempLbl,*usdpriceLbl,*europriceLbl,*poundpriceLbl,*nameLbl,*addressLbl,*cityLbl,*categoryLbl;
@property(nonatomic,retain) UITextField *nameTXT,*addressTXT,*cityTXT,*categoryTXT;
@property(nonatomic,retain) IBOutlet MKMapView *mapView;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property(nonatomic,readwrite) CLLocationCoordinate2D currentLocation;
@property(nonatomic,retain) MKPointAnnotation *annotation;
@property(nonatomic,retain) AsyncImageView *bannerAsyncimg;
@property(nonatomic,retain)UIButton *bannerImgBtn;

@end
