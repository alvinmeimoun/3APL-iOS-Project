//
//  CampusListViewController.m
//  SupInTrack
//
//  Created by Alvin Meimoun on 27/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#import "CampusListViewController.h"

@interface CampusListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CampusListViewController

NSArray* campusList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.translucent = NO;
    
    LoadViewController* parentLoadController = (LoadViewController*)self.navigationController.viewControllers[0];
    if(parentLoadController != nil && parentLoadController.nearestCampus != nil){
        [self bindCampuses:parentLoadController.campusList];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) bindCampuses:(NSArray*)campusModels {
    campusList = campusModels;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CellCampusList";
    
    CampusListCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[CampusListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    [cell bind:[campusList objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(campusList == nil) return 0; else return [campusList count];
}

@end