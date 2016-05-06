//
//  DailyHoroscopeViewController.m
//  NCYP
//
//  Created by arvind on 5/6/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "DailyHoroscopeViewController.h"
#import "AboutUsViewController.h"
#import "PlusViewController.h"
#import "ItemVO.h"
#import "NewsViewController.h"

@interface DailyHoroscopeViewController ()

@end

@implementation DailyHoroscopeViewController

@synthesize tableview,horoscopeArraylist,BgImg,appDelegate,backBtn,tabmenuView,refreshBtn,searchBtn,petrolBtn,changeLangBtn,bannerImgBtn,tempLbl,usdpriceLbl,europriceLbl,poundpriceLbl,activityIndicator,bannerAsyncimg,backidStr,characters,searchString,currentElement,itemStr,itemfound,currentElementData,itemVO;
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
    
    horoscopeArraylist=[[NSMutableArray alloc]init];
    [self getdailyhoroscope];
}
-(void)getdailyhoroscope{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSData *mydata = [[NSData alloc] init];
    NSString *urlString;
        urlString = [[NSString alloc]initWithFormat:@"http://www.astrology.com/us/offsite/rss/daily-extended.aspx"];
    //mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    NSURL *url      = [NSURL URLWithString:urlString];
    NSError *error;
    
    NSString * dataString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    mydata = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSXMLParser *timetableParser = [[NSXMLParser alloc] initWithData:mydata];
    [timetableParser setDelegate:self];
    [timetableParser setShouldProcessNamespaces:NO];
    [timetableParser setShouldReportNamespacePrefixes:NO];
    [timetableParser setShouldResolveExternalEntities:NO];
    
    [timetableParser parse];
    //[merchantTableview reloadData];
    [activityIndicator stopAnimating];
    NSLog(@"user >>> %@", urlString);
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    currentElement=elementName;
    
    if([elementName isEqualToString:@"item"]){
        itemfound=[[NSString alloc] init];
        itemfound=@"yes";
        itemVO=[[ItemVO alloc]init];
        itemVO.titleStr=[[NSString alloc] init];
        itemVO.descriptionStr=[[NSString alloc] init];
        self.currentElement=[[NSString alloc] initWithString:elementName];

    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if([currentElement isEqualToString:@"description"]){
        if (!currentElementData) {
            currentElementData = [[NSMutableString alloc] init];
        }
        [currentElementData appendString:string];
    }else{
        currentElementData = [[NSMutableString alloc] init];
        [currentElementData appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"item"] && [itemfound isEqualToString:@"yes"]){
        [horoscopeArraylist addObject:itemVO];
        itemfound=@"no";
    }else if([elementName isEqualToString:@"description"] && [itemfound isEqualToString:@"yes"]){
        itemVO.descriptionStr=[NSString stringWithString:currentElementData];
        currentElementData=nil;
    }
    else if([elementName isEqualToString:@"title"] && [itemfound isEqualToString:@"yes"]){
        itemVO.titleStr=[NSString stringWithString:currentElementData];
        currentElementData=nil;

    }
}

-(IBAction)aboutusAction{
    AboutUsViewController *aboutus=[[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    [self.navigationController pushViewController:aboutus animated:YES];
    
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

-(IBAction)backAction{
    PlusViewController*plus=[[PlusViewController alloc] initWithNibName:@"PlusViewController" bundle:nil];
    [self.navigationController pushViewController:plus animated:YES];
}
- (void) threadStartAnimating:(id)data {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    activityIndicator.center = CGPointMake(screenRect.size.width / 2.0, screenRect.size.height / 2.0);
    [activityIndicator startAnimating];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [horoscopeArraylist count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thin-arrow-right-only-wh.png"]];
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIFont *customFontdreg = [UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
    UIFont *customFontsub = [UIFont boldSystemFontOfSize:screenRect.size.width*0.03];
    
    ItemVO *itemvo=[horoscopeArraylist objectAtIndex:indexPath.row];
    
    UILabel *newTitelLbl=[[UILabel alloc]init ];
    newTitelLbl.layer.frame=CGRectMake(15,10,screenRect.size.width*0.90,screenRect.size.height*0.07);
    newTitelLbl.text=itemvo.titleStr;
    [newTitelLbl setFont:customFontdreg];
    [newTitelLbl setBackgroundColor:[UIColor clearColor]];
    newTitelLbl.numberOfLines = 0;
    newTitelLbl.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:newTitelLbl];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:itemvo.descriptionStr];
    UIFont *font = customFontsub;
    [title addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    
    UILabel * newdiscriptionLbl=[[UILabel alloc] initWithFrame:CGRectMake(15,screenRect.size.height*0.085,screenRect.size.width*0.90, [self textViewHeightForAttributedText:[[NSAttributedString alloc] initWithString :itemvo.descriptionStr] andWidth:self.view.bounds.size.width-100])];
    newdiscriptionLbl.lineBreakMode = NSLineBreakByWordWrapping;
    newdiscriptionLbl.numberOfLines = 0;
    if(![itemvo.descriptionStr isEqualToString:@""] && itemvo.descriptionStr!=nil)
    {
        [newdiscriptionLbl setAttributedText:title];

        NSString *s;
        s=[NSString stringWithFormat:@"%@",newdiscriptionLbl.text] ;

        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[s dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSString *str;
        str=[NSString stringWithFormat:@"%@",attrStr] ;

        newdiscriptionLbl.attributedText = attrStr;
    }else {
        [newdiscriptionLbl setText:@"N/A"];
    }
    
    [newdiscriptionLbl setFont:customFontsub];
    [newdiscriptionLbl sizeToFit];
    [newdiscriptionLbl setBackgroundColor:[UIColor clearColor]];
    newdiscriptionLbl.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:newdiscriptionLbl];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *langStr=[[NSString alloc]init];
    langStr=[prefs stringForKey:@"Languages"];
    
    if ([prefs stringForKey:@"BackgroundColor"]!=nil) {
        NSString *backgroundStr=[[NSString alloc]init];
        backgroundStr=[prefs stringForKey:@"BackgroundColor"];
        if ([backgroundStr isEqualToString:@"bg_tile_2.png"] || [backgroundStr isEqualToString:@"bg_tile_3.PNG"] ||[backgroundStr isEqualToString:@"bg_tile_5.png"]) {
            newTitelLbl.textColor=[UIColor blackColor];
            newdiscriptionLbl.textColor=[UIColor blackColor];
        }else{
            newTitelLbl.textColor=[UIColor whiteColor];
            newdiscriptionLbl.textColor=[UIColor whiteColor];
        }
    }else{
        newTitelLbl.textColor=[UIColor whiteColor];
        newdiscriptionLbl.textColor=[UIColor whiteColor];
    }
    
    
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor clearColor];
    [cell setSelectedBackgroundView:bgColorView];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    ItemVO *itemVO=[horoscopeArraylist objectAtIndex:indexPath.row];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:itemVO.descriptionStr];
    UIFont *font = [UIFont systemFontOfSize:10];
    [title addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    return [self textViewHeightForAttributedText:title andWidth:screenRect.size.width]+40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)text andWidth:(CGFloat)width
{
    UITextView *textView = [[UITextView alloc] init];
    [textView setAttributedText:text];
    CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
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
