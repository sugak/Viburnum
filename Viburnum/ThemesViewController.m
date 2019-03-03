//
//  ThemesViewController.m
//  Viburnum
//
//  Created by Maksim Sugak on 02/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ThemesViewController.h"

@implementation ThemesViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
 self.model = [[Themes alloc] init];
  // _model = [[Themes alloc] init];
}

//Getters:
- (Themes*) model {
  return _model;
}

- (id<ThemesViewControllerDelegate>)delegate {
  return _delegate;
}

// Setters:
- (void)setDelegate:(id<ThemesViewControllerDelegate>)delegate {
  if (_delegate != delegate)
    _delegate = delegate;
}

-(IBAction)themeChooseButtonTappted:(UIButton *)sender {
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

-(IBAction)backButtonTapped:(UIBarButtonItem *)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)applyChosenTheme:(UIColor *)withColor {
  self.view.backgroundColor = withColor;
  UINavigationBar.appearance.backgroundColor = withColor;
  UINavigationBar.appearance.barTintColor = withColor;

  NSArray *windows = [UIApplication sharedApplication].windows;
  for (UIWindow *window in windows) {
    for (UIView *view in window.subviews) {
      [view removeFromSuperview];
      [window addSubview:view];
    }
  }
  
  [_delegate themesViewController:self didSelectTheme: withColor];
  
}

@end
