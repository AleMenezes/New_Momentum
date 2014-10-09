//
//  Atributter.h
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 09/10/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "MascarasColisao.h"

@interface Atributter : NSObject

+(void)setTargetPropertiesTo: (SKSpriteNode*)node;
+(void)setEdgePropertiesTo: (SKSpriteNode*)node;
+(void)setWoodNodePropertiesTo: (SKSpriteNode*)node;

@end
