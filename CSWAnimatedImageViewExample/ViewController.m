//
//  ViewController.m
//  CSWAnimatedImageViewExample
//
//  Created by Christopher Worley on 11/01/15.
//  Copyright © 2015 Christopher Worley. All rights reserved.
//

#import "ViewController.h"

// set to zero to initialize from this file 1 to let it init from IB
#define LOAD_FROM_OBJECT 1

@interface ViewController ()
{
	UIColor *firstColor;
	UIColor *secondColor;
	int colorNum;
}

@property (nonatomic, weak) IBOutlet UISlider *durationSlider;
@property (nonatomic, weak) IBOutlet UISlider *startPointxSlider;
@property (nonatomic, weak) IBOutlet UISlider *startPointySlider;
@property (nonatomic, weak) IBOutlet UISlider *endPointxSlider;
@property (nonatomic, weak) IBOutlet UISlider *endPointySlider;
@property (nonatomic, weak) IBOutlet UILabel *durationLabel;
@property (nonatomic, weak) IBOutlet UILabel *startPointxLabel;
@property (nonatomic, weak) IBOutlet UILabel *startPointyLabel;
@property (nonatomic, weak) IBOutlet UILabel *endPointxLabel;
@property (nonatomic, weak) IBOutlet UILabel *endPointyLabel;
@property (nonatomic, weak) IBOutlet UISwitch *bAutoReverse;
@property (nonatomic, strong) CSWAnimatedImageObject *animatedImageObject;

@end

@implementation ViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

	if ([segue.identifier isEqualToString:@"colorPickerSegue0"])
	{
		colorNum = 0;
		ColorViewController *vc = segue.destinationViewController;
		vc.delegate = self;

		[vc putInColor:firstColor];
	}
	else if ([segue.identifier isEqualToString:@"colorPickerSegue1"])
	{
		colorNum = 1;
		ColorViewController *vc = segue.destinationViewController;
		vc.delegate = self;
		
		[vc putInColor:secondColor];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	_innerColorButton.layer.cornerRadius = 6;
	_outerColorButton.layer.cornerRadius = 6;
	
	_animatedImageObject = [[CSWAnimatedImageObject alloc] init];

	if (LOAD_FROM_OBJECT) {
		[self setDisplayValuesFromAnimationObject];
	}
	else {
		[self setDefaultValuesFromViewController];
	}
}

- (void)setDefaultValuesFromViewController {
	
	_animatedImageObject.colorOuter = [UIColor darkGrayColor];
	_animatedImageObject.colorInner = [UIColor lightGrayColor];
	_animatedImageObject.startPoint = CGPointMake(0.0, 0.5);
	_animatedImageObject.endPoint = CGPointMake(1.0, 0.5);
	_animatedImageObject.duration = 2.0;
	_animatedImageObject.imageName = @"hg";
	_animatedImageObject.reverse = YES;

	[self setDisplayValues];
	
	[_imageAnimate setAnimatedImageObject:_animatedImageObject];
}

- (void)setDisplayValuesFromAnimationObject {
	
	_animatedImageObject.colorOuter = _imageAnimate.colorOuter;
	_animatedImageObject.colorInner = _imageAnimate.colorInner;
	_animatedImageObject.reverse = _imageAnimate.reverse;
	
	_animatedImageObject.duration = _imageAnimate.duration;
	_animatedImageObject.startPoint = _imageAnimate.startPoint;
	_animatedImageObject.endPoint = _imageAnimate.endPoint;
	
	_animatedImageObject.imageName = _imageAnimate.imageName;
	
	
	[self setDisplayValues];
}

- (void)setDisplayValues {
	_bAutoReverse.on = _animatedImageObject.reverse;
	
	firstColor = _animatedImageObject.colorOuter;
	secondColor = _animatedImageObject.colorInner;
	
	_innerColorButton.backgroundColor = firstColor;
	_outerColorButton.backgroundColor = secondColor;

	self.startPointxSlider.value = _animatedImageObject.startPoint.x;
	self.startPointySlider.value = _animatedImageObject.startPoint.y;
	
	self.endPointxSlider.value = _animatedImageObject.endPoint.x;
	self.endPointySlider.value = _animatedImageObject.endPoint.y;
	
	self.durationSlider.value = _animatedImageObject.duration;
	self.startPointxLabel.text = [NSString stringWithFormat:@"%.2f", self.startPointxSlider.value];
	self.startPointyLabel.text = [NSString stringWithFormat:@"%.2f", self.startPointySlider.value];
	self.endPointxLabel.text = [NSString stringWithFormat:@"%.2f", self.endPointxSlider.value];
	self.endPointyLabel.text = [NSString stringWithFormat:@"%.2f", self.endPointySlider.value];
	self.durationLabel.text = [NSString stringWithFormat:@"%.2f", self.durationSlider.value];

	_imageAnimate.imageName = _animatedImageObject.imageName;
	
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.view endEditing:YES];
}

- (IBAction)pointsChanged:(id)sender {
	
	CGPoint startPoint;
	CGPoint endPoint;
	
	startPoint.x = _startPointxSlider.value;
	startPoint.y = _startPointySlider.value;
	
	endPoint.x = _endPointxSlider.value;
	endPoint.y = _endPointySlider.value;
	
	self.startPointxLabel.text = [NSString stringWithFormat:@"%.2f", self.startPointxSlider.value];
	self.startPointyLabel.text = [NSString stringWithFormat:@"%.2f", self.startPointySlider.value];
	self.endPointxLabel.text = [NSString stringWithFormat:@"%.2f", self.endPointxSlider.value];
	self.endPointyLabel.text = [NSString stringWithFormat:@"%.2f", self.endPointySlider.value];
	
	_imageAnimate.startPoint = startPoint;
	_imageAnimate.endPoint = endPoint;
}

- (IBAction)autoReverse:(id)sender {

	_imageAnimate.reverse = _bAutoReverse.on;
}

- (IBAction)durationChanged:(UISlider *)sender {

	_imageAnimate.duration = self.durationSlider.value;
	self.durationLabel.text = [NSString stringWithFormat:@"%.2f", self.durationSlider.value];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark ColorPickerDelegate

- (void)selectedColor:(UIColor *)color {
	
	if (!colorNum) {
		firstColor = color;
		_innerColorButton.backgroundColor = firstColor;
		_imageAnimate.colorOuter = firstColor;
		_animatedImageObject.colorOuter = firstColor;
		
		_imageAnimate.colorInner = _animatedImageObject.colorInner;
	} else {
		secondColor = color;
		_outerColorButton.backgroundColor = secondColor;
		_imageAnimate.colorInner = secondColor;
		_animatedImageObject.colorInner = secondColor;
		
		_imageAnimate.colorOuter = _animatedImageObject.colorOuter;
	}
}

@end
