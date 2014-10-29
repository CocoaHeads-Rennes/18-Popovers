//
//  CCListViewController.m
//  Popovers
//
//  Created by Joanna Carter on 10/08/2014.
//  Copyright (c) 2014 Carter Consulting. All rights reserved.
//


#import "CCListViewController.h"
#import "CCListCell.h"
#import "CCPopoverSelectionViewController.h"
#import "CCPopoverManager.h"


@interface CCListViewController ()

@property (strong, nonatomic, readonly) NSMutableArray *items;

@end


@implementation CCListViewController

@synthesize items = _items;

- (NSMutableArray *)items
{
  if (!_items)
  {
    _items = [NSMutableArray array];
    
    for (int i = 0; i < 30; i++)
    {
      [_items addObject:[NSString stringWithFormat:@"Item %d", i]];
    }
  }
  
  return _items;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [CCListCell registerWithTableView:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return [CCListCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  CCListCell *cell = [tableView dequeueReusableCellWithIdentifier:[CCListCell reuseIdentifier] forIndexPath:indexPath];
  
  cell.detailTextLabel.text = self.items[indexPath.row];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  __block CCListCell *cell = (CCListCell *) [tableView cellForRowAtIndexPath:indexPath];
  
  __block CGRect popoverOriginRect = [tableView convertRect:cell.popoverOriginRect fromView:cell];
  
  CCPopoverSelectionViewController *selectionViewController = [[CCPopoverSelectionViewController alloc] initWithWidth:200.0
                                                                                             permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown];
  
  [selectionViewController setSelectedValue:cell.detailTextLabel.text];
  
  __weak typeof(self) weakSelf = self;
  
  selectionViewController.selectionBlock = ^(NSString *value)
                                            {
                                              typeof(weakSelf) strongSelf = weakSelf;
                                              
                                              if (strongSelf)
                                              {
                                                strongSelf.items[indexPath.row] = value;
                                                
                                                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                              }
                                            };
  
  selectionViewController.rotationBlock = ^(id<CCPopoverViewController> popoverController)
                                           {
                                             cell = (CCListCell *) [tableView cellForRowAtIndexPath:indexPath];
                                             
                                             CGFloat sizeHeight = tableView.bounds.size.height;
                                             
                                             CGFloat contentOffset = tableView.contentOffset.y;
                                             
                                             CGFloat cellHeight = cell.bounds.size.height;
                                             
                                             if (cellHeight > sizeHeight + contentOffset - cell.frame.origin.y)
                                             {
                                               [self.tableView scrollToRowAtIndexPath:indexPath
                                                                     atScrollPosition:UITableViewScrollPositionMiddle
                                                                             animated:YES];
                                             }
                                             else
                                             {
                                               cell = (CCListCell *) [tableView cellForRowAtIndexPath:indexPath];
                                               
                                               popoverOriginRect = [tableView convertRect:cell.popoverOriginRect fromView:cell];
                                               
                                               [[CCPopoverManager sharedInstance] presentPopoverController:popoverController
                                                                                            fromRect:popoverOriginRect
                                                                                              inView:tableView
                                                                                            animated:YES];
                                             }
                                           };
  
  selectionViewController.scrollBlock = ^(id<CCPopoverViewController> popoverController)
                                         {
                                           cell = (CCListCell *) [tableView cellForRowAtIndexPath:indexPath];
                                           
                                           popoverOriginRect = [tableView convertRect:cell.popoverOriginRect fromView:cell];
                                           
                                           [[CCPopoverManager sharedInstance] presentPopoverController:popoverController
                                                                                       fromRect:popoverOriginRect
                                                                                         inView:tableView
                                                                                       animated:YES];
                                         };
  
  [[CCPopoverManager sharedInstance] presentPopoverController:selectionViewController fromRect:popoverOriginRect inView:tableView animated:YES];
}

#pragma mark - rotation

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
  [[CCPopoverManager sharedInstance] popoverWillRotate];
  
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
  [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
  
  [[CCPopoverManager sharedInstance] popoverDidRotate];
}

#pragma mark - scrolling

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
  [[CCPopoverManager sharedInstance] popoverDidScroll];
}

@end
