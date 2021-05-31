#include <GoogleSignIn/GIDGoogleUser.h>

#import "AppDelegate.h"
#include "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    GIDSignIn * gidSignIn = [GIDSignIn sharedInstance];
    gidSignIn.clientID = @"791069964913-o211kjabvndbidol9fhcnh9k79hn3lf3.apps.googleusercontent.com";
    gidSignIn.delegate = self;


    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController *masterViewController = [[ViewController alloc] init];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(nonnull UIApplication *)application
            openURL:(nonnull NSURL *)url
            options:(nonnull NSDictionary<NSString *, id> *)options {
  return [[GIDSignIn sharedInstance] handleURL:url];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    const char* userId = [[user userID] UTF8String];
    const char* errDescription = 0;
    if (error) {
        errDescription = [[error description] UTF8String];
    }
    printf("Inside singIn:didSignInForUser:WithError: \
           \n\t GIDSignIn=%p; \
           \n\t GIDGoogleUser=%p; userId = %s; \
           \n\t NSError = %p; description = %s; \n",
           signIn, user, userId, error, errDescription);
    
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    const char* userId = [[user userID] UTF8String];
    const char* errDescription = 0;
    if (error) {
        errDescription = [[error description] UTF8String];
    }
    
    printf("Inside singIn:didDisconnectWithUser:WithError: \
           \n\t GIDSignIn=%p; \
           \n\t GIDGoogleUser=%p; userId = %s; \
           \n\t NSError = %p; description = %s; \n",
           signIn, user, userId, error, errDescription);
}


@end
