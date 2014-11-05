//
//  XYZPhotoTableViewController.m
//  MyBox
//
//  Created by Patron Login on 11/4/14.
//  Copyright (c) 2014 Phyyu. All rights reserved.
//

#import "XYZPhotoTableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>



@implementation XYZPhotoTableViewController

@synthesize photos = _photos;

-(void)setPhotos:(NSArray *)photos {
    if (_photos != photos) {
        _photos = photos;
        [self.tableView reloadData];
    }
}

- (void) viewWillAppear:(BOOL)animated  {
    
    // collect the photos
    NSMutableArray *collector = [[NSMutableArray alloc] initWithCapacity:0];
    ALAssetsLibrary *al = [XYZPhotoTableViewController defaultAssetsLibrary];
    
    [al enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                      usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop)
          {
              if (asset) {
                  [collector addObject:asset];
              }
          }];
         
         self.photos = collector;
     }
                    failureBlock:^(NSError *error) { NSLog(@"Error!");}
     ];
    
}


+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyPhotos";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    ALAsset *asset = [self.photos objectAtIndex:indexPath.row];
    
    [cell.imageView setImage:[UIImage imageWithCGImage:[asset thumbnail]]];
    [cell.textLabel setText:[NSString stringWithFormat:@"Photo %d", indexPath.row+1]];

    return cell;
}




@end







