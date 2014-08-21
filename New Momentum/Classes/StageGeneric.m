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
        self.physicsWorld.contactDelegate = self; // makes collision detection possible
        self.physicsWorld.gravity = CGVectorMake(0, -9.98);
        
        CGRect bodyRect = CGRectMake(0, -50, size.width, 50 + size.height);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:bodyRect];
        [self setEdgePropertiesTo: self];
        //self.name = @"bodyRect";
        
        CGSize baseSize = CGSizeMake(size.width*2/5, 50);
        self.edgeBottomLeft = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: baseSize];
        self.edgeBottomLeft.position = CGPointMake(self.edgeBottomLeft.size.width/2, self.edgeBottomLeft.size.height/2);
        self.edgeBottomLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: baseSize];
        [self setEdgePropertiesTo: self.edgeBottomLeft];

        self.edgeBottomRight = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: baseSize];
        self.edgeBottomRight.position = CGPointMake(size.width - self.edgeBottomRight.size.width/2, self.edgeBottomRight.size.height/2);
        self.edgeBottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: baseSize];
        [self setEdgePropertiesTo: self.edgeBottomRight];
        
        
        CGSize buttomSize = CGSizeMake(75, 75);
        [self setResetButtom: [SKSpriteNode spriteNodeWithColor: [UIColor redColor] size:buttomSize]];
        [[self resetButtom] setSize: buttomSize];
        [self resetButtom].position = CGPointMake(self.frame.size.width - buttomSize.width/2, self.frame.size.height - buttomSize.height/2);
        
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = @"reset";
        myLabel.fontSize = 15;
        myLabel.position = CGPointMake(self.frame.size.width - buttomSize.width/2, self.frame.size.height - buttomSize.height/2);
        
        
        
        CGPoint ponto = CGPointMake(70, 345.5);
        CGPoint centro = CGPointMake(324, 805);
        switch (number) {
            case 1:
                [self setGoldBall: [BallGenerator createType:0 atPosition: ponto]];
                centro.y = centro.y + 50;
                [self setBlueBall: [BallGenerator createType:1 atPosition: centro]];
                break;
            case 2:
                [self setGoldBall: [BallGenerator createType:0 atPosition: centro]];
                centro.x = centro.x + 200;
                centro.y = centro.y + 100;
                [self setBlueBall: [BallGenerator createType:1 atPosition: centro]];
                break;
            case 3:
                break;
            case 4:
                break;
                
            default:
                break;
        }
        
        
        [self addChild: self.edgeBottomLeft];
        [self addChild: self.edgeBottomRight];
        
        [self addChild: [self resetButtom]];
        [self addChild:myLabel];
        
        [self addChild: [self blueBall]];
        [self addChild: [self goldBall]];
    }
    return self;
}

-(void)setEdgePropertiesTo: (SKSpriteNode*)node{
    node.physicsBody.categoryBitMask = edgeMask;
    node.physicsBody.contactTestBitMask = goldBallMask | blueBallMask | woodMask;
    node.physicsBody.collisionBitMask = goldBallMask | blueBallMask | woodMask;
    node.physicsBody.dynamic = NO;
    node.physicsBody.affectedByGravity = NO;
    node.physicsBody.allowsRotation = NO;
    node.physicsBody.density = INT32_MAX;
    node.physicsBody.restitution = 0.75;
}

-(void)setWoodNodePropertiesTo: (SKSpriteNode*)node{
    node.physicsBody.categoryBitMask = woodMask;
    node.physicsBody.contactTestBitMask = goldBallMask | blueBallMask | edgeMask | woodMask;
    node.physicsBody.collisionBitMask = goldBallMask | blueBallMask | edgeMask | woodMask;
    node.physicsBody.dynamic = YES;
    node.physicsBody.affectedByGravity = YES;
    node.physicsBody.allowsRotation = YES;
    node.physicsBody.density = 0.8f;
    node.physicsBody.restitution = 0.75;
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
