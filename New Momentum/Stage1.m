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
        
        self.EdgeBottom = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: CGSizeMake(size.width*2/5, 50)];
        [self.edgeBottom setPhysicsBody: [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(size.width*2/5, 50)]];
        self.edgeBottom.position = CGPointMake(self.edgeBottom.size.width/2, self.edgeBottom.size.height/2);
        self.edgeBottom.physicsBody.categoryBitMask = woodMask;
        self.edgeBottom.physicsBody.contactTestBitMask = goldBallMask | blueBallMask;
        self.edgeBottom.physicsBody.collisionBitMask = goldBallMask | blueBallMask;;
        self.edgeBottom.physicsBody.dynamic = NO;
        self.edgeBottom.physicsBody.affectedByGravity = NO;
        self.edgeBottom.physicsBody.allowsRotation = NO;
        
        self.edgeBottom2 = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: CGSizeMake(size.width*2/5, 50)];
        [self.edgeBottom2 setPhysicsBody: [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(size.width*2/5, 50)]];
        self.edgeBottom2.position = CGPointMake(size.width - self.edgeBottom2.size.width/2, self.edgeBottom2.size.height/2);
        self.edgeBottom2.physicsBody.categoryBitMask = woodMask;
        self.edgeBottom2.physicsBody.contactTestBitMask = goldBallMask | blueBallMask;
        self.edgeBottom2.physicsBody.collisionBitMask = goldBallMask | blueBallMask;;
        self.edgeBottom2.physicsBody.dynamic = NO;
        self.edgeBottom2.physicsBody.affectedByGravity = NO;
        self.edgeBottom2.physicsBody.allowsRotation = NO;
        [self addChild: self.edgeBottom2];
        
        
        [self setSpinner:[SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(self.size.width/4,30)]];
        //self.spinner.size = CGSizeMake(self.size.width/4,30);
        self.spinner.position = CGPointMake(self.spinner.size.width/2, self.size.height-self.size.height/3);
        self.spinner.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: self.spinner.size];
        self.spinner.physicsBody.density = INT64_MAX;
        self.spinner.physicsBody.dynamic = YES;
        self.spinner.physicsBody.allowsRotation = YES;
        self.spinner.physicsBody.affectedByGravity = NO;
        self.spinner.physicsBody.categoryBitMask = woodMask;
        self.spinner.physicsBody.contactTestBitMask = goldBallMask | blueBallMask;
        self.spinner.physicsBody.collisionBitMask =  goldBallMask | blueBallMask;
        
        
        
        
        [self addChild: self.spinner];
        [self performSelector:@selector(spinnerAction) withObject:nil afterDelay:0.7];
    }
    return self;
}

-(void)spinnerAction{
    SKAction *spin = [SKAction rotateByAngle: -M_PI duration:0.4];
    [self.spinner runAction:spin];
    [self performSelector:@selector(spinnerAction) withObject:nil afterDelay:0.4];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        SKAction *gira= [SKAction rotateByAngle:M_PI duration:0.3];
        
        CGPoint location = [touch locationInNode:self];
        if (CGRectContainsPoint([self goldBall].frame, location)) {
            [[self goldBall] runAction: gira];
        }
        
        if (CGRectContainsPoint([self blueBall].frame, location)) {
            [[self blueBall] runAction: gira];
        }

        if (CGRectContainsPoint([self edgeBottom].frame, location)) {
            [[self edgeBottom] runAction: gira];

        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
    }
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
