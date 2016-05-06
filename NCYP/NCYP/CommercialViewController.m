//
//  CommercialViewController.m
//  NCYP
//
//  Created by arvind on 5/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "CommercialViewController.h"
#import "PlusViewController.h"
#import "Reachability.h"
#import "CommercialVO.h"
#import "AsyncImageView.h"
#import "AboutUsViewController.h"
#import "DisplayURLViewController.h"
#import "NewsViewController.h"

@interface CommercialViewController ()

@end

@implementation CommercialViewController

@synthesize tableview,filedListArray,BgImg,appDelegate,backBtn,tabmenuView,refreshBtn,searchBtn,petrolBtn,changeLangBtn,bannerImg,tempLbl,usdpriceLbl,europriceLbl,poundpriceLbl,imageArray,activityIndicator,bannerAsyncimg,bannerImgBtn,alert,urlStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];
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
    
    [self getCommercialData];
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
    PlusViewController *plus=[[PlusViewController alloc] initWithNibName:@"PlusViewController" bundle:nil];
    [self.navigationController pushViewController:plus animated:YES];
    
}
- (void) threadStartAnimating:(id)data {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    activityIndicator.center = CGPointMake(screenRect.size.width / 2.0, screenRect.size.height / 2.0);
    [activityIndicator startAnimating];
}

-(void)getCommercialData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"NCYP" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerts show];
        
    }else{
        filedListArray=[[NSMutableArray alloc]init];
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        
        NSURL *url;
        NSMutableString *httpBodyString;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"type=commercial"]];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://mobiwebsoft.com/ncyp/getMoreDetails.php?"];
        
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
                    if (userDict!=nil) {
                        
                        
                        NSDictionary *activityArray=[[userDict objectForKey:@"moredetail"] objectForKey:@"commercialdetail"];
                            NSArray *userArray = [activityArray objectForKey:@"commercial"];
                            for (int count=0; count<[userArray count]; count++) {
                                
                                NSDictionary *activityData=[userArray objectAtIndex:count];
                                CommercialVO *Comvo=[[CommercialVO alloc] init];
                                Comvo.commercialid=[[NSString alloc] init];
                                Comvo.commercialurl=[[NSString alloc] init];
                                Comvo.commercialinfoE=[[NSString alloc] init];
                                Comvo.coomercialinfoT=[[NSString alloc] init];
                                Comvo.commercialimage=[[NSString alloc] init];
                                Comvo.over18=[[NSString alloc] init];

                                if ([activityData objectForKey:@"commercialid"] != [NSNull null]){
                                    Comvo.commercialid=[activityData objectForKey:@"commercialid"];
                                    Comvo.commercialurl=[activityData objectForKey:@"commercialurl"];
                                    Comvo.commercialinfoE=[activityData objectForKey:@"commercialinfoE"];
                                    Comvo.coomercialinfoT =[activityData objectForKey:@"coomercialinfoT"];
                                    NSString* strss2=[activityData objectForKey:@"commercialimage"];
                                    NSString* strss4=[strss2 stringByReplacingOccurrencesOfString:@"\/" withString:@"/"];
                                    Comvo.commercialimage =[strss4 stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                                    Comvo.over18 =[activityData objectForKey:@"over18"];

                                    [filedListArray addObject:Comvo];
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
    return [filedListArray count];
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
    CommercialVO *comVO=[filedListArray objectAtIndex:indexPath.row];

    AsyncImageView * categoryicon;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        categoryicon=[[AsyncImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,2,screenRect.size.width*0.80,screenRect.size.height*0.10)];
    }else{
        categoryicon=[[AsyncImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,2,screenRect.size.width*0.80,screenRect.size.height*0.10)];
    }
    [categoryicon setBackgroundColor:[UIColor clearColor]];
    [categoryicon loadImageFromURL:[NSURL URLWithString:comVO.commercialimage]];
    [cell.contentView addSubview:categoryicon];

    
    
    UIFont *customFontdreg = [UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
    UIFont *customFontsub = [UIFont boldSystemFontOfSize:screenRect.size.width*0.025];
    
    UILabel *testNameLbl=[[UILabel alloc]init ];
    testNameLbl.layer.frame=CGRectMake(screenRect.size.width*0.22,screenRect.size.height*0.105,screenRect.size.width*0.60,screenRect.size.height*0.05);
    [testNameLbl setFont:customFontdreg];
    [testNameLbl setBackgroundColor:[UIColor clearColor]];
    testNameLbl.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:testNameLbl];
    
    UILabel *subNameLbl=[[UILabel alloc]init ];
    subNameLbl.layer.frame=CGRectMake(screenRect.size.width*0.22,screenRect.size.height*0.16,screenRect.size.width*0.60,screenRect.size.height*0.04);
    [subNameLbl setFont:customFontsub];
    [subNameLbl setBackgroundColor:[UIColor clearColor]];
    subNameLbl.textAlignment=NSTextAlignmentLeft;
   // [cell.contentView addSubview:subNameLbl];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
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
    
    NSString *langStr=[[NSString alloc]init];
    langStr=[prefs stringForKey:@"Languages"];
    if([langStr isEqualToString:@"English"] || [prefs stringForKey:@"Languages"]==nil || [prefs stringForKey:@"Languages"]==nil){
        testNameLbl.text=comVO.commercialinfoE;
        subNameLbl.text=comVO.commercialinfoE;
        
    }else{
        testNameLbl.text=comVO.coomercialinfoT;
        subNameLbl.text=comVO.coomercialinfoT;
        
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor clearColor];
    [cell setSelectedBackgroundView:bgColorView];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    return screenRect.size.height*0.20;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommercialVO *comVO=[filedListArray objectAtIndex:indexPath.row];
    if ([comVO.over18 isEqualToString:@"yes"]) {
        alert = [[UIAlertView alloc]initWithTitle:@"NCYP" message:@"Please confirm your age above 18?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        
        [alert show];
        urlStr=[[NSString alloc]init];
        urlStr=comVO.commercialurl;
    }else{
        DisplayURLViewController *display=[[DisplayURLViewController alloc] initWithNibName:@"DisplayURLViewController" bundle:nil];
        display.nsurl=[[NSString alloc]init];
        display.nsurl=comVO.commercialurl;
        [self.navigationController pushViewController:display animated:YES];

    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes"]){
        DisplayURLViewController *display=[[DisplayURLViewController alloc] initWithNibName:@"DisplayURLViewController" bundle:nil];
        display.nsurl=[[NSString alloc]init];
        display.nsurl=urlStr;
        [self.navigationController pushViewController:display animated:YES];

    }
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
