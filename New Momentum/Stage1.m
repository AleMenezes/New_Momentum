//
//  Stage1.m
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 08/08/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "Stage1.h"
#import "MascarasColisao.h"

@implementation Stage1

-(id)initWithSize:(CGSize)size {
    self = [super initWithSize:size andType:1];
    if (self) {
        self.backgroundColor = [SKColor colorWithRed:1.0 green:0.5 blue:0.1 alpha:1];
   
        [self.edgeBottomLeft removeFromParent];
        self.edgeBottomLeft = nil;
        [self.edgeBottomRight removeFromParent];
        self.edgeBottomRight = nil;
        
        CGSize halfscreen = CGSizeMake(size.width/2, 50);//visually understanable
        self.edgeBottomLeft = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: halfscreen];
        self.edgeBottomLeft.position = CGPointMake(self.edgeBottomLeft.size.width/2, self.edgeBottomLeft.size.height/2);
        self.edgeBottomLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: halfscreen];
        [self setEdgePropertiesTo: self.edgeBottomLeft];
        
        self.edgeBottomRight = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: halfscreen];
        self.edgeBottomRight.position = CGPointMake(size.width - self.edgeBottomRight.size.width/2, self.edgeBottomRight.size.height/2);
        self.edgeBottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: halfscreen];
        [self setEdgePropertiesTo: self.edgeBottomRight];
        
        CGSize woodBaseSize = CGSizeMake(size.width*4/10, 20); //visually understanable
        self.woodenBase = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: woodBaseSize];
        self.woodenBase.position = CGPointMake(size.width - self.woodenBase.size.width/2, size.height*7/10);
        self.woodenBase.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:woodBaseSize];
        [self setWoodNodePropertiesTo: self.woodenBase];
        self.woodenBase.physicsBody.affectedByGravity = YES;
        self.woodenBase.physicsBody.dynamic = NO;
 
        
        [self addChild: self.edgeBottomLeft];
        [self addChild: self.edgeBottomRight];
        
        [self addChild: self.woodenBase];

    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        [[self blueBall] removeAllActions];
        self.blueBall.physicsBody.velocity = CGVectorMake(0, 0);
        [[self blueBall] runAction: [SKAction moveTo:CGPointMake(location.x, location.y) duration:0.05]];
        
        SKAction *gira= [SKAction rotateByAngle:M_PI duration:0.3];
        if (CGRectContainsPoint([self goldBall].frame, location)) {
            [[self goldBall] runAction: gira];
        }
        
        if (CGRectContainsPoint([self blueBall].frame, location)) {
            [[self blueBall] runAction: gira];
        }

        if (CGRectContainsPoint([self edgeBottomRight].frame, location)) {
            [[self edgeBottomRight] runAction: gira];
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//    }
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
    NSLog(@"oi");
}



@end
