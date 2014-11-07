//
//  Atributter.m
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 09/10/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "Atributter.h"

@implementation Atributter

+(void)setTargetPropertiesTo: (SKSpriteNode*)node{
    node.physicsBody.categoryBitMask = trollMask;
    node.physicsBody.contactTestBitMask = goldBallMask | blueBallMask | woodMask ;
    node.physicsBody.collisionBitMask = goldBallMask | blueBallMask | woodMask ;
    node.physicsBody.dynamic = NO;
    node.physicsBody.affectedByGravity = NO;
    node.physicsBody.allowsRotation = YES;
    node.physicsBody.density = INT32_MAX;
    node.physicsBody.restitution = 0.2;
}

+(void)setEdgePropertiesTo: (SKSpriteNode*)node{
    node.physicsBody.categoryBitMask = edgeMask;
    node.physicsBody.contactTestBitMask = goldBallMask | blueBallMask | woodMask;
    node.physicsBody.collisionBitMask = goldBallMask | blueBallMask | woodMask;
    node.physicsBody.dynamic = YES;
    node.physicsBody.affectedByGravity = NO;
    node.physicsBody.allowsRotation = YES;
    node.physicsBody.density = INT32_MAX;
    node.physicsBody.restitution = 0.75;
}

+(void)setWoodNodePropertiesTo: (SKSpriteNode*)node{
    node.physicsBody.categoryBitMask = woodMask;
    node.physicsBody.contactTestBitMask = goldBallMask | blueBallMask | edgeMask | woodMask;
    node.physicsBody.collisionBitMask = goldBallMask | blueBallMask | edgeMask | woodMask;
    node.physicsBody.dynamic = YES;
    node.physicsBody.affectedByGravity = YES;
    node.physicsBody.allowsRotation = YES;
    node.physicsBody.density = 0.8f;
    node.physicsBody.restitution = 0.75;
}

@end
