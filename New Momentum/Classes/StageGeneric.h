//
//  StageGeneric.h
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 08/08/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define rgb(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface StageGeneric : SKScene  <SKPhysicsContactDelegate>

@property NSUserDefaults *preferences;

@property int stageType;
@property SKSpriteNode *edgeBottomLeft;
@property SKSpriteNode *edgeBottomRight;
@property SKSpriteNode *goldBall;
@property SKSpriteNode *blueBall;
@property SKSpriteNode *target;

@property UIButton *reset;
@property UIButton *returnToMenu;

-(id)initWithSize:(CGSize)size andType:(int)number;
-(void)setEdgePropertiesTo: (SKSpriteNode*)node;
-(void)setWoodNodePropertiesTo: (SKSpriteNode*)node;

-(void)buildStage:(CGSize)size;
-(void)cleanStage;
-(void)resetStage;

@end
