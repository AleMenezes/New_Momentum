//
//  selfGenerator.m
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 07/08/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "BallGenerator.h"

@implementation BallGenerator

-(id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

+(SKSpriteNode *)initWithtype:(int)type atPosition:(CGPoint)position{
    SKSpriteNode *ball;
    switch (type) {
        case 0:
            ball =[[SKSpriteNode alloc] initWithImageNamed:@"gold sphere.png"];
            [ball setSize:CGSizeMake(30, 30)];
            [ball setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:12]];
            ball.physicsBody.density = 1.0f;
            ball.physicsBody.restitution = 0.8;
            ball.physicsBody.categoryBitMask = goldBallMask;
            ball.physicsBody.contactTestBitMask = blueBallMask | woodMask;
            ball.physicsBody.collisionBitMask = blueBallMask | woodMask;
            break;
        case 1:
            ball =[[SKSpriteNode alloc] initWithImageNamed:@"blue sphere.png"];
            [ball setSize:CGSizeMake(30, 30)];
            [ball setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:12]];
            ball.physicsBody.density = 19.0f;
            ball.physicsBody.restitution = 0.5;
            ball.physicsBody.categoryBitMask = blueBallMask;
            ball.physicsBody.contactTestBitMask = goldBallMask | woodMask;
            ball.physicsBody.collisionBitMask =  goldBallMask | woodMask;
            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }

    [ball setPosition:position];
    ball.physicsBody.dynamic = YES;
    ball.physicsBody.affectedByGravity = YES;
    ball.physicsBody.allowsRotation = YES;
    
    return ball;
}


@end
