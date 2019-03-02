//
//  ThemesViewController.h
//  Viburnum
//
//  Created by Maksim Sugak on 02/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThemesViewController : UIViewController

@property (weak) id<ThemesViewControllerDelegate> delegate;
@property (retain) Themes model;

// Outlet collection of buttons:
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *themeChooseButtons;

// Action for tapped buttons:
- (IBAction)themeChooseButtonTappted:(UIButton*)sender;
@end

NS_ASSUME_NONNULL_END
