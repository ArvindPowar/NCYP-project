//
//  HomeViewController.m
//  NCYP
//
//  Created by arvind on 4/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "HomeViewController.h"
#import "AraBulViewController.h"
#import "GoViewController.h"
#import "PlusViewController.h"
#import "DiscountViewController.h"
#import "UIColor+Expanded.h"
#import "EmergencyViewController.h"
#import "AboutUsViewController.h"
#import "Reachability.h"
#import <CoreLocation/CoreLocation.h>
#import "NewsViewController.h"
@interface HomeViewController ()<CLLocationManagerDelegate, UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    UIActivityIndicatorView *activityIndicator;
}


@end

@implementation HomeViewController
@synthesize BgImg,goImg1,plusImg2,searchImg3,discountImg4,bannerImg,showBtn,centerImg,verticalImg,firstBtn,sendBtn,thirdBtn,fourBtn,tabmenuView,backBtn,refreshBtn,searchBtn,petrolBtn,changeLangBtn,appDelegate,tempLbl,usdpriceLbl,europriceLbl,poundpriceLbl,bannerAsyncimg,characters,searchString,currentElement,currentElementData,itemStr,itemfound;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    appDelegate.ishome=true;
   
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    activityIndicator.center = CGPointMake(screenRect.size.width / 2.0,screenRect.size.height / 2.0);
    [activityIndicator stopAnimating];

    UIFont *customFontdreg;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        customFontdreg = [UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    }else{
         customFontdreg= [UIFont boldSystemFontOfSize:screenRect.size.width*0.05];
    }

    BgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width, screenRect.size.height)];
    if ([prefs stringForKey:@"BackgroundColor"]!=nil) {
        NSString *backgroundStr=[[NSString alloc]init];
        backgroundStr=[prefs stringForKey:@"BackgroundColor"];
        [BgImg setImage:[UIImage imageNamed:backgroundStr]];
    }else{
        [BgImg setImage:[UIImage imageNamed:@"bg-sample.jpg"]];
    }
    [self.view addSubview:BgImg];

    showBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.82,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    
    
    changeLangBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.90,screenRect.size.height*0.94,screenRect.size.height*0.05,screenRect.size.height*0.045)];

    NSString *themeStr=[[NSString alloc]init];
    themeStr=[prefs stringForKey:@"Theme"];
    if([themeStr isEqualToString:@"Squre Theme"] || [prefs stringForKey:@"Theme"]==nil || [prefs stringForKey:@"Theme"]==nil){

        bannerAsyncimg=[[AsyncImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,screenRect.size.width*0.65,screenRect.size.height*0.15)];
        [bannerAsyncimg.layer setMasksToBounds:YES];
        bannerAsyncimg.clipsToBounds=YES;
        [self.view addSubview:bannerAsyncimg];

        bannerImg=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,screenRect.size.width*0.65,screenRect.size.height*0.15)];
        [self.view addSubview:bannerImg];
        [self.view bringSubviewToFront:bannerImg];

        centerImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.75,screenRect.size.height*0.05,screenRect.size.width*0.20,screenRect.size.height*0.10)];
        [centerImg setImage:[UIImage imageNamed:@"Logo-New.png"]];
        [self.view addSubview:centerImg];

    firstBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.27,screenRect.size.width*0.40,screenRect.size.height*0.22)];
    [firstBtn.titleLabel setFont:customFontdreg];
    firstBtn.layer.cornerRadius = 6.0f;
    [firstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    firstBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [firstBtn setBackgroundImage:[UIImage imageNamed:@"Button-arabul.png"]
                        forState:UIControlStateNormal];
    [firstBtn addTarget:self action:@selector(araBulAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];

    sendBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.27,screenRect.size.width*0.40,screenRect.size.height*0.22)];
    [sendBtn.titleLabel setFont:customFontdreg];
    sendBtn.layer.cornerRadius = 6.0f;
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"Button-git.png"]
                        forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];

    thirdBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.55,screenRect.size.width*0.40,screenRect.size.height*0.22)];
    [thirdBtn.titleLabel setFont:customFontdreg];
    thirdBtn.layer.cornerRadius = 6.0f;
    [thirdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    thirdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [thirdBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]
                        forState:UIControlStateNormal];
    [thirdBtn addTarget:self action:@selector(discountAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdBtn];

    fourBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.55,screenRect.size.width*0.40,screenRect.size.height*0.22)];
    [fourBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:50]];
    fourBtn.layer.cornerRadius = 6.0f;
    [fourBtn setTitle:@"+" forState:UIControlStateNormal];
    [fourBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fourBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [fourBtn setBackgroundImage:[UIImage imageNamed:@"Button-indirim.png"]
                        forState:UIControlStateNormal];
    [fourBtn addTarget:self action:@selector(plusAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fourBtn];


        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *langStr=[[NSString alloc]init];
        langStr=[prefs stringForKey:@"Languages"];
        if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil ){
            
            [firstBtn setTitle:@"SEARCH" forState:UIControlStateNormal];
            [sendBtn setTitle:@"GO" forState:UIControlStateNormal];
            [thirdBtn setTitle:@"DISCOUNTS" forState:UIControlStateNormal];
            [showBtn setTitle:@"EMERGENCY" forState:UIControlStateNormal];

            [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"turkish.png"]
                                     forState:UIControlStateNormal];
            [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"english.png"] forState:UIControlStateSelected];

        }else{
            [firstBtn setTitle:@"ARA BUL" forState:UIControlStateNormal];
            [sendBtn setTitle:@"GiT" forState:UIControlStateNormal];
            [thirdBtn setTitle:@"indirim" forState:UIControlStateNormal];
            [showBtn setTitle:@"ACIL" forState:UIControlStateNormal];
            [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"english.png"]
                                     forState:UIControlStateNormal];
            [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"turkish.png"] forState:UIControlStateSelected];

        }
    }else{
        

        bannerAsyncimg=[[AsyncImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.07,screenRect.size.height*0.05,screenRect.size.width*0.86,screenRect.size.height*0.15)];
        [bannerAsyncimg.layer setMasksToBounds:YES];
        bannerAsyncimg.clipsToBounds=YES;
        [self.view addSubview:bannerAsyncimg];

        bannerImg=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.07,screenRect.size.height*0.05,screenRect.size.width*0.86,screenRect.size.height*0.15)];
        [self.view addSubview:bannerImg];
        [self.view bringSubviewToFront:bannerImg];

        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            goImg1=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.16,screenRect.size.height*0.275,screenRect.size.width*0.40,screenRect.size.height*0.28)];
            [goImg1 setImage:[UIImage imageNamed:@"indirim.png"]];
            [self.view addSubview:goImg1];
            
            plusImg2=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.27,screenRect.size.width*0.40,screenRect.size.height*0.28)];
            [plusImg2 setImage:[UIImage imageNamed:@"more.png"]];
            [self.view addSubview:plusImg2];
            
            
            discountImg4=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.475,screenRect.size.width*0.40,screenRect.size.height*0.28)];
            [discountImg4 setImage:[UIImage imageNamed:@"arabul.png"]];
            [self.view addSubview:discountImg4];
            
            searchImg3=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.165,screenRect.size.height*0.475,screenRect.size.width*0.40,screenRect.size.height*0.28)];
            [searchImg3 setImage:[UIImage imageNamed:@"git.png"]];
            [self.view addSubview:searchImg3];

            firstBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.26,screenRect.size.height*0.35,screenRect.size.width*0.15,screenRect.size.height*0.07)];
            sendBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,screenRect.size.height*0.35,screenRect.size.width*0.15,screenRect.size.height*0.07)];
            thirdBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.26,screenRect.size.height*0.59,screenRect.size.width*0.25,screenRect.size.height*0.07)];
            fourBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.59,screenRect.size.width*0.25,screenRect.size.height*0.07)];
            
            
            
            centerImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.435,screenRect.size.width*0.20,screenRect.size.height*0.15)];
            
            [firstBtn.titleLabel setFont:customFontdreg];
            [sendBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.height*0.09]];
            [thirdBtn.titleLabel setFont:customFontdreg];
            [fourBtn.titleLabel setFont:customFontdreg];

        }else{
        goImg1=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.06,screenRect.size.height*0.29,screenRect.size.width*0.50,screenRect.size.height*0.27)];
        [goImg1 setImage:[UIImage imageNamed:@"indirim.png"]];
        [self.view addSubview:goImg1];

        plusImg2=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.44,screenRect.size.height*0.28,screenRect.size.width*0.50,screenRect.size.height*0.27)];
        [plusImg2 setImage:[UIImage imageNamed:@"more.png"]];
        [self.view addSubview:plusImg2];

        searchImg3=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.085,screenRect.size.height*0.49,screenRect.size.width*0.50,screenRect.size.height*0.27)];
        [searchImg3 setImage:[UIImage imageNamed:@"git.png"]];
        [self.view addSubview:searchImg3];

        discountImg4=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.48,screenRect.size.width*0.50,screenRect.size.height*0.27)];
        [discountImg4 setImage:[UIImage imageNamed:@"arabul.png"]];
        [self.view addSubview:discountImg4];
            
            firstBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.34,screenRect.size.width*0.15,screenRect.size.height*0.07)];
            
            sendBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.63,screenRect.size.height*0.35,screenRect.size.width*0.15,screenRect.size.height*0.07)];
            
            thirdBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.16,screenRect.size.height*0.59,screenRect.size.width*0.23,screenRect.size.height*0.07)];
            
            fourBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.535,screenRect.size.height*0.59,screenRect.size.width*0.30,screenRect.size.height*0.07)];
            [firstBtn.titleLabel setFont:customFontdreg];
            [sendBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:50]];
            [thirdBtn.titleLabel setFont:customFontdreg];
            [fourBtn.titleLabel setFont:customFontdreg];

            
            centerImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.375,screenRect.size.height*0.435,screenRect.size.width*0.25,screenRect.size.height*0.15)];
        }
        firstBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        firstBtn.layer.cornerRadius = 6.0f;
        [firstBtn setTitleColor:[UIColor colorWithHexString:@"23aaca"] forState:UIControlStateNormal];
        [firstBtn setBackgroundColor:[UIColor clearColor]];
        [firstBtn addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:firstBtn];
        
       
      
        sendBtn.layer.cornerRadius = 6.0f;
        [sendBtn setTitle:@"+" forState:UIControlStateNormal];
        [sendBtn setTitleColor:[UIColor colorWithHexString:@"fd3408"] forState:UIControlStateNormal];
        sendBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [sendBtn setBackgroundColor:[UIColor clearColor]];
        [sendBtn addTarget:self action:@selector(plusAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sendBtn];
        
        
              
        thirdBtn.layer.cornerRadius = 6.0f;
        [thirdBtn setTitleColor:[UIColor colorWithHexString:@"7b946a"] forState:UIControlStateNormal];
        thirdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [thirdBtn setBackgroundColor:[UIColor clearColor]];
        [thirdBtn addTarget:self action:@selector(araBulAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:thirdBtn];
        
        
       
               fourBtn.layer.cornerRadius = 6.0f;
        [fourBtn setTitleColor:[UIColor colorWithHexString:@"fea621"] forState:UIControlStateNormal];
        fourBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [fourBtn setBackgroundColor:[UIColor clearColor]];
        [fourBtn addTarget:self action:@selector(discountAction) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:fourBtn];

       
        [centerImg setImage:[UIImage imageNamed:@"ncyp logo.png"]];
        [self.view addSubview:centerImg];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *langStr=[[NSString alloc]init];
        langStr=[prefs stringForKey:@"Languages"];
        if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil || [prefs stringForKey:@"Languages"]==nil){

        [firstBtn setTitle:@"GO" forState:UIControlStateNormal];
        [thirdBtn setTitle:@"SEARCH" forState:UIControlStateNormal];
        [fourBtn setTitle:@"DISCOUNTS" forState:UIControlStateNormal];
        [showBtn setTitle:@"EMERGENCY" forState:UIControlStateNormal];
            
            [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"turkish.png"]
                                     forState:UIControlStateNormal];
            [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"english.png"] forState:UIControlStateSelected];

        }else{

            [firstBtn setTitle:@"GiT" forState:UIControlStateNormal];
            [thirdBtn setTitle:@"ARA BUL" forState:UIControlStateNormal];
            [fourBtn setTitle:@"indirim" forState:UIControlStateNormal];
            [showBtn setTitle:@"ACIL" forState:UIControlStateNormal];

            [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"english.png"]
                                     forState:UIControlStateNormal];
            [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"turkish.png"] forState:UIControlStateSelected];

        }

    }
    
    [bannerImg addTarget:self action:@selector(aboutusAction) forControlEvents:UIControlEventTouchUpInside];
    [bannerImg setBackgroundColor:[UIColor clearColor]];
    
    [bannerAsyncimg setBackgroundColor:[UIColor clearColor]];

    [showBtn.titleLabel setFont:customFontdreg];
    showBtn.layer.cornerRadius = 6.0f;
    [showBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    showBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [showBtn setBackgroundImage:[UIImage imageNamed:@"Acil_btn.png"]
                       forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(EmergencyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];

    tabmenuView = [[UIView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.93,screenRect.size.width,screenRect.size.height*0.07)];
    tabmenuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_banner.png"]];
    [self.view addSubview:tabmenuView];
    
    refreshBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.015,screenRect.size.height*0.94,screenRect.size.height*0.05,screenRect.size.height*0.04)];
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
    
    changeLangBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    changeLangBtn.tag=0;
    [changeLangBtn addTarget:self action:@selector(langSettingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeLangBtn];
    
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
    

    [self getbannerData];
    
    if([prefs stringForKey:@"USD"]==nil || [prefs stringForKey:@"EURO"]==nil || [prefs stringForKey:@"POUND"]==nil  || [prefs stringForKey:@"TEMP"]==nil){
        [appDelegate gettempanddollerrate];

    }else{
        usdpriceLbl.text=[prefs stringForKey:@"USD"];
        europriceLbl.text=[prefs stringForKey:@"EURO"];
        poundpriceLbl.text=[prefs stringForKey:@"POUND"];
        tempLbl.text=[prefs stringForKey:@"TEMP"];
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
   appDelegate.ishomenewBtnclick=true;
    [self.navigationController pushViewController:news animated:YES];
}


-(IBAction)aboutusAction{
    
    AboutUsViewController *aboutus=[[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    appDelegate.ishomeaboutbtnclick=true;
    [self.navigationController pushViewController:aboutus animated:YES];

}
-(IBAction)EmergencyAction{
    EmergencyViewController *emergency=[[EmergencyViewController alloc] initWithNibName:@"EmergencyViewController" bundle:nil];
    [self.navigationController pushViewController:emergency animated:YES];

}
-(IBAction)langSettingBtnAction:(id)sender{
    switch ([sender tag]) {
        case 0:
            if([changeLangBtn isSelected]==YES)
            {
                [changeLangBtn setSelected:NO];
                appDelegate.isenglishselected=true;
                
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

                NSString *themeStr=[[NSString alloc]init];
                themeStr=[prefs stringForKey:@"Theme"];
                if([themeStr isEqualToString:@"Squre Theme"] || [prefs stringForKey:@"Theme"]==nil || [prefs stringForKey:@"Theme"]==nil){
                    NSString *langStr=[[NSString alloc]init];
                    langStr=[prefs stringForKey:@"Languages"];
                    if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil ){
                        [firstBtn setTitle:@"ARA BUL" forState:UIControlStateNormal];
                        [sendBtn setTitle:@"GiT" forState:UIControlStateNormal];
                        [thirdBtn setTitle:@"indirim" forState:UIControlStateNormal];
                        [showBtn setTitle:@"ACIL" forState:UIControlStateNormal];
                        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerT"]]];

                        [prefs setObject:@"Turkish" forKey:@"Languages"];
                        [prefs synchronize];

                    }else{
                        [firstBtn setTitle:@"SEARCH" forState:UIControlStateNormal];
                        [sendBtn setTitle:@"GO" forState:UIControlStateNormal];
                        [thirdBtn setTitle:@"DISCOUNTS" forState:UIControlStateNormal];
                        [showBtn setTitle:@"EMERGENCY" forState:UIControlStateNormal];

                        [prefs setObject:@"English" forKey:@"Languages"];
                        [prefs synchronize];
                        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerE"]]];

                    }
                }else{
                    NSString *langStr=[[NSString alloc]init];
                    langStr=[prefs stringForKey:@"Languages"];
                    if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil || [prefs stringForKey:@"Languages"]==nil){
                        [firstBtn setTitle:@"GiT" forState:UIControlStateNormal];
                        [thirdBtn setTitle:@"ARA BUL" forState:UIControlStateNormal];
                        [fourBtn setTitle:@"indirim" forState:UIControlStateNormal];
                        [showBtn setTitle:@"ACIL" forState:UIControlStateNormal];
                        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerT"]]];

                        [prefs setObject:@"Turkish" forKey:@"Languages"];
                        [prefs synchronize];

                    }else{
                        [firstBtn setTitle:@"GO" forState:UIControlStateNormal];
                        [thirdBtn setTitle:@"SEARCH" forState:UIControlStateNormal];
                        [fourBtn setTitle:@"DISCOUNTS" forState:UIControlStateNormal];
                        [showBtn setTitle:@"EMERGENCY" forState:UIControlStateNormal];
                        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerE"]]];

                        [prefs setObject:@"English" forKey:@"Languages"];
                        [prefs synchronize];

                    }
                }

            }
            else{
                [changeLangBtn setSelected:YES];
                appDelegate.isenglishselected=false;
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

                NSString *themeStr=[[NSString alloc]init];
                themeStr=[prefs stringForKey:@"Theme"];
                if([themeStr isEqualToString:@"Squre Theme"] || [prefs stringForKey:@"Theme"]==nil || [prefs stringForKey:@"Theme"]==nil){

                    NSString *langStr=[[NSString alloc]init];
                    langStr=[prefs stringForKey:@"Languages"];
                    if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil ){
                        [firstBtn setTitle:@"ARA BUL" forState:UIControlStateNormal];
                        [sendBtn setTitle:@"GiT" forState:UIControlStateNormal];
                        [thirdBtn setTitle:@"indirim" forState:UIControlStateNormal];
                        [showBtn setTitle:@"ACIL" forState:UIControlStateNormal];
                        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerT"]]];

                        [prefs setObject:@"Turkish" forKey:@"Languages"];
                        [prefs synchronize];

                    }else{
                        [firstBtn setTitle:@"SEARCH" forState:UIControlStateNormal];
                        [sendBtn setTitle:@"GO" forState:UIControlStateNormal];
                        [thirdBtn setTitle:@"DISCOUNTS" forState:UIControlStateNormal];
                        [showBtn setTitle:@"EMERGENCY" forState:UIControlStateNormal];

                        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerE"]]];

                        [prefs setObject:@"English" forKey:@"Languages"];
                        [prefs synchronize];

                    }
                }else{
                    NSString *langStr=[[NSString alloc]init];
                    langStr=[prefs stringForKey:@"Languages"];
                    if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil || [prefs stringForKey:@"Languages"]==nil){
                        
                        [firstBtn setTitle:@"GiT" forState:UIControlStateNormal];
                        [thirdBtn setTitle:@"ARA BUL" forState:UIControlStateNormal];
                        [fourBtn setTitle:@"indirim" forState:UIControlStateNormal];
                        [showBtn setTitle:@"ACIL" forState:UIControlStateNormal];
                        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerT"]]];

                        
                        [prefs setObject:@"Turkish" forKey:@"Languages"];
                        [prefs synchronize];

                    }else{
                        [firstBtn setTitle:@"GO" forState:UIControlStateNormal];
                        [thirdBtn setTitle:@"SEARCH" forState:UIControlStateNormal];
                        [fourBtn setTitle:@"DISCOUNTS" forState:UIControlStateNormal];
                        [showBtn setTitle:@"EMERGENCY" forState:UIControlStateNormal];
                        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerE"]]];

                        [prefs setObject:@"English" forKey:@"Languages"];
                        [prefs synchronize];

                    }
                }

            }
            break;
    }
}
- (void) threadStartAnimating:(id)data {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    activityIndicator.center = CGPointMake(screenRect.size.width / 2.0, screenRect.size.height / 2.0);
    [activityIndicator startAnimating];
}

-(void)getbannerData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"NCYP" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerts show];
        
    }else{
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        
        NSURL *url;
        NSMutableString *httpBodyString;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@""]];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://mobiwebsoft.com/ncyp/getBanner.php"];
        
        url=[[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            // your data or an error will be ready here
            if (error)
            {
                [activityIndicator stopAnimating];
                NSLog(@"Failed to submit request");
            }
            else
            {
                [activityIndicator stopAnimating];
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                
                NSError *error;
                if ([content isEqualToString:@"no"]) {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"  " message:@"no data available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    
                }else{
                    
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:&error];
                    NSDictionary *activityArray=[[userDict objectForKey:@"bannerdetail"] objectForKey:@"banner"];
                    
                    
                    NSString *bannerid = [[NSString alloc]init];
                    NSString *bannerEnglish = [[NSString alloc]init];
                    NSString *bannertrkish = [[NSString alloc]init];
                    NSString *langStr=[[NSString alloc]init];
                    
                    if ([activityArray objectForKey:@"bannerid"] != [NSNull null])
                        
                        langStr=[prefs stringForKey:@"Languages"];
                    bannerid=[activityArray objectForKey:@"bannerid"];
                    NSString* str=[activityArray objectForKey:@"bannerE"];
                    NSString* strss=[activityArray objectForKey:@"bannerT"];
                    NSString* strss1 =[str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                    NSString* strss2 =[strss stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

                    bannerEnglish = [strss1 stringByReplacingOccurrencesOfString:@"\/" withString:@"/"];
                    bannertrkish = [strss2 stringByReplacingOccurrencesOfString:@"\/" withString:@"/"];

                    if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil){
                        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:bannerEnglish]];
                    }else{
                        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:bannertrkish]];
                    }

                    
                    [prefs setObject:bannerid forKey:@"bannerid"];
                    [prefs setObject:bannerEnglish forKey:@"bannerE"];
                    [prefs setObject:bannertrkish forKey:@"bannerT"];
                    [prefs synchronize];
                    
                }
                [activityIndicator stopAnimating];
            }
        }];
    }
    
}

-(IBAction)araBulAction{
    AraBulViewController *araBul=[[AraBulViewController alloc] initWithNibName:@"AraBulViewController" bundle:nil];
    [self.navigationController pushViewController:araBul animated:YES];
    
}
-(IBAction)goAction{
    GoViewController *goview=[[GoViewController alloc] initWithNibName:@"GoViewController" bundle:nil];
    [self.navigationController pushViewController:goview animated:YES];
    
}
-(IBAction)plusAction{
    PlusViewController *plusview=[[PlusViewController alloc] initWithNibName:@"PlusViewController" bundle:nil];
    [self.navigationController pushViewController:plusview animated:YES];
    
}
-(IBAction)discountAction{
    DiscountViewController *discount=[[DiscountViewController alloc] initWithNibName:@"DiscountViewController" bundle:nil];
    [self.navigationController pushViewController:discount animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
