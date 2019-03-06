//
//  ThemesViewController.m
//  Viburnum
//
//  Created by Maksim Sugak on 02/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

/*
 
 === ЧЕКЛИСТ ===
 для переключения между классами Objective-C & Swift
 
 1. Сменить Target Membership
 2. Проверить Custom Class в IB
 3. В ConversationListViewController:
 
 3.1 Для перехода в Swift:
 3.1.1 В segue "themeMenu" раскомментить блок //For Swift class usage:
 3.1.2 Там же закомментить блок // For Objective-C class usage:
 3.1.3 Закомментить extension ConversationListViewController: ThemesViewControllerDelegate в конце кода
 
 3.2 Для перехода в Obj-C:
 3.2.1 В segue "themeMenu" закомментить блок //For Swift class usage:
 3.2.2 В segue "themeMenu" раскомментить блок // For Objective-C class usage:
 3.2.3 Раскомментить extension ConversationListViewController: ThemesViewControllerDelegate в конце кода
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ThemesViewController.h"

@implementation ThemesViewController

// Model init
-(instancetype) initWithCoder: (NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _model = [Themes new];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Updating current theme and applying it to the view background:
  NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentTheme"];
  UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
  self.view.backgroundColor = color;
  
  // All views update:
  NSArray *windows = [UIApplication sharedApplication].windows;
  for (UIWindow *window in windows) {
    for (UIView *view in window.subviews) {
      [view removeFromSuperview];
      [window addSubview:view];
    }
  }
}

- (void)dealloc {
  [_model release];
  [super dealloc];
}

//Model property accessors:
- (Themes*) model {
  return _model;
}

- (void)setModel:(Themes *)NewModel {
  [NewModel retain];
  [_model release];
  _model = NewModel;
}

//Delegate accessors:
- (id<ThemesViewControllerDelegate>)delegate {
  return _delegate;
}

- (void)setDelegate:(id<ThemesViewControllerDelegate>)delegate {
  [delegate retain];
  [_delegate release];
  _delegate = delegate;
}

// Actions:
- (IBAction)backButton:(UIBarButtonItem *)sender {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)themeButtonTap:(UIButton *)sender {
  switch ([sender tag]) {
    case 1:
      [self applyChosenTheme: _model.theme1];
      break;
    case 2:
      [self applyChosenTheme: _model.theme2];
      break;
    case 3:
      [self applyChosenTheme: _model.theme3];
      break;
    default:
      [self applyChosenTheme: UIColor.whiteColor];
      break;
  }
}

- (void)applyChosenTheme:(UIColor *)withColor {
  self.view.backgroundColor = withColor;
  UINavigationBar.appearance.barTintColor = withColor;
  NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:withColor];
  [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:@"currentTheme"];

  // All views update:
  NSArray *windows = [UIApplication sharedApplication].windows;
  for (UIWindow *window in windows) {
    for (UIView *view in window.subviews) {
      [view removeFromSuperview];
      [window addSubview:view];
    }
  }
  
  // Delegate method:
  [_delegate themesViewController:self didSelectTheme: withColor];
}

@end
