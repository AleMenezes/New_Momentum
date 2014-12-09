//
//  Stage1.m
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 08/08/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "Stage1.h"
#import "Atributter.h"
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
    [super didMoveToView:view]; //necessary else the buttoms wont appear
}

-(void)willMoveFromView:(SKView *)view{
    [super willMoveFromView:view];
}


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
    [Atributter setEdgePropertiesTo: self.edgeBottomLeft];
    
    self.edgeBottomRight = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: halfscreen];
    self.edgeBottomRight.position = CGPointMake(size.width - self.edgeBottomRight.size.width/2, self.edgeBottomRight.size.height/2);
    self.edgeBottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: halfscreen];
    [Atributter setEdgePropertiesTo: self.edgeBottomRight];
    
    //balls - move them to their position
    self.goldBall.physicsBody.velocity = CGVectorMake(0, 0);
    [self.goldBall setPosition: CGPointMake(70, 345.5)];

    self.blueBall.physicsBody.velocity = CGVectorMake(0, 0);
    [self.blueBall setPosition: CGPointMake(324, 805)];
    
    self.target = [SKSpriteNode spriteNodeWithImageNamed:@"baby troll.png"];
    [self.target setSize: CGSizeMake(50, 50)];
    self.target.physicsBody =[SKPhysicsBody bodyWithCircleOfRadius:50] ;
    self.target.position = CGPointMake(610, 766);
    [Atributter setTargetPropertiesTo: self.target];
  
    
    //making the extra elements of the stage
    CGSize woodBaseSize = CGSizeMake(size.width*4/10, 20); //visually understanable
    self.woodenBase = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: woodBaseSize];
    self.woodenBase.position = CGPointMake(size.width - self.woodenBase.size.width/2, size.height*7/10);
    self.woodenBase.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:woodBaseSize];
    [Atributter setWoodNodePropertiesTo: self.woodenBase];
    self.woodenBase.physicsBody.dynamic = NO;
    
    CGFloat woodWidth = size.width/3;
    CGSize woodBoxSize = CGSizeMake(woodWidth, size.height/4);
    
    self.woodenBox = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: woodBoxSize];
    self.woodenBox.position = CGPointMake(self.woodenBox.size.width/2, self.woodenBox.size.height/2 + self.edgeBottomLeft.size.height);
    self.woodenBox.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: woodBoxSize];
    [Atributter setEdgePropertiesTo: self.woodenBox];
    
    woodWidth = woodWidth*2 - 100;
    CGSize plankSize = CGSizeMake(woodWidth, 25);
    self.plank = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: plankSize];
    self.plank.position =  CGPointMake(self.plank.size.width/2,
                                       self.plank.size.height/2 + self.woodenBox.size.height + self.edgeBottomLeft.size.height);
    self.plank.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: plankSize];
    [Atributter setWoodNodePropertiesTo: self.plank];

    
    //put all them on the screen now
    [self.stageElements addChild: self.edgeBottomLeft];
    [self.stageElements addChild: self.edgeBottomRight];
    
    [self.stageElements addChild: [self blueBall]];
    [self.stageElements addChild: [self goldBall]];
    
    [self.stageElements addChild: self.woodenBase];
    [self.stageElements addChild: self.woodenBox];
    [self.stageElements addChild: self.plank];
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


#pragma touch methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan: touches withEvent: event];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved: touches withEvent: event];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:  touches withEvent: event];

}

-(void) didBeginContact:(SKPhysicsContact *)contact{
    [super didBeginContact: contact];
    
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

-(NSMutableArray*)loadSpriteSheetFromImageWithName:(NSString*)name withNumberOfSprites:(int)numSprites withNumberOfRows:(int)numRows withNumberOfSpritesPerRow:(int)numSpritesPerRow{
    
    NSMutableArray* animationSheet = [super loadSpriteSheetFromImageWithName: name
                                                         withNumberOfSprites: numSprites
                                                            withNumberOfRows: numRows
                                                   withNumberOfSpritesPerRow: numSpritesPerRow];
    return animationSheet;
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

@end
