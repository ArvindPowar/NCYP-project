//
//  SuggestNewLocationViewController.m
//  NCYP
//
//  Created by arvind on 4/26/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "SuggestNewLocationViewController.h"
#import "SettingViewController.h"
#import "PlusViewController.h"
#import "UIColor+Expanded.h"
#import "AboutUsViewController.h"
#import "NewsViewController.h"

@interface SuggestNewLocationViewController ()

@end

@implementation SuggestNewLocationViewController
@synthesize BgImg,appDelegate,backBtn,tabmenuView,refreshBtn,searchBtn,petrolBtn,changeLangBtn,bannerImg,tempLbl,usdpriceLbl,europriceLbl,poundpriceLbl,nameLbl,addressLbl,cityLbl,categoryLbl,nameTXT,addressTXT,cityTXT,categoryTXT,mapView,locationManager,currentLocation,annotation,submitBtn,bannerAsyncimg,bannerImgBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    BgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width, screenRect.size.height)];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs stringForKey:@"BackgroundColor"]!=nil) {
        NSString *backgroundStr=[[NSString alloc]init];
        backgroundStr=[prefs stringForKey:@"BackgroundColor"];
        [BgImg setImage:[UIImage imageNamed:backgroundStr]];
    }else{
        [BgImg setImage:[UIImage imageNamed:@"bg-sample.jpg"]];
    }
    [self.view addSubview:BgImg];
    
    bannerAsyncimg=[[AsyncImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,20,screenRect.size.width*0.70,screenRect.size.height*0.15)];
    [bannerAsyncimg.layer setMasksToBounds:YES];
    bannerAsyncimg.clipsToBounds=YES;
    [bannerAsyncimg setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bannerAsyncimg];
    
    bannerImgBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,20,screenRect.size.width*0.70,screenRect.size.height*0.15)];
    [bannerImgBtn addTarget:self action:@selector(aboutusAction) forControlEvents:UIControlEventTouchUpInside];
    [bannerImgBtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bannerImgBtn];
    [self.view bringSubviewToFront:bannerImgBtn];

    backBtn=[[UIButton alloc]initWithFrame:CGRectMake(15,40,screenRect.size.width*0.12,screenRect.size.height*0.08)];
    [backBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    backBtn.layer.cornerRadius = 6.0f;
    //[backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"undo_icon.png"]forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIFont *customFontdreg = [UIFont boldSystemFontOfSize:screenRect.size.width*0.035];

    nameLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.19,screenRect.size.width*0.96,screenRect.size.height*0.05)];
    [nameLbl setFont:customFontdreg];
    nameLbl.text=@"Name";
    nameLbl.textAlignment=NSTextAlignmentLeft;
    [nameLbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:nameLbl];

    nameTXT=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.24, screenRect.size.width*0.96, screenRect.size.height*0.06)];
    [nameTXT setFont:customFontdreg];
    nameTXT.delegate = self;
    nameTXT.textAlignment = UITextAlignmentLeft;
    nameTXT.textColor=[UIColor blackColor];
    [nameTXT setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:nameTXT];

    addressLbl=[[UILabel alloc]initWithFrame:CGRectMake(10,screenRect.size.height*0.30,screenRect.size.width*0.96,screenRect.size.height*0.05)];
    [addressLbl setFont:customFontdreg];
    addressLbl.text=@"Address";
    addressLbl.textAlignment=NSTextAlignmentLeft;
    [addressLbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:addressLbl];
    
    addressTXT=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.35, screenRect.size.width*0.96, screenRect.size.height*0.06)];
    [addressTXT setFont:customFontdreg];
    addressTXT.delegate = self;
    addressTXT.textAlignment = UITextAlignmentLeft;
    addressTXT.textColor=[UIColor blackColor];
    [addressTXT setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:addressTXT];

    cityLbl=[[UILabel alloc]initWithFrame:CGRectMake(10,screenRect.size.height*0.41,screenRect.size.width*0.96,screenRect.size.height*0.05)];
    [cityLbl setFont:customFontdreg];
    cityLbl.text=@"City";
    cityLbl.textAlignment=NSTextAlignmentLeft;
    [cityLbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:cityLbl];

    cityTXT=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.46, screenRect.size.width*0.96, screenRect.size.height*0.06)];
    [cityTXT setFont:customFontdreg];
    cityTXT.delegate = self;
    cityTXT.textAlignment = UITextAlignmentLeft;
    cityTXT.textColor=[UIColor blackColor];
    [cityTXT setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:cityTXT];

    categoryLbl=[[UILabel alloc]initWithFrame:CGRectMake(10,screenRect.size.height*0.52,screenRect.size.width*0.96,screenRect.size.height*0.05)];
    [categoryLbl setFont:customFontdreg];
    categoryLbl.text=@"Category";
    categoryLbl.textAlignment=NSTextAlignmentLeft;
    [categoryLbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:categoryLbl];

    categoryTXT=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.57, screenRect.size.width*0.96, screenRect.size.height*0.06)];
    [categoryTXT setFont:customFontdreg];
    categoryTXT.delegate = self;
    categoryTXT.textAlignment = UITextAlignmentLeft;
    categoryTXT.textColor=[UIColor blackColor];
    [categoryTXT setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:categoryTXT];

    mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.64, screenRect.size.width, screenRect.size.height*0.24)];
    [self.view addSubview:mapView];

    
    submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.885, screenRect.size.width*0.60, screenRect.size.height*0.045)];
    [submitBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    submitBtn.layer.cornerRadius = 6.0f;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[submitBtn setBackgroundImage:[UIImage imageNamed:@"Acil_btn.png"]forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIColor colorWithHexString:@"eb0a8d"]];
    //[submitBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];

    locationManager = [[CLLocationManager alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [locationManager startUpdatingLocation];
    
    mapView.delegate=self;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate =self;
    [locationManager startUpdatingLocation];
    
    
    
    UILongPressGestureRecognizer* lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.5;
    lpgr.delegate = self;

    if ([prefs stringForKey:@"BackgroundColor"]!=nil) {
        NSString *backgroundStr=[[NSString alloc]init];
        backgroundStr=[prefs stringForKey:@"BackgroundColor"];
        if ([backgroundStr isEqualToString:@"bg_tile_2.png"] || [backgroundStr isEqualToString:@"bg_tile_3.PNG"] ||[backgroundStr isEqualToString:@"bg_tile_5.png"]) {
            nameLbl.textColor=[UIColor blackColor];
            addressLbl.textColor=[UIColor blackColor];
            cityLbl.textColor=[UIColor blackColor];
            categoryLbl.textColor=[UIColor blackColor];
        }else{
            nameLbl.textColor=[UIColor whiteColor];
            addressLbl.textColor=[UIColor whiteColor];
            cityLbl.textColor=[UIColor whiteColor];
            categoryLbl.textColor=[UIColor whiteColor];
        }
    }else{
        nameLbl.textColor=[UIColor whiteColor];
        addressLbl.textColor=[UIColor whiteColor];
        cityLbl.textColor=[UIColor whiteColor];
        categoryLbl.textColor=[UIColor whiteColor];
    }

    tabmenuView = [[UIView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.93,screenRect.size.width,screenRect.size.height*0.07)];
    tabmenuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_banner.png"]];
    [self.view addSubview:tabmenuView];
    
    refreshBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.015,screenRect.size.height*0.94,screenRect.size.height*0.05,screenRect.size.height*0.045)];
    refreshBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [refreshBtn setBackgroundImage:[UIImage imageNamed:@"update.png"]
                          forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
    
    searchBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.12,screenRect.size.height*0.94,screenRect.size.height*0.05,screenRect.size.height*0.045)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search.png"]
                         forState:UIControlStateNormal];
    //[searchBtn addTarget:self action:@selector(createNewClient) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    petrolBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.80,screenRect.size.height*0.94,screenRect.size.height*0.05,screenRect.size.height*0.045)];
    petrolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [petrolBtn setBackgroundImage:[UIImage imageNamed:@"news.png"]
                         forState:UIControlStateNormal];
    [petrolBtn addTarget:self action:@selector(newAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:petrolBtn];
    
    changeLangBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.90,screenRect.size.height*0.94,screenRect.size.height*0.05,screenRect.size.height*0.045)];
    [changeLangBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:25]];
    changeLangBtn.layer.cornerRadius = 6.0f;
    [changeLangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeLangBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    changeLangBtn.tag=0;
    [changeLangBtn addTarget:self action:@selector(langSettingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeLangBtn];
    
    NSString *langStr=[[NSString alloc]init];
    langStr=[prefs stringForKey:@"Languages"];
    if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil || [prefs stringForKey:@"Languages"]==nil){
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"turkish.png"]
                                 forState:UIControlStateNormal];
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"english.png"] forState:UIControlStateSelected];
        
        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerE"]]];
    }else{
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"english.png"]
                                 forState:UIControlStateNormal];
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"turkish.png"] forState:UIControlStateSelected];
            [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerT"]]];
        }
    UIFont *customFontview = [UIFont boldSystemFontOfSize:screenRect.size.width*0.03];
    
    tempLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.23,screenRect.size.height*0.94,screenRect.size.width*0.13,30)];
    [tempLbl setFont:customFontview];
    tempLbl.textColor=[UIColor whiteColor];
    tempLbl.textAlignment=NSTextAlignmentCenter;
    [tempLbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tempLbl];
    
    usdpriceLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.94,screenRect.size.width*0.13,30)];
    [usdpriceLbl setFont:customFontview];
    usdpriceLbl.textColor=[UIColor whiteColor];
    usdpriceLbl.textAlignment=NSTextAlignmentCenter;
    [usdpriceLbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:usdpriceLbl];
    
    europriceLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.47,screenRect.size.height*0.94,screenRect.size.width*0.13,30)];
    [europriceLbl setFont:customFontview];
    europriceLbl.textColor=[UIColor whiteColor];
    europriceLbl.textAlignment=NSTextAlignmentCenter;
    [europriceLbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:europriceLbl];
    
    poundpriceLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.59,screenRect.size.height*0.94,screenRect.size.width*0.13,30)];
    [poundpriceLbl setFont:customFontview];
    poundpriceLbl.textColor=[UIColor whiteColor];
    poundpriceLbl.textAlignment=NSTextAlignmentCenter;
    [poundpriceLbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:poundpriceLbl];
    
    usdpriceLbl.text=[prefs stringForKey:@"USD"];
    europriceLbl.text=[prefs stringForKey:@"EURO"];
    poundpriceLbl.text=[prefs stringForKey:@"POUND"];
    tempLbl.text=[prefs stringForKey:@"TEMP"];

}
-(void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs stringForKey:@"BackgroundColor"]!=nil) {
        NSString *backgroundStr=[[NSString alloc]init];
        backgroundStr=[prefs stringForKey:@"BackgroundColor"];
        [BgImg setImage:[UIImage imageNamed:backgroundStr]];
    }else{
        [BgImg setImage:[UIImage imageNamed:@"bg-sample.jpg"]];
    }
    NSString *langStr=[[NSString alloc]init];
    langStr=[prefs stringForKey:@"Languages"];
    if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil || [prefs stringForKey:@"Languages"]==nil){
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"turkish.png"]
                                 forState:UIControlStateNormal];
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"english.png"] forState:UIControlStateSelected];
        
        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerE"]]];
    }else{
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"english.png"]
                                 forState:UIControlStateNormal];
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"turkish.png"] forState:UIControlStateSelected];
        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerT"]]];
    }
    
}

-(IBAction)refreshAction{
    [appDelegate gettempanddollerrate];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    usdpriceLbl.text=[prefs stringForKey:@"USD"];
    europriceLbl.text=[prefs stringForKey:@"EURO"];
    poundpriceLbl.text=[prefs stringForKey:@"POUND"];
    tempLbl.text=[prefs stringForKey:@"TEMP"];

}
-(IBAction)newAction{
    NewsViewController *news=[[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
    [self.navigationController pushViewController:news animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [manager stopUpdatingLocation];
    locationManager.delegate = nil;
    locationManager = nil;
    
    CLLocationCoordinate2D currentLocations = newLocation.coordinate;
    MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(currentLocations, 100000, 100000);
    [mapView setRegion:region];
    
    self.annotation = [[MKPointAnnotation alloc] init];
    [self.annotation setCoordinate:currentLocations];
    [self.annotation setTitle:@"Current Location"];
    
    [self.mapView addAnnotation:annotation];
    
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:currentLocations.latitude longitude:currentLocations.longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSString *locality = [placemark name];
            NSLog(@"locality %@",locality);
            if([placemark locality]!=nil)
                addressTXT.text=[NSString stringWithFormat:@"%@,%@,%@",[placemark locality],[placemark name],[placemark country]];
            else
                addressTXT.text=[NSString stringWithFormat:@"%@,%@",[placemark name],[placemark country]];
        }
        [self.mapView removeAnnotation:self.annotation];
        [self.annotation setTitle:addressTXT.text];
        [self.mapView addAnnotation:self.annotation];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([self.annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *reuseId = @"pin";
    MKPinAnnotationView *pav = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (pav == nil)
    {
        pav = [[MKPinAnnotationView alloc] initWithAnnotation:self.annotation reuseIdentifier:reuseId];
        pav.draggable = YES; // Right here baby!
        pav.canShowCallout = YES;
    }
    else
    {
        pav.annotation = self.annotation;
    }
    return pav;
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding) // you can check out some more states by looking at the docs
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        NSLog(@"dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:droppedAt.latitude longitude:droppedAt.longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark * placemark in placemarks) {
                NSString *locality = [placemark name];
                NSLog(@"locality %@",locality);
                if([placemark locality]!=nil)
                    addressTXT.text=[NSString stringWithFormat:@"%@,%@,%@",[placemark locality],[placemark name],[placemark country]];
                else
                    addressTXT.text=[NSString stringWithFormat:@"%@,%@",[placemark name],[placemark country]];
            }
            [self.mapView removeAnnotation:self.annotation];
            [self.annotation setTitle:addressTXT.text];
            [self.mapView addAnnotation:self.annotation];
        }];
    }
}
- (void) handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CLLocationCoordinate2D coordinate = [mapView convertPoint:[gestureRecognizer locationInView:mapView] toCoordinateFromView:mapView];
        [mapView setCenterCoordinate:coordinate animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

-(IBAction)langSettingBtnAction:(id)sender{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    switch ([sender tag]) {
        case 0:
            if([changeLangBtn isSelected]==YES)
            {
                [changeLangBtn setSelected:NO];
                NSString *langStr=[[NSString alloc]init];
                langStr=[prefs stringForKey:@"Languages"];
                if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil || [prefs stringForKey:@"Languages"]==nil){
                    [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerT"]]];
                    [prefs setObject:@"Turkish" forKey:@"Languages"];
                    [prefs synchronize];
                }else{
                    [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerE"]]];
                    [prefs setObject:@"English" forKey:@"Languages"];
                    [prefs synchronize];
                    
                }
                
            }
            else{
                NSString *langStr=[[NSString alloc]init];
                langStr=[prefs stringForKey:@"Languages"];
                if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil || [prefs stringForKey:@"Languages"]==nil){
                    [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerT"]]];
                    [prefs setObject:@"Turkish" forKey:@"Languages"];
                    [prefs synchronize];
                }else{
                    [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerE"]]];
                    [prefs setObject:@"English" forKey:@"Languages"];
                    [prefs synchronize];
                    
                }
                [changeLangBtn setSelected:YES];
                
            }
            break;
    }
}
-(IBAction)aboutusAction{
    AboutUsViewController *aboutus=[[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    [self.navigationController pushViewController:aboutus animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backAction{
    PlusViewController *plus=[[PlusViewController alloc] initWithNibName:@"PlusViewController" bundle:nil];
    [self.navigationController pushViewController:plus animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
