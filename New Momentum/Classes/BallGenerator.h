//
//  BallGenerator.h
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 07/08/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "MascarasColisao.h"

@interface BallGenerator : NSObject

+(SKSpriteNode *) createType:(int)type atPosition:(CGPoint)position;

+(SKSpriteNode *) createType:(int)type;

@end
