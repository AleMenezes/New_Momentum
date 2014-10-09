//
//  StageGeneric.m
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 08/08/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "StageGeneric.h"
#import "InitialMenu.h"
#import "Atributter.h"
#import "BallGenerator.h"
#import "MascarasColisao.h"



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
        

        CGRect bodyRect = CGRectMake(0, -100, size.width, 100 + size.height);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:bodyRect];
        [Atributter setEdgePropertiesTo: self];
        //self.name = @"bodyRect";
        
        //[self buildStage:size];
        
        
    }
    return self;
}

#pragma stage build and manipulation methods
-(void)cleanStage{
    [self.stageElements removeAllChildren];
    [self.stageElements removeAllActions];
    self.stageElements = nil;
    
    self.edgeBottomLeft = nil;
    self.edgeBottomRight = nil;
    
    self.blueBall = nil;
    self.goldBall = nil;
}

-(void)buildStage:(CGSize)size{
    //ideally load from a external file with a parameter
    self.stageElements = [[SKSpriteNode alloc] init];
    
    CGSize baseSize = CGSizeMake(size.width*2/5, 50);
    self.edgeBottomLeft = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: baseSize];
    self.edgeBottomLeft.position = CGPointMake(self.edgeBottomLeft.size.width/2, self.edgeBottomLeft.size.height/2);
    self.edgeBottomLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: baseSize];
    [Atributter setEdgePropertiesTo: self.edgeBottomLeft];
    //[self setEdgePropertiesTo: self.edgeBottomLeft];
    
    self.edgeBottomRight = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: baseSize];
    self.edgeBottomRight.position = CGPointMake(size.width - self.edgeBottomRight.size.width/2, self.edgeBottomRight.size.height/2);
    self.edgeBottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: baseSize];
    [Atributter setEdgePropertiesTo: self.edgeBottomRight];
    //[self setEdgePropertiesTo: self.edgeBottomRight];
    
    [self setGoldBall: [BallGenerator createType:0]]; //each stage should place the balls at their own initial place
    [self setBlueBall: [BallGenerator createType:1]];
    
    CGSize targetSize =  CGSizeMake(50, 50);
    self.target = [[SKSpriteNode alloc] initWithImageNamed:@"baby troll.png"];
    [self.target setSize: targetSize];
    [self.target setPhysicsBody: [SKPhysicsBody bodyWithCircleOfRadius:21]];
    [Atributter setTargetPropertiesTo: self.target];
    self.target.position = CGPointMake(610, 756);
    
    
    [self addChild: self.stageElements];
    [self.stageElements addChild: self.edgeBottomLeft];
    [self.stageElements addChild: self.edgeBottomRight];
    
//    [self addChild: [self blueBall]]; //the stage should place these after setting their position
//    [self addChild: [self goldBall]];
    
    [self.stageElements addChild: self.target];
}



#pragma UIkit elements methods if necessary
-(void)didMoveToView:(SKView *)view{
    CABasicAnimation *anime = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anime.duration = 0.01;
    anime.additive = YES;
    anime.removedOnCompletion = NO;
    anime.fillMode = kCAFillModeForwards;
    anime.toValue = [NSNumber numberWithFloat:M_PI/2];
    
    CGSize buttomSize = CGSizeMake(50, 50);
    [self setButtomReset: [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - buttomSize.width, 20, 50, 50)]];
    [[self buttomReset] addTarget:self action:@selector(resetStage) forControlEvents:UIControlEventTouchDown];
    [[self buttomReset] setBackgroundImage: [UIImage imageNamed:@"icone voltar.png"] forState: UIControlStateNormal];
    [[self buttomReset].layer addAnimation:anime forKey:nil];
    [self.view addSubview: [self buttomReset]];
    
    [self setButtomReturnToMenu: [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 50)]];
    [[self buttomReturnToMenu] addTarget:self action:@selector(backToMenu) forControlEvents:UIControlEventTouchDown];
    [[self buttomReturnToMenu] setBackgroundImage: [UIImage imageNamed:@"icone voltar.png"] forState: UIControlStateNormal];
    [self.view addSubview: [self buttomReturnToMenu]];
}

-(void)willMoveFromView:(SKView *)view{
    [[self buttomReset] removeFromSuperview];
    [[self buttomReturnToMenu] removeFromSuperview];
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

#pragma touch methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}

#pragma colision method
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
    
    if ( (firstBody.categoryBitMask == goldBallMask && secondBody.categoryBitMask == trollMask) ||
         (firstBody.categoryBitMask == trollMask && secondBody.categoryBitMask == goldBallMask) ) {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"troll alimentado!" message:@"culpa do viera" delegate:self cancelButtonTitle:@"daora" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
    
}

- (BOOL)shouldAutorotate{
    return NO;
}


@end
