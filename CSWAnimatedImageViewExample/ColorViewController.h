//
//  ColorViewController.h
//  CSWAnimatedTextView
//
//  Created by Christopher Worley on 10/30/15.
//  Copyright © 2015 Christopher Worley. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate <NSObject>

- (void)selectedColor:(UIColor *)color;

@end

@interface ColorViewController : UIViewController

@property (nonatomic, assign) id<ColorPickerDelegate> delegate;

- (void)putInColor:(UIColor *)color;

@end