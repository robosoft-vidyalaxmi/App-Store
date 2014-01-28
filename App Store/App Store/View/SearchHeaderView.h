//
//  SearchHeaderView.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 23/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchHeaderView;

@protocol SearchDelegate <NSObject>

-(void) filterContentForSearchText:(NSString *)searchText inSearchBar:(UISearchBar *)searchBar ;
-(void) displayAlert;
-(void) hideSearchBar;

@end

@interface SearchHeaderView : UICollectionReusableView <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *appSearchBar;
@property (nonatomic, assign) id<SearchDelegate> delegate;

@end
