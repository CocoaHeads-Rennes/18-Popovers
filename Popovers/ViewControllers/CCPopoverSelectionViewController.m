//
//  CCPopoverSelectionViewController.m
//  Popovers
//
//  Created by Joanna Carter on 10/08/2014.
//  Copyright (c) 2014 Carter Consulting. All rights reserved.
//


#import "CCPopoverSelectionViewController.h"
#import "CCPopoverCell.h"


@interface CCPopoverSelectionViewController () <UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *popoverController;

@property (strong, nonatomic) NSArray *values;

@property (nonatomic) CGFloat width;

@property (strong, nonatomic) NSString *selectedValue;

@end


@implementation CCPopoverSelectionViewController

@synthesize popoverController;

@synthesize rotationBlock = _rotationBlock;

@synthesize scrollBlock = _scrollBlock;

- (instancetype)initWithValues:(NSArray *)values width:(CGFloat)width permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
{
  self = [super initWithNibName:@"CCPopoverSelectionView" bundle:nil];
  
  if (self)
  {
    _values = values;
    
    _width = width;
    
    self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self];
    
    self.popoverController.delegate = self;
  }
  
  return self;
}

- (instancetype)initWithWidth:(CGFloat)width permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
{
  NSArray *values = @[@"Joanna", @"AliGator", @"Cocoaheads", @"Rennes"];
  
  return [self initWithValues:values width:width permittedArrowDirections:arrowDirections];
}

- (void)dealloc
{
  NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.tableView.scrollEnabled = NO;
  
  [CCPopoverCell registerWithTableView:self.tableView];
}

- (void)setSelectedValue:(NSString *)selectedValue
{
  if ([self.values containsObject:selectedValue])
  {
    _selectedValue = selectedValue;
  }
  
  [self.tableView reloadData];
}

- (CGSize)preferredContentSize
{
  CGFloat height = self.values.count * 44.0f;
  
  return CGSizeMake(self.width, height);
}

#pragma mark - UITableViewDataSource implementations

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  CCPopoverCell *cell = [tableView dequeueReusableCellWithIdentifier:[CCPopoverCell reuseIdentifier]];
  
  if (indexPath.row == ((NSInteger) self.values.count - 1))
  {
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
  }
  
  NSString *value = self.values[indexPath.row];
  
  cell.textLabel.text = value.description;
  
  if ([value isEqualToString:self.selectedValue])
  {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  }
  else
  {
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  
  return cell;
}

#pragma mark - UITableViewDelegate implementations

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self setSelectedValue:self.values[indexPath.row]];
  
  self.selectionBlock(self.selectedValue);
  
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  [self.popoverController dismissPopoverAnimated:YES];
  
  self.popoverController = nil;
}

#pragma mark - CCPopoverController implementations

- (BOOL)isPopoverVisible
{
  return self.popoverController.isPopoverVisible;
}

- (void)dismissPopoverAnimated:(BOOL)animated
{
  [self.popoverController dismissPopoverAnimated:animated];
}

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated
{
  [self.popoverController presentPopoverFromRect:rect
                                          inView:view
                        permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown
                                        animated:YES];
}

#pragma mark - UIPopoverControllerDelegate implementations

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
  if (self.selectedValue)
  {
    self.selectionBlock(self.selectedValue);
  }
  
  self.popoverController = nil;
}

@end
