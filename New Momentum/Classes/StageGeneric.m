//
//  StageGeneric.m
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 08/08/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "StageGeneric.h"
#import "MascarasColisao.h"
#import "BallGenerator.h"

@implementation StageGeneric


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
    }
    return self;
}

-(id)initWithSize:(CGSize)size andType:(int)number{
    if (self = [super initWithSize:size]) {
        self.physicsWorld.contactDelegate = self; // TORNA A COLISAO POSIVEL!!! TINHA ESQUECIDO ISSO >.<
        self.physicsWorld.gravity = CGVectorMake(0, -9.98);
        
//        CGRect bodyRect = CGRectMake(0,self.edgeBottom.size.height, size.width, size.height-((45 + [UIApplication sharedApplication].statusBarFrame.size.height)*2));
        CGRect bodyRect = CGRectMake(0, 0, size.width, size.height);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:bodyRect];
        self.physicsBody.categoryBitMask = edgeMask;
        self.physicsBody.contactTestBitMask = goldBallMask;
        self.physicsBody.collisionBitMask = goldBallMask;
        self.name = @"bodyRect";
        
        CGSize baseSize = CGSizeMake(size.width*2/5, 50);
        
        self.edgeBottomLeft = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: baseSize];
        self.edgeBottomLeft.position = CGPointMake(self.edgeBottomLeft.size.width/2, self.edgeBottomLeft.size.height/2);
        self.edgeBottomLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: baseSize];

        self.edgeBottomRight = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: baseSize];
        self.edgeBottomRight.position = CGPointMake(size.width - self.edgeBottomRight.size.width/2, self.edgeBottomRight.size.height/2);
        self.edgeBottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: baseSize];
        
        CGPoint centro = CGPointMake(size.width/2, size.height/2);
        switch (number) {
            case 1:
                [self setGoldBall: [BallGenerator initWithtype:0 atPosition: centro]];
                centro.y = centro.y + 50;
                [self setBlueBall: [BallGenerator initWithtype:1 atPosition: centro]];
                break;
            case 2:
                [self setGoldBall: [BallGenerator initWithtype:0 atPosition: centro]];
                centro.x = centro.x + 200;
                centro.y = centro.y + 100;
                [self setBlueBall: [BallGenerator initWithtype:1 atPosition: centro]];
                break;
            case 3:
                break;
            case 4:
                break;
                
            default:
                break;
        }
        self.edgeBottomLeft.physicsBody.categoryBitMask = woodMask;
        self.edgeBottomLeft.physicsBody.contactTestBitMask = goldBallMask | blueBallMask;
        self.edgeBottomLeft.physicsBody.collisionBitMask = goldBallMask | blueBallMask;;
        self.edgeBottomLeft.physicsBody.dynamic = NO;
        self.edgeBottomLeft.physicsBody.affectedByGravity = NO;
        self.edgeBottomLeft.physicsBody.allowsRotation = NO;
        
        self.edgeBottomRight.physicsBody.categoryBitMask = woodMask;
        self.edgeBottomRight.physicsBody.contactTestBitMask = goldBallMask | blueBallMask;
        self.edgeBottomRight.physicsBody.collisionBitMask = goldBallMask | blueBallMask;;
        self.edgeBottomRight.physicsBody.dynamic = NO;
        self.edgeBottomRight.physicsBody.affectedByGravity = NO;
        self.edgeBottomRight.physicsBody.allowsRotation = NO;
        
        [self addChild: self.edgeBottomLeft];
        [self addChild: self.edgeBottomRight];
        
        [self addChild: [self blueBall]];
        [self addChild: [self goldBall]];
    }
    return self;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//    }
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
}

@end
