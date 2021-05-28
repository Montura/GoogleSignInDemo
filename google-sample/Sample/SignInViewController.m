//
//  SignInViewController.m
//
//  Copyright 2012 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "SignInViewController.h"

#import <GoogleSignIn/GoogleSignIn.h>

typedef void(^AlertViewActionBlock)(void);

@interface SignInViewController () <GIDSignInDelegate>

@property (nonatomic, copy) void (^confirmActionBlock)(void);
@property (nonatomic, copy) void (^cancelActionBlock)(void);

@end

static NSString *const kPlaceholderUserName = @"<Name>";
static NSString *const kPlaceholderEmailAddress = @"<Email>";
static NSString *const kPlaceholderAvatarImageName = @"PlaceholderAvatar.png";

// Labels for the cells that have in-cell control elements.
static NSString *const kGetUserProfileCellLabel = @"Get user Basic Profile";
static NSString *const kButtonWidthCellLabel = @"Width";

// Labels for the cells that drill down to data pickers.
static NSString *const kColorSchemeCellLabel = @"Color scheme";
static NSString *const kStyleCellLabel = @"Style";

// Strings for Alert Views.
static NSString *const kSignInViewTitle = @"Sign in View";
static NSString *const kSignOutAlertViewTitle = @"Warning";
static NSString *const kSignOutAlertCancelTitle = @"Cancel";
static NSString *const kSignOutAlertConfirmTitle = @"Continue";

// Accessibility Identifiers.
static NSString *const kCredentialsButtonAccessibilityIdentifier = @"Credentials";

@implementation SignInViewController {

}

#pragma mark - View lifecycle

- (void)setUp {
  // Make sure the GIDSignInButton class is linked in because references from
  // xib file doesn't count.
  [GIDSignInButton class];

  GIDSignIn *signIn = [GIDSignIn sharedInstance];
  signIn.shouldFetchBasicProfile = YES;
  signIn.delegate = self;
  signIn.presentingViewController = self;
  [GIDSignIn sharedInstance].scopes = @[ @"email" ];
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self setUp];
    self.title = kSignInViewTitle;
  }
  return self;
}

#pragma mark - GIDSignInDelegate

- (void)signIn:(GIDSignIn *)signIn
    didSignInForUser:(GIDGoogleUser *)user
           withError:(NSError *)error {
  if (error) {
    _signInAuthStatus.text = [NSString stringWithFormat:@"Status: Authentication error: %@", error];
    return;
  }

}

- (void)signIn:(GIDSignIn *)signIn
    didDisconnectWithUser:(GIDGoogleUser *)user
                withError:(NSError *)error {
  if (error) {
    _signInAuthStatus.text = [NSString stringWithFormat:@"Status: Failed to disconnect: %@", error];
  } else {
    _signInAuthStatus.text = [NSString stringWithFormat:@"Status: Disconnected"];
  }
}

- (void)presentSignInViewController:(UIViewController *)viewController {
  [[self navigationController] pushViewController:viewController animated:YES];
}

// Adjusts "Sign in", "Sign out", and "Disconnect" buttons to reflect
// the current sign-in state (ie, the "Sign in" button becomes disabled
// when a user is already signed in).
- (void)updateButtons {
  BOOL authenticated = ([GIDSignIn sharedInstance].currentUser.authentication != nil);

  self.signInButton.enabled = !authenticated;
  self.signOutButton.enabled = authenticated;
  self.disconnectButton.enabled = authenticated;
  self.credentialsButton.hidden = !authenticated;

  if (authenticated) {
    self.signInButton.alpha = 0.5;
    self.signOutButton.alpha = self.disconnectButton.alpha = 1.0;
  } else {
    self.signInButton.alpha = 1.0;
    self.signOutButton.alpha = self.disconnectButton.alpha = 0.5;
  }
}

#pragma mark - IBActions

- (IBAction)signOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
  
}

- (IBAction)disconnect:(id)sender {
  [[GIDSignIn sharedInstance] disconnect];
}

- (IBAction)checkSignIn:(id)sender {
  
}

- (void)toggleBasicProfile:(UISwitch *)sender {
  [GIDSignIn sharedInstance].shouldFetchBasicProfile = sender.on;
}

- (void)changeSignInButtonWidth:(UISlider *)sender {
  CGRect frame = self.signInButton.frame;
  frame.size.width = sender.value;
  self.signInButton.frame = frame;
}


@end
