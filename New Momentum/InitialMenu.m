//
//  InitialMenu.m
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 29/05/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "InitialMenu.h"
#import "Stage1.h"


@implementation InitialMenu

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        _preferences = [NSUserDefaults standardUserDefaults];
        
        self.physicsWorld.contactDelegate = self;  // makes collision detection possible
        self.backgroundColor = [SKColor colorWithRed:0.1 green:1.0 blue:0.1 alpha:1.0];

        [self setBotao : [SKSpriteNode spriteNodeWithColor: [UIColor redColor] size:CGSizeMake(150, 100)]];
        [[self botao] setSize: CGSizeMake(150, 100)];
        [self botao].position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        [self addChild: [self botao]];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 20;
        myLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:myLabel];
        
    }
    return self;
}

    //[WebService requestPermission:@[@"user_games_activity", @"friends_games_activity", @"publish_actions"] forID: _userID];
/**
 *  method used to place regular UIkit elements that can't be placed on a SKScene directly
 *
 *  @param view its the SKScene
 */
-(void)didMoveToView:(SKView *)view{
    _loginView = [[FBLoginView alloc] initWithReadPermissions: @[@"public_profile", @"user_friends",@"user_games_activity", @"friends_games_activity", @"publish_actions", @"user_events"]];
    _loginView.delegate = self;
    _loginView.frame = CGRectOffset(_loginView.frame, (self.view.center.x - (_loginView.frame.size.width / 2)), 5);
    [self.view addSubview:_loginView];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.frame = CGRectMake(30, 50, self.view.frame.size.width, 30);
    [self.view addSubview: _statusLabel];
    
    _profilePictureView = [[FBProfilePictureView alloc] init];
    _profilePictureView.frame = CGRectMake(30, 80, 50, 50);
    [self.view addSubview: _profilePictureView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(30, 140, self.view.frame.size.width, 30);
    [self.view addSubview: _nameLabel];
    
    UIButton * face = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x*1.75, self.view.center.y, 100, 100)];
    [face addTarget:self action:@selector(botaozin) forControlEvents:UIControlEventTouchDown];
    [face setBackgroundImage: [UIImage imageNamed:@"icone voltar.png"] forState: UIControlStateNormal];
    
    [self.view addSubview: face];
}

-(void)botaozin{
    if ([WebService pegaAchievementsNoFace:self.userID]) {
        NSLog(@"jfuncionaaa woo");
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

 //    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        if (CGRectContainsPoint([self botao].frame, location)) {
//        }
//    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (CGRectContainsPoint([self botao].frame, location)) {
            Stage1 * stage = [[Stage1 alloc] initWithSize:self.view.bounds.size];
            stage.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:stage transition:[SKTransition doorsOpenHorizontalWithDuration:0.7] ];
        }
    }
}

-(void) didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else{
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}



//-// Facebook login delegate methods //-//
// This method will be called when the user information has been fetched from facebook
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = user.id;
    self.nameLabel.text = user.name;
    [self setUserID: user.id];
}
// Logged-in from facebook user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
}
// Logged-out from facebook user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged in!";
}

// Handle possible errors that can occur during facebook login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

@end
