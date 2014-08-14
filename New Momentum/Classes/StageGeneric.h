//
//  StageGeneric.h
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 08/08/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface StageGeneric : SKScene  <SKPhysicsContactDelegate>

@property SKSpriteNode *edgeBottomLeft;
@property SKSpriteNode *edgeBottomRight;
@property SKSpriteNode *goldBall;
@property SKSpriteNode *blueBall;

-(id)initWithSize:(CGSize)size andType:(int)number;

@end
