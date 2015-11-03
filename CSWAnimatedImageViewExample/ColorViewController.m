//
//  ColorViewController.m
//  CSWAnimatedTextView
//
//  Created by Christopher Worley on 10/30/15.
//  Copyright © 2015 Christopher Worley. All rights reserved.
//

#import "ColorViewController.h"
#import "NKOColorPickerView.h"

@interface ColorViewController ()
{
	UIColor *localColor;
}

@property (nonatomic, weak) IBOutlet NKOColorPickerView *pickeView;

@end

@implementation ColorViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	[self _setupColorPicker];
}

- (IBAction)exit:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectColor:(id)sender {
	[self.delegate selectedColor:localColor];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)putInColor:(UIColor *)color {
	localColor = color;
}

#pragma mark - Private methods

- (void)_setupColorPicker
{
	__weak typeof(self) weakSelf = self;
	id changeColorBlock = ^(UIColor *color){
		typeof(self) strongSelf = weakSelf;
		[strongSelf _customizeButtonWithColor:color];
	};
	
	[self.pickeView setDidChangeColorBlock:changeColorBlock];
	
	[self.pickeView setColor:localColor];
	[self.pickeView setTintColor:[UIColor darkGrayColor]];
}

- (void)_customizeButtonWithColor:(UIColor*)color {
	localColor = self.pickeView.color;
}

@end
