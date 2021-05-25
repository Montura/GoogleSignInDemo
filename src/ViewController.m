#import <UIKit/UIKit.h>

#include <GoogleSignIn/GoogleSignIn.framework/Headers/GoogleSignIn.h>

@interface ViewController : UIViewController
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Press Me" forState:UIControlStateNormal];
    [button sizeToFit];
    
    // Set a new (x,y) point for the button's center
    button.center = CGPointMake(320/2, 60);
    
    // Add an action in current code file (i.e. target)
   [button addTarget:self action:@selector(buttonPressed:)
       forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)buttonPressed:(UIButton *)button {
    [GIDSignIn sharedInstance].presentingViewController = self;
    [[GIDSignIn sharedInstance] signIn];
}


@end
