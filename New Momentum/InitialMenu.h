//
//  InitialMenu.h
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 29/05/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "WebService.h"
#import "Stage1.h"


@interface InitialMenu : SKScene <SKPhysicsContactDelegate, FBLoginViewDelegate>

@property NSUserDefaults *preferences;

@property SKSpriteNode *botao;


@property UIButton * face;
@property UIButton * face2;

@property FBLoginView *loginView;
@property FBProfilePictureView *profilePictureView;
@property NSString *userID;

@property UILabel *nameLabel;
@property UILabel *statusLabel;

@end
