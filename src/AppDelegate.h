#import <UIKit/UIKit.h>

#include <GoogleSignIn/GIDSignIn.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

// The sample app's |UIWindow|.
@property(strong, nonatomic) UIWindow *window;

@end

