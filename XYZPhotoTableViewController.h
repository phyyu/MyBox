//
//  XYZPhotoTableViewController.h
//  MyBox
//
//  Created by Patron Login on 11/4/14.
//  Copyright (c) 2014 Phyyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface XYZPhotoTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *photos;


+ (ALAssetsLibrary *)defaultAssetsLibrary;

@end