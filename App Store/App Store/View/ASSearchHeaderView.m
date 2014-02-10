//
//  SearchHeaderView.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 23/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASSearchHeaderView.h"

@implementation ASSearchHeaderView

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.delegate filterContentForSearchText:searchText inSearchBar:(UISearchBar *)self.appSearchBar];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.delegate displayAlert];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self.delegate hideSearchBar];
}

@end
