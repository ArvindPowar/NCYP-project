//
//  AppDelegate.m
//  NCYP
//
//  Created by arvind on 4/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>

#warning Replace following value for kWundergroundKey with value of "key id" you get from http://www.wunderground.com/weather/api/

const NSString *kWundergroundKey = @"1436e2d88c65341a";

@interface AppDelegate ()<CLLocationManagerDelegate, UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    UIActivityIndicatorView *activityIndicator;
}



@end

@implementation AppDelegate
@synthesize navController,isSqurethemes,isenglishselected,usdstr,eurostr,gbpstr,tempstrl,ishomenewBtnclick;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    isSqurethemes=true;
    isenglishselected=true;
    HomeViewController *loginviewController;
    
    loginviewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:loginviewController];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)gettempanddollerrate{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [locationManager startUpdatingLocation];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate =self;
    [locationManager startUpdatingLocation];
    
    NSString *myURLString = @"http://www.google.com/finance/converter?a=1&from=EUR&to=TRY";
    NSURL *myURL =  [NSURL URLWithString: myURLString];
    NSData *data = [NSData alloc];
    data=[NSData dataWithContentsOfURL:myURL];
    if(data!=nil){
        
        NSString *response = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
        NSArray* allDataarray = [response componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
        if ([allDataarray count]>0) {
            for (int count=0; count<[allDataarray count]; count++) {
                NSString* finalStr =[allDataarray objectAtIndex:count];
                if ([finalStr rangeOfString:@"1 EUR"].location != NSNotFound ) {
                    NSArray* allDataar = [finalStr componentsSeparatedByString: @" TRY"];
                    NSString* str = [allDataar objectAtIndex:0];
                    NSArray* allData = [str componentsSeparatedByString: @"bld>"];
                    NSString* strs = [allData objectAtIndex:1];
                    float finaltotalvalue=[strs floatValue];
                    eurostr=[[NSString alloc]init];
                    eurostr=[NSString stringWithFormat:@"€%.2f",finaltotalvalue];
                    [prefs setObject:eurostr forKey:@"EURO"];
                    [prefs synchronize];
                }
            }
        }
    }
    NSString *myURLStrings = @"http://www.google.com/finance/converter?a=1&from=USD&to=TRY";
    NSURL *myURLs =  [NSURL URLWithString: myURLStrings];
    NSData *datas = [NSData alloc];
    datas=[NSData dataWithContentsOfURL:myURLs];
    if(datas!=nil){
        
        NSString *response = [[NSString alloc] initWithData:datas encoding:NSISOLatin1StringEncoding];
        NSArray* allDataarray = [response componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
        if ([allDataarray count]>0) {
            for (int count=0; count<[allDataarray count]; count++) {
                NSString* finalStr =[allDataarray objectAtIndex:count];
                if ([finalStr rangeOfString:@"1 USD"].location != NSNotFound ) {
                    NSArray* allDataar = [finalStr componentsSeparatedByString: @" TRY"];
                    NSString* str = [allDataar objectAtIndex:0];
                    NSArray* allData = [str componentsSeparatedByString: @"bld>"];
                    NSString* strs = [allData objectAtIndex:1];
                    float finaltotalvalue=[strs floatValue];
                    usdstr=[[NSString alloc]init];
                    usdstr=[NSString stringWithFormat:@"$%.2f",finaltotalvalue];
                    [prefs setObject:usdstr forKey:@"USD"];
                    [prefs synchronize];
                }
            }
        }
        
        NSLog(@"%@",response);
    }
    NSString *myURLStringss = @"http://www.google.com/finance/converter?a=1&from=GBP&to=TRY";
    NSURL *myURLss =  [NSURL URLWithString: myURLStringss];
    NSData *datass = [NSData alloc];
    datass=[NSData dataWithContentsOfURL:myURLss];
    if(datass!=nil){
        
        NSString *response = [[NSString alloc] initWithData:datass encoding:NSISOLatin1StringEncoding];
        NSArray* allDataarray = [response componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
        if ([allDataarray count]>0) {
            for (int count=0; count<[allDataarray count]; count++) {
                NSString* finalStr =[allDataarray objectAtIndex:count];
                if ([finalStr rangeOfString:@"1 GBP"].location != NSNotFound ) {
                    NSArray* allDataar = [finalStr componentsSeparatedByString: @" TRY"];
                    NSString* str = [allDataar objectAtIndex:0];
                    NSArray* allData = [str componentsSeparatedByString: @"bld>"];
                    NSString* strs = [allData objectAtIndex:1];
                    float finaltotalvalue=[strs floatValue];
                    gbpstr=[[NSString alloc]init];
                    gbpstr=[NSString stringWithFormat:@"£%.2f",finaltotalvalue];
                    [prefs setObject:gbpstr forKey:@"POUND"];
                    [prefs synchronize];
                }
            }
        }
        NSLog(@"%@",response);
    }
    
}
#pragma mark - CLLocationManager location change start/stop methods

- (void)startSignificantUpdates
{
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
        
        locationManager.delegate = self;
        
        [locationManager startMonitoringSignificantLocationChanges];
    }
}

- (void)stopSignificantUpdates
{
    if (locationManager != nil)
    {
        [locationManager stopMonitoringSignificantLocationChanges];
        locationManager = nil;
    }
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation* location = [locations lastObject];
    
    [self retrieveWeatherForLocation:location orZipCode:nil];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //[self hideZipCode:NO animate:YES];
    
    // handle location errors here, such as case where user doesn't let app use iphone's location
    
    [self updateStatusMessage:@"Unable to determine location. You must enable location services for this app in Settings. Or just enter zip code."
        stopActivityIndicator:YES
         stopLocationServices:NO
                   logMessage:error];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorized)
    {
        [self updateStatusMessage:@"You must authorize this app to determine location of device for this app in Settings."
            stopActivityIndicator:YES
             stopLocationServices:NO
                       logMessage:@(status)];
    }
    
}

#pragma mark - Methods for retrieving weather from Wunderground

- (void)retrieveWeatherForLocation:(CLLocation *)location orZipCode:(NSString *)zipCode
{
    NSString *urlString;
    
    // get URL for current conditions
    
    if (location)
    {
        // based upon longitude and latitude returned by CLLocationManager
        
        urlString = [NSString stringWithFormat:@"http://api.wunderground.com/api/%@/conditions/q/%+f,%+f.json",
                     kWundergroundKey,
                     location.coordinate.latitude,
                     location.coordinate.longitude];
    }
    else if ([zipCode length] == 5)
    {
        // based upon the zip code
        
        urlString = [NSString stringWithFormat:@"http://api.wunderground.com/api/%@/conditions/q/%@.json",
                     kWundergroundKey,
                     zipCode];
        
    }
    else
    {
        NSAssert(NO, @"You must provide a CLLocation object or five digit zip code");
    }
    
    // Log it so you can see what the URL was for diagnostic purposes.
    // It's often useful to pull this up in a web browser like FireFox
    // so you can diagnose what's going on.
    
    [self updateStatusMessage:@"Identified location; determining weather" stopActivityIndicator:NO stopLocationServices:NO logMessage:urlString];
    
    NSURL *url          = [NSURL URLWithString:urlString];
    
    NSData *weatherData = [NSData dataWithContentsOfURL:url];
    
    // make sure we were able to get some response from the URL; if not
    // maybe your internet connection is not operational, or something
    // like that.
    
    if (weatherData == nil)
    {
        [self updateStatusMessage:@"Unable to retrieve data from weather service" stopActivityIndicator:YES stopLocationServices:YES logMessage:@"weatherData is nil"];
        return;
    }
    
    // parse the JSON results
    
    NSError *error;
    id weatherResults = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&error];
    
    // if there was an error, report this
    
    if (error != nil)
    {
        [self updateStatusMessage:@"Error parsing results from weather service" stopActivityIndicator:YES stopLocationServices:YES logMessage:error];
        return;
    }
    
    // otherwise, let's make sure we got a NSDictionary like we expected
    
    else if (![weatherResults isKindOfClass:[NSDictionary class]])
    {
        [self updateStatusMessage:@"Unexpected results from weather service" stopActivityIndicator:YES stopLocationServices:YES logMessage:weatherResults];
        return;
    }
    
    // if we've gotten here, that means that we've parsed the JSON feed from Wunderground,
    // so now let's see if we got the expected response
    
    NSDictionary *response = weatherResults[@"response"];
    if (response == nil || ![response isKindOfClass:[NSDictionary class]])
    {
        [self updateStatusMessage:@"Unable to parse results from weather service" stopActivityIndicator:YES stopLocationServices:YES logMessage:weatherResults];
        return;
    }
    
    // now, let's see if that response reported any particular error
    
    NSDictionary *errorDictionary = response[@"error"];
    if (errorDictionary != nil)
    {
        NSString *message = @"Error reported by weather service";
        
        if (errorDictionary[@"description"])
            message = [NSString stringWithFormat:@"%@: %@", message, errorDictionary[@"description"]];
        [self updateStatusMessage:message stopActivityIndicator:YES stopLocationServices:YES logMessage:errorDictionary];
        
        if ([errorDictionary[@"type"] isEqualToString:@"keynotfound"])
        {
            NSLog(@"%s You must get a key for your app from http://www.wunderground.com/weather/api/", __FUNCTION__);
        }
        return;
    }
    
    // if no errors thus far, then we can now inspect the current_observation
    
    NSDictionary *currentObservation = weatherResults[@"current_observation"];
    
    if (currentObservation == nil)
    {
        // if not found, let's tell the user
        
        [self updateStatusMessage:@"No observation data found" stopActivityIndicator:YES stopLocationServices:YES logMessage:weatherResults];
        return;
    }
    
    // otherwise, let's look up the barometer information
    
    NSString *statusMessage;
    NSString *pressureMb = currentObservation[@"pressure_mb"];
    
    if (pressureMb)
    {
        statusMessage = @"Retrieved barometric pressure";
        //self.pressureMbLabel.text = pressureMb;
    }
    else
    {
        statusMessage = @"No barometric information found";
    }
    
    NSNumber *tempC      = currentObservation[@"temp_c"];
    
    if (tempC)
    {
        statusMessage = @"Retrieved temperature";
        tempstrl=[[NSString alloc]init];
        tempstrl = [NSString stringWithFormat:@"%@ °C",[tempC stringValue]];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:tempstrl forKey:@"TEMP"];
        [prefs synchronize];
        
    }
    else
    {
        statusMessage = @"No temperature information found";
    }
    
    // update the user interface status message
    
    [self updateStatusMessage:statusMessage stopActivityIndicator:YES stopLocationServices:YES logMessage:weatherResults];
}
- (void)updateStatusMessage:(NSString *)userInterfaceMessage
      stopActivityIndicator:(BOOL)stopActivityIndicator

       stopLocationServices:(BOOL)stopLocationServices
                 logMessage:(id)systemLogInformation
{
    
    
    if (stopLocationServices)
        [self stopSignificantUpdates];
    
    // note, we should only use NSLog during diagnostic phase of development;
    // in production app, we should comment out the following NSLog!
    
    if (systemLogInformation)
        NSLog(@"%s %@", __FUNCTION__, @[userInterfaceMessage, systemLogInformation]);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
