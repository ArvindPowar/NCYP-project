//
//  ChooseBackgroundViewController.m
//  NCYP
//
//  Created by arvind on 4/26/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "ChooseBackgroundViewController.h"
#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "NewsViewController.h"

@interface ChooseBackgroundViewController ()

@end

@implementation ChooseBackgroundViewController
@synthesize BgImg,appDelegate,backBtn,tabmenuView,refreshBtn,searchBtn,petrolBtn,changeLangBtn,bannerImg,tempLbl,usdpriceLbl,europriceLbl,poundpriceLbl,btnImag1,btnImag7,btnImag2,btnImag3,btnImag4,btnImag5,btnImag6,btnImag8,btnImag9,bannerAsyncimg,bannerImgBtn;
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
    }    [self.view addSubview:BgImg];
    
    
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

    backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,40,screenRect.size.width*0.10,screenRect.size.height*0.08)];
    [backBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    backBtn.layer.cornerRadius = 6.0f;
    //[backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"undo_icon.png"]forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    btnImag1=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.20,screenRect.size.width*0.30,screenRect.size.height*0.24)];
    [btnImag1 setBackgroundImage:[UIImage imageNamed:@"bg_tile_1.png"]forState:UIControlStateNormal];
    [btnImag1 addTarget:self action:@selector(chooseBackgroundAction:) forControlEvents:UIControlEventTouchUpInside];
    btnImag1.tag=1;
    [self.view addSubview:btnImag1];

    btnImag2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.34,screenRect.size.height*0.20,screenRect.size.width*0.30,screenRect.size.height*0.24)];
    [btnImag2 setBackgroundImage:[UIImage imageNamed:@"bg_tile_2.png"]forState:UIControlStateNormal];
    [btnImag2 addTarget:self action:@selector(chooseBackgroundAction:) forControlEvents:UIControlEventTouchUpInside];
    btnImag2.tag=2;
    [self.view addSubview:btnImag2];
    
    btnImag3=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.66,screenRect.size.height*0.20,screenRect.size.width*0.30,screenRect.size.height*0.24)];
    [btnImag3 setBackgroundImage:[UIImage imageNamed:@"bg_tile_3.PNG"]forState:UIControlStateNormal];
    [btnImag3 addTarget:self action:@selector(chooseBackgroundAction:) forControlEvents:UIControlEventTouchUpInside];
    btnImag3.tag=3;
    [self.view addSubview:btnImag3];

    btnImag4=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.46,screenRect.size.width*0.30,screenRect.size.height*0.24)];
    [btnImag4 setBackgroundImage:[UIImage imageNamed:@"bg_tile_4.PNG"]forState:UIControlStateNormal];
    [btnImag4 addTarget:self action:@selector(chooseBackgroundAction:) forControlEvents:UIControlEventTouchUpInside];
    btnImag4.tag=4;
    [self.view addSubview:btnImag4];
    
    btnImag5=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.34,screenRect.size.height*0.46,screenRect.size.width*0.300,screenRect.size.height*0.24)];
    [btnImag5 setBackgroundImage:[UIImage imageNamed:@"bg_tile_5.png"]forState:UIControlStateNormal];
    [btnImag5 addTarget:self action:@selector(chooseBackgroundAction:) forControlEvents:UIControlEventTouchUpInside];
    btnImag5.tag=5;
    [self.view addSubview:btnImag5];

    btnImag6=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.66,screenRect.size.height*0.46,screenRect.size.width*0.30,screenRect.size.height*0.24)];
    [btnImag6 setBackgroundImage:[UIImage imageNamed:@"bg_tile_6.PNG"]forState:UIControlStateNormal];
    [btnImag6 addTarget:self action:@selector(chooseBackgroundAction:) forControlEvents:UIControlEventTouchUpInside];
    btnImag6.tag=6;
    [self.view addSubview:btnImag6];

    btnImag7=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.72,screenRect.size.width*0.30,screenRect.size.height*0.24)];
    [btnImag7 setBackgroundImage:[UIImage imageNamed:@"bg_tile_7.PNG"]forState:UIControlStateNormal];
    [btnImag7 addTarget:self action:@selector(chooseBackgroundAction:) forControlEvents:UIControlEventTouchUpInside];
    btnImag7.tag=7;
    [self.view addSubview:btnImag7];

    btnImag8=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.34,screenRect.size.height*0.72,screenRect.size.width*0.30,screenRect.size.height*0.24)];
    [btnImag8 setBackgroundImage:[UIImage imageNamed:@"bg_tile_8.png"]forState:UIControlStateNormal];
    [btnImag8 addTarget:self action:@selector(chooseBackgroundAction:) forControlEvents:UIControlEventTouchUpInside];
    btnImag8.tag=8;
    [self.view addSubview:btnImag8];

    btnImag9=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.66,screenRect.size.height*0.72,screenRect.size.width*0.30,screenRect.size.height*0.24)];
    [btnImag9 setBackgroundImage:[UIImage imageNamed:@"bg_tile_9.png"]forState:UIControlStateNormal];
    [btnImag9 addTarget:self action:@selector(chooseBackgroundAction:) forControlEvents:UIControlEventTouchUpInside];
    btnImag9.tag=9;
    [self.view addSubview:btnImag9];


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
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"english.png"]
                                 forState:UIControlStateNormal];
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"turkish.png"] forState:UIControlStateSelected];
        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerE"]]];
    }else{
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"turkish.png"]
                                 forState:UIControlStateNormal];
        [changeLangBtn setBackgroundImage:[UIImage imageNamed:@"english.png"] forState:UIControlStateSelected];
        [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:[prefs stringForKey:@"bannerT"]]];    }
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

-(IBAction)chooseBackgroundAction:(UIButton *)Btn{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (Btn.tag==1) {
        [prefs setObject:@"bg_tile_1.png" forKey:@"BackgroundColor"];
    }
    if (Btn.tag==2) {
        [prefs setObject:@"bg_tile_2.png" forKey:@"BackgroundColor"];
    }
    if (Btn.tag==3) {
        [prefs setObject:@"bg_tile_3.PNG" forKey:@"BackgroundColor"];
    }
    if (Btn.tag==4) {
        [prefs setObject:@"bg_tile_4.PNG" forKey:@"BackgroundColor"];
    }
    if (Btn.tag==5) {
        [prefs setObject:@"bg_tile_5.png" forKey:@"BackgroundColor"];
    }
    if (Btn.tag==6) {
        [prefs setObject:@"bg_tile_6.PNG" forKey:@"BackgroundColor"];
    }
    if (Btn.tag==7) {
        [prefs setObject:@"bg_tile_7.PNG" forKey:@"BackgroundColor"];
    }
    if (Btn.tag==8) {
        [prefs setObject:@"bg_tile_8.png" forKey:@"BackgroundColor"];
    }
    if (Btn.tag==9) {
        [prefs setObject:@"bg_tile_9.png" forKey:@"BackgroundColor"];
    }

    [prefs synchronize];
    NSLog(@"Button tag %ld",(long)Btn.tag);
    if ([prefs stringForKey:@"BackgroundColor"]!=nil) {
        NSString *backgroundStr=[[NSString alloc]init];
        backgroundStr=[prefs stringForKey:@"BackgroundColor"];
        [BgImg setImage:[UIImage imageNamed:backgroundStr]];
    }else{
        [BgImg setImage:[UIImage imageNamed:@"bg-sample.jpg"]];
    }    

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

-(IBAction)aboutusAction{
    AboutUsViewController *aboutus=[[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    [self.navigationController pushViewController:aboutus animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backAction{
    SettingViewController *setting=[[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];
    
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
