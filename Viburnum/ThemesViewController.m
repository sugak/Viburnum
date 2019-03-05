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

-(instancetype) initWithCoder: (NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _model = [Themes new];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)dealloc {
  [_model release];
  printf("dealloc");
  [super dealloc];
}

//model property accessors:
- (Themes*) model {
  return _model;
}

- (IBAction)backButton:(UIBarButtonItem *)sender {
[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setModel:(Themes *)NewModel {
  [NewModel retain];
  [_model release];
  _model = NewModel;
}

// delegate accessors:
- (id<ThemesViewControllerDelegate>)delegate {
  return _delegate;
}

- (void)setDelegate:(id<ThemesViewControllerDelegate>)delegate {
  if (_delegate != delegate) {
    _delegate = delegate;
  }
}

// Actions:
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

  // Cook receipt from stackoverflow for UI update:
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
