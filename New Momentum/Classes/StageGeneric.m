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
#import "InitialMenu.h"

@implementation StageGeneric

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
    }
    return self;
}

-(id)initWithSize:(CGSize)size andType:(int)number{
    if (self = [super initWithSize:size]) {
        _preferences = [NSUserDefaults standardUserDefaults];
        
        [self setStageType:number];
        
        self.physicsWorld.contactDelegate = self; // makes collision detection possible
        self.physicsWorld.gravity = CGVectorMake(0, -9.98);
        
        CGRect bodyRect = CGRectMake(0, -50, size.width, 50 + size.height);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:bodyRect];
        [self setEdgePropertiesTo: self];
        //self.name = @"bodyRect";
        
        //[self buildStage:size];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    CGSize buttomSize = CGSizeMake(50, 50);
    [self setReset: [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - buttomSize.width, 0, 50, 50)]];
    [[self reset] addTarget:self action:@selector(resetStage) forControlEvents:UIControlEventTouchDown];
    [[self reset] setBackgroundImage: [UIImage imageNamed:@"icone voltar.png"] forState: UIControlStateNormal];
    [self.view addSubview: [self reset]];
    
    [self setReturnToMenu: [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)]];
    [[self returnToMenu] addTarget:self action:@selector(backToMenu) forControlEvents:UIControlEventTouchDown];
    [[self returnToMenu] setBackgroundImage: [UIImage imageNamed:@"icone voltar.png"] forState: UIControlStateNormal];
    [self.view addSubview: [self returnToMenu]];
}

-(void)willMoveFromView:(SKView *)view{
    [[self reset] removeFromSuperview];
    [[self returnToMenu] removeFromSuperview];
}

-(void)buildStage:(CGSize)size{
    CGSize baseSize = CGSizeMake(size.width*2/5, 50);
    self.edgeBottomLeft = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: baseSize];
    self.edgeBottomLeft.position = CGPointMake(self.edgeBottomLeft.size.width/2, self.edgeBottomLeft.size.height/2);
    self.edgeBottomLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: baseSize];
    [self setEdgePropertiesTo: self.edgeBottomLeft];
    
    
    self.edgeBottomRight = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: baseSize];
    self.edgeBottomRight.position = CGPointMake(size.width - self.edgeBottomRight.size.width/2, self.edgeBottomRight.size.height/2);
    self.edgeBottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: baseSize];
    [self setEdgePropertiesTo: self.edgeBottomRight];
    
    [self setGoldBall: [BallGenerator createType:0]]; //each stage should place the balls at their own initial place
    [self setBlueBall: [BallGenerator createType:1]];
    
    [self addChild: self.edgeBottomLeft];
    [self addChild: self.edgeBottomRight];
    
//    [self addChild: [self blueBall]]; //the stage should place them after setting their position
//    [self addChild: [self goldBall]];
}

-(void)cleanStage{
    [self.edgeBottomLeft removeFromParent];
    self.edgeBottomLeft = nil;
    
    [self.edgeBottomRight removeFromParent];
    self.edgeBottomRight = nil;
    
    [[self blueBall] removeFromParent];
    self.blueBall = nil;
    
    [[self goldBall]removeFromParent];
    self.goldBall = nil;
}

-(void)resetStage{
    [self cleanStage];
    [self buildStage:self.view.bounds.size];
}

-(void)backToMenu{
    [self cleanStage];
    [self removeAllChildren];
    [self removeFromParent];
    InitialMenu* menu = [[InitialMenu alloc] initWithSize:self.view.bounds.size];
    menu.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene: menu transition:[SKTransition doorsCloseHorizontalWithDuration:0.7] ];

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

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
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

- (BOOL)shouldAutorotate{
    return NO;
}


@end
