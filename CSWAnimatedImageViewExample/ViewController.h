//
//  ViewController.h
//  CSWAnimatedImageViewExample
//
//  Created by Christopher Worley on 11/01/15.
//  Copyright © 2015 Christopher Worley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSWAnimatedImageView.h"
#import "ColorViewController.h"


@interface ViewController : UIViewController <ColorPickerDelegate>

@property (weak, nonatomic) IBOutlet CSWAnimatedImageView *imageAnimate;
@property (weak, nonatomic) IBOutlet UIButton *innerColorButton;
@property (weak, nonatomic) IBOutlet UIButton *outerColorButton;

@end

