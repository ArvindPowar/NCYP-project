//
//  AsyncImageView.h.h
//  YellowJacket
//
//  Created by Wayne Cochran on 7/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


//
// Code heavily lifted from here:
// http://www.markj.net/iphone-asynchronous-table-image/
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AsyncImageView : UIView {
    NSURLConnection *connection;
    NSMutableData *data;
    NSString *urlString;
}
@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,retain) AppDelegate *appDelegate;

-(void)loadImageFromURL:(NSURL*)url;

@end
