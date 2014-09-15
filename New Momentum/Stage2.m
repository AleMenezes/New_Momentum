//
//  Stage2.m
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 14/08/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "Stage2.h"
#import "MascarasColisao.h"

@implementation Stage2

-(id)initWithSize:(CGSize)size {
    self = [super initWithSize:size andType:1];
    if (self) {
        self.backgroundColor = [SKColor colorWithRed:1.0 green:0.7 blue:0.5 alpha:1];
    
        
        [self setSpinner:[SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(self.size.width/4, 30)]];
        //self.spinner.size = CGSizeMake(self.size.width/4, 30);
        self.spinner.position = CGPointMake(self.spinner.size.width/2, self.size.height-self.size.height/3);
        self.spinner.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: self.spinner.size];
        [self setWoodNodePropertiesTo: self.spinner];
        self.spinner.physicsBody.density = INT32_MAX;
        self.spinner.physicsBody.affectedByGravity = NO;
        self.spinner.physicsBody.restitution = 1.0;
        

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
        CGPoint location = [touch locationInNode:self];
        
        [[self blueBall] removeAllActions];
        self.blueBall.physicsBody.velocity = CGVectorMake(0, 0);
        [[self blueBall] runAction: [SKAction moveTo:CGPointMake(location.x, location.y) duration:0.1]];
        
        
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

