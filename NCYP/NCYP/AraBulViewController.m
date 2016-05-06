//
//  AraBulViewController.m
//  NCYP
//
//  Created by arvind on 4/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "AraBulViewController.h"
#import "HealthMedicalViewController.h"
#import "HomeViewController.h"
#import "categoryVO.h"
#import "Reachability.h"
#import "AsyncImageView/AsyncImageView.h"
#import "AboutUsViewController.h"
#import "PlaceVo.h"
#import "PlaceDetalisViewController.h"
#import "NewsViewController.h"
@interface AraBulViewController ()

@end

@implementation AraBulViewController
@synthesize tableview,CategoryListArray,placeListArray,BgImg,appDelegate,backBtn,tabmenuView,refreshBtn,searchBtn,petrolBtn,changeLangBtn,bannerImgBtn,tempLbl,usdpriceLbl,europriceLbl,poundpriceLbl,activityIndicator,bannerAsyncimg,backidStr;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];
    appDelegate.ishome=false;

    activityIndicator.center = CGPointMake(screenRect.size.width / 2.0,screenRect.size.height / 2.0);
    [activityIndicator stopAnimating];

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


    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.20,screenRect.size.width,screenRect.size.height*0.72)];
    tableview.dataSource = self;
    tableview.delegate = self;
    [tableview setBackgroundColor:[UIColor clearColor]];
    self.tableview.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    self.tableview.allowsMultipleSelectionDuringEditing = YES;
    
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
    
    [self getcategoryData];
}
-(IBAction)aboutusAction{
    AboutUsViewController *aboutus=[[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    [self.navigationController pushViewController:aboutus animated:YES];
    
}
-(IBAction)newAction{
    NewsViewController *news=[[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
    [self.navigationController pushViewController:news animated:YES];
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
    [tableview reloadData];
}
-(IBAction)refreshAction{
    [appDelegate gettempanddollerrate];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    usdpriceLbl.text=[prefs stringForKey:@"USD"];
    europriceLbl.text=[prefs stringForKey:@"EURO"];
    poundpriceLbl.text=[prefs stringForKey:@"POUND"];
    tempLbl.text=[prefs stringForKey:@"TEMP"];

}

-(IBAction)backAction{
    if (appDelegate.backcategoryid==nil) {
    HomeViewController *home=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:home animated:YES];
    }else{
        appDelegate.backcategoryid=appDelegate.backidStr;
        [self getcategoryData];
    }
}
- (void) threadStartAnimating:(id)data {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    activityIndicator.center = CGPointMake(screenRect.size.width / 2.0, screenRect.size.height / 2.0);
    [activityIndicator startAnimating];
}

-(void)getcategoryData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"NCYP" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerts show];
        
    }else{
        CategoryListArray=[[NSMutableArray alloc]init];
        placeListArray=[[NSMutableArray alloc]init];

        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        
        NSURL *url;
        NSMutableString *httpBodyString;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        if (appDelegate.backcategoryid==nil) {
            appDelegate.backcategoryid=[[NSString alloc]init];
            appDelegate.backcategoryid=@"0";
        }
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"parentcategoryid=%@",appDelegate.backcategoryid]];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://mobiwebsoft.com/ncyp/getCategoriesList.php?"];
        
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
                appDelegate.backcategoryid=nil;

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
                    NSDictionary *activityArray=[userDict objectForKey:@"categorydetail"];
                    NSString *backcategoryid = [activityArray objectForKey:@"backcategoryid"];
                    if (backcategoryid!=nil) {
                    appDelegate.backcategoryid=[[NSString alloc]init];
                        appDelegate.backidStr=[[NSString alloc]init];
                        appDelegate.backidStr=[activityArray objectForKey:@"backcategoryid"];
                    appDelegate.backcategoryid=[activityArray objectForKey:@"backcategoryid"];
                    }else{
                        appDelegate.backcategoryid=nil;
                    }
                        NSArray *userArray = [activityArray objectForKey:@"category"];
                        for (int count=0; count<[userArray count]; count++) {
                            
                                NSDictionary *activityData=[userArray objectAtIndex:count];
                                categoryVO *Cvo=[[categoryVO alloc] init];
                                Cvo.categoryid=[[NSString alloc] init];
                                Cvo.parentcategoryid=[[NSString alloc] init];
                                Cvo.categorynameE=[[NSString alloc] init];
                                Cvo.categorynameT=[[NSString alloc] init];
                                Cvo.categoryinfoE=[[NSString alloc] init];
                                Cvo.categoryinfoT=[[NSString alloc] init];
                                Cvo.categoryicon=[[NSString alloc] init];
                                
                                if ([activityData objectForKey:@"categoryid"] != [NSNull null]){
                                Cvo.categoryid=[activityData objectForKey:@"categoryid"];
                                Cvo.parentcategoryid=[activityData objectForKey:@"parentcategoryid"];
                                Cvo.categorynameE=[activityData objectForKey:@"categorynameE"];
                               Cvo.categorynameT=[activityData objectForKey:@"categorynameT"];
                                Cvo.categoryinfoE=[activityData objectForKey:@"categoryinfoE"];
                                Cvo.categoryinfoT=[activityData objectForKey:@"categoryinfoT"];
                                NSString* strss2=[activityData objectForKey:@"categoryicon"];
                                NSString* strss4=[strss2 stringByReplacingOccurrencesOfString:@"\/" withString:@"/"];
                                    Cvo.categoryicon =[strss4 stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

                                [CategoryListArray addObject:Cvo];
                                    }
                        }
                    NSDictionary *activityArrays=[activityArray objectForKey:@"placesdetail"];
                    if ([activityArrays count]>0) {
                    NSArray *userplaceArray = [activityArrays objectForKey:@"places"];
                    for (int count=0; count<[userplaceArray count]; count++) {
                        NSDictionary *activityData=[userplaceArray objectAtIndex:count];
                        PlaceVo *pvo=[[PlaceVo alloc] init];
                        pvo.placeid=[[NSString alloc] init];
                        pvo.categoryid=[[NSString alloc] init];
                        pvo.cityid=[[NSString alloc] init];
                        pvo.placenameE=[[NSString alloc] init];
                        pvo.placenameT=[[NSString alloc] init];
                        pvo.placeicon=[[NSString alloc] init];
                        pvo.lattitude=[[NSString alloc] init];
                        pvo.longitude=[[NSString alloc] init];
                        pvo.placebanner=[[NSString alloc] init];
                        pvo.phoneno=[[NSString alloc] init];
                        pvo.email=[[NSString alloc] init];
                        pvo.placeinfoE=[[NSString alloc] init];
                        pvo.placeinfoT=[[NSString alloc] init];
                        if ([activityData objectForKey:@"placeid"] != [NSNull null]){
                            pvo.placeid=[activityData objectForKey:@"placeid"];
                            pvo.categoryid=[activityData objectForKey:@"categoryid"];
                            pvo.cityid=[activityData objectForKey:@"cityid"];
                            pvo.placenameE=[activityData objectForKey:@"placenameE"];
                            pvo.placenameT=[activityData objectForKey:@"placenameT"];
                            NSString* strss=[activityData objectForKey:@"placeicon"];
                            NSString* strss4=[strss stringByReplacingOccurrencesOfString:@"\/" withString:@"/"];
                            pvo.placeicon =[strss4 stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                            pvo.lattitude=[activityData objectForKey:@"lattitude"];
                            pvo.longitude=[activityData objectForKey:@"longitude"];
                            NSString* strss2=[activityData objectForKey:@"placebanner"];
                            NSString* strss3=[strss2 stringByReplacingOccurrencesOfString:@"\/" withString:@"/"];
                            pvo.placebanner =[strss3 stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                            pvo.phoneno=[activityData objectForKey:@"phoneno"];
                            pvo.email=[activityData objectForKey:@"email"];
                            pvo.placeinfoE=[activityData objectForKey:@"placeinfoE"];
                            pvo.placeinfoT=[activityData objectForKey:@"placeinfoT"];
                            
                            
                            [placeListArray addObject:pvo];
                            }
                        }
                    }
                    }
                    [activityIndicator stopAnimating];
                    [tableview reloadData];
            }
        }];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [CategoryListArray count]+[placeListArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thin-arrow-right-only-wh.png"]];
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIFont *customFontdreg = [UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
    UIFont *customFontsub = [UIFont boldSystemFontOfSize:screenRect.size.width*0.025];

    
    UILabel *testNameLbl=[[UILabel alloc]init ];
    testNameLbl.layer.frame=CGRectMake(screenRect.size.width*0.22,10,screenRect.size.width*0.60,screenRect.size.height*0.05);
   
    [testNameLbl setFont:customFontdreg];
    [testNameLbl setBackgroundColor:[UIColor clearColor]];
    testNameLbl.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:testNameLbl];
        
        UILabel *subNameLbl=[[UILabel alloc]init ];
        subNameLbl.layer.frame=CGRectMake(screenRect.size.width*0.22,screenRect.size.height*0.05,screenRect.size.width*0.60,screenRect.size.height*0.04);
        [subNameLbl setFont:customFontsub];
        [subNameLbl setBackgroundColor:[UIColor clearColor]];
        subNameLbl.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:subNameLbl];
    
    
    AsyncImageView * categoryicon;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        categoryicon=[[AsyncImageView alloc]initWithFrame:CGRectMake(15,15,screenRect.size.width*0.10,screenRect.size.height*0.07)];
    }else{
        categoryicon=[[AsyncImageView alloc]initWithFrame:CGRectMake(15,15,screenRect.size.width*0.11,screenRect.size.height*0.07)];
    }
    [categoryicon setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:categoryicon];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *langStr=[[NSString alloc]init];
    langStr=[prefs stringForKey:@"Languages"];

    int categoryArycount=[CategoryListArray count];
    if (indexPath.row+1<=[CategoryListArray count]) {
        categoryVO *cavO=[CategoryListArray objectAtIndex:indexPath.row];
        if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil || [prefs stringForKey:@"Languages"]==nil){
            testNameLbl.text=cavO.categorynameE;
            subNameLbl.text=cavO.categoryinfoE;
        }else{
            testNameLbl.text=cavO.categorynameT;
            subNameLbl.text=cavO.categoryinfoT;
        }
        [categoryicon loadImageFromURL:[NSURL URLWithString:cavO.categoryicon]];
        appDelegate.parentcategoryidStr=[[NSString alloc]init];
        appDelegate.parentcategoryidStr=cavO.parentcategoryid;

    }else{
        PlaceVo *plcvO=[placeListArray objectAtIndex:indexPath.row-categoryArycount];
        if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil || [prefs stringForKey:@"Languages"]==nil){
            testNameLbl.text=plcvO.placenameE;
            subNameLbl.text=plcvO.placeinfoE;
        }else{
            testNameLbl.text=plcvO.placenameT;
            subNameLbl.text=plcvO.placeinfoT;
        }
        [categoryicon loadImageFromURL:[NSURL URLWithString:plcvO.placeicon]];

    }

    if ([prefs stringForKey:@"BackgroundColor"]!=nil) {
        NSString *backgroundStr=[[NSString alloc]init];
        backgroundStr=[prefs stringForKey:@"BackgroundColor"];
        if ([backgroundStr isEqualToString:@"bg_tile_2.png"] || [backgroundStr isEqualToString:@"bg_tile_3.PNG"] ||[backgroundStr isEqualToString:@"bg_tile_5.png"]) {
            testNameLbl.textColor=[UIColor blackColor];
            subNameLbl.textColor=[UIColor blackColor];
        }else{
            testNameLbl.textColor=[UIColor whiteColor];
            subNameLbl.textColor=[UIColor whiteColor];
        }
    }else{
        testNameLbl.textColor=[UIColor whiteColor];
        subNameLbl.textColor=[UIColor whiteColor];
    }


    
              UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor clearColor];
    [cell setSelectedBackgroundView:bgColorView];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int categoryArycount=[CategoryListArray count];
    if (indexPath.row+1<=[CategoryListArray count]) {
        categoryVO *cavO=[CategoryListArray objectAtIndex:indexPath.row];
        appDelegate.backcategoryid=[[NSString alloc]init];
        appDelegate.backcategoryid=cavO.categoryid;

        [self getcategoryData];
    }else{
        PlaceVo *plcvO=[placeListArray objectAtIndex:indexPath.row-categoryArycount];
        PlaceDetalisViewController *place=[[PlaceDetalisViewController alloc] initWithNibName:@"PlaceDetalisViewController" bundle:nil];
        place.placeVO=[[PlaceVo alloc]init];
        place.placeVO=plcvO;
        appDelegate.cityId=[[NSString alloc]init];
        appDelegate.cityId=@"searchplace";
        [self.navigationController pushViewController:place animated:YES];

    }
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
