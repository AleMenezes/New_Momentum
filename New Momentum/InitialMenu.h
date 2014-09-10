//
//  InitialMenu.h
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 29/05/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface InitialMenu : SKScene <SKPhysicsContactDelegate, FBLoginViewDelegate>

@property SKSpriteNode *botao;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end
