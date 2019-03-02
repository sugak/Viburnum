//
//  Themes.m
//  Viburnum
//
//  Created by Maksim Sugak on 02/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

#import "Themes.h"

@implementation Themes : NSObject

// Don't need setters - properties are read only
// Getters for theme properties:
- (UIColor *) theme1 {
  return [UIColor blueColor];
}

- (UIColor *) theme2 {
  return [UIColor brownColor];
}

- (UIColor *) theme3 {
  return [UIColor magentaColor];
}

@end
