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
   
        [self buildStage:size];
        
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    [super didMoveToView:view];
}

-(void)willMoveFromView:(SKView *)view{
    [super willMoveFromView:view];
}

//-(void)addNinja{
//    CGSize woodBaseSize = CGSizeMake(100, 100);
//    SKSpriteNode * ninja = [[SKSpriteNode alloc] initWithImageNamed:@"ninja.png"];
//    [ninja setSize: woodBaseSize];
//    ninja.position = self.pontoorigen;
//    ninja.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:woodBaseSize];
//    [self setWoodNodePropertiesTo: ninja];
//    ninja.physicsBody.affectedByGravity = YES;
//    //self.woodenBase.physicsBody.dynamic = NO;
//
//    [self addChild: ninja];
//    [self performSelector:@selector(addNinja) withObject:nil afterDelay:1];
//}

-(void)buildStage:(CGSize)size{
    [super buildStage:size];
    
    [self.edgeBottomLeft removeFromParent]; //for this stage they dont have the right properties
    self.edgeBottomLeft = nil;              // so we remote it and reset them
    [self.edgeBottomRight removeFromParent];
    self.edgeBottomRight = nil;
    
    //edge bottom
    CGSize halfscreen = CGSizeMake(size.width/2, 50);//visually understanable
    self.edgeBottomLeft = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: halfscreen];
    self.edgeBottomLeft.position = CGPointMake(self.edgeBottomLeft.size.width/2, self.edgeBottomLeft.size.height/2);
    self.edgeBottomLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: halfscreen];
    [self setEdgePropertiesTo: self.edgeBottomLeft];
    
    self.edgeBottomRight = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: halfscreen];
    self.edgeBottomRight.position = CGPointMake(size.width - self.edgeBottomRight.size.width/2, self.edgeBottomRight.size.height/2);
    self.edgeBottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: halfscreen];
    [self setEdgePropertiesTo: self.edgeBottomRight];
    
    //balls - move them to their position
    self.goldBall.physicsBody.velocity = CGVectorMake(0, 0);
    [self.goldBall setPosition: CGPointMake(70, 345.5)];
//    [self.goldBall runAction: [SKAction rotateToAngle:0 duration:0.01]];
//    [self.goldBall runAction: [SKAction moveTo: CGPointMake(70, 345.5) duration:0.01]];

    self.blueBall.physicsBody.velocity = CGVectorMake(0, 0);
    [self.blueBall setPosition: CGPointMake(324, 805)];
//    [self.blueBall runAction: [SKAction rotateToAngle:0 duration:0.01]];
//    [self.blueBall runAction: [SKAction moveTo: CGPointMake(324, 805) duration:0.01]];
  
    //making the extra elements of the stage
    CGSize woodBaseSize = CGSizeMake(size.width*4/10, 20); //visually understanable
    self.woodenBase = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: woodBaseSize];
    self.woodenBase.position = CGPointMake(size.width - self.woodenBase.size.width/2, size.height*7/10);
    self.woodenBase.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:woodBaseSize];
    [self setWoodNodePropertiesTo: self.woodenBase];
    self.woodenBase.physicsBody.dynamic = NO;
    
    CGFloat woodWidth = size.width/3;
    CGSize woodBoxSize = CGSizeMake(woodWidth, size.height/4);
    
    self.woodenBox = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: woodBoxSize];
    self.woodenBox.position = CGPointMake(self.woodenBox.size.width/2, self.woodenBox.size.height/2 + self.edgeBottomLeft.size.height);
    self.woodenBox.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: woodBoxSize];
    [self setEdgePropertiesTo: self.woodenBox];
    
    woodWidth = woodWidth*2 - 100;
    CGSize plankSize = CGSizeMake(woodWidth, 25);
    self.plank = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: plankSize];
    self.plank.position =  CGPointMake(self.plank.size.width/2,
                                       self.plank.size.height/2 + self.woodenBox.size.height + self.edgeBottomLeft.size.height);
    self.plank.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: plankSize];
    [self setWoodNodePropertiesTo: self.plank];

    
    //put all them on the screen now
    [self addChild: self.edgeBottomLeft];
    [self addChild: self.edgeBottomRight];
    
    [self addChild: [self blueBall]];
    [self addChild: [self goldBall]];
    
    [self addChild: self.woodenBase];
    [self addChild: self.woodenBox];
    [self addChild: self.plank];
}

-(void)cleanStage{
    [super cleanStage];
    
    [self.woodenBase removeFromParent];
    self.woodenBase = nil;
    
    [self.woodenBox removeFromParent];
    self.woodenBox= nil;
    
    [self.plank removeFromParent];
    self.plank = nil;
}

//-(void)resetStage{
//    [super resetStage];
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        NSLog(@"%0.1f, %0.1f", location.x, location.y);
        
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
        
        if (CGRectContainsPoint([self resetButtom].frame, location)) {
            [self resetStage];
        }
        else{
            [[self blueBall] removeAllActions];
            self.blueBall.physicsBody.velocity = CGVectorMake(0, 0);
            [[self blueBall] runAction: [SKAction moveTo:CGPointMake(location.x, location.y) duration:0.05]];
            
            UIColor *cor = [UIColor colorWithRed: (arc4random()%255)/255.0
                                           green: (arc4random()%255)/255.0
                                            blue: (arc4random()%255)/255.0
                                           alpha:1.0];
            SKSpriteNode *node = [SKSpriteNode spriteNodeWithColor: cor size: CGSizeMake(10, 10)];
            node.position = CGPointMake(location.x, location.y);
            [self addChild: node];
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
}



@end
