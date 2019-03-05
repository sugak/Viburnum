//
//  ThemesViewController.h
//  Viburnum
//
//  Created by Maksim Sugak on 02/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ThemesViewControllerDelegate.h"
#import "Themes.h"

@interface ThemesViewController : UIViewController {
  id<ThemesViewControllerDelegate> _delegate;
  Themes* _model;
}

@property (assign, nonatomic) id<ThemesViewControllerDelegate> delegate;
@property (retain, nonatomic) Themes* model;


- (void)applyChosenTheme:(UIColor*) withColor;

// Action for tapped buttons:
- (IBAction)themeButtonTap:(UIButton*)sender;
- (IBAction)closeButtonTap:(UIBarButtonItem *)sender;

@end




