//
//  InitialMenu.m
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 29/05/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "InitialMenu.h"
#import "Stage1.h"


@implementation InitialMenu

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.physicsWorld.contactDelegate = self; // TORNA A COLISAO POSIVEL!!! TINHA ESQUECIDO ISSO >.<
        
        self.backgroundColor = [SKColor colorWithRed:0.1 green:1.0 blue:0.1 alpha:1.0];
        //[SKSpriteNode spriteNodeWithImageNamed:@"icone voltar.png"]
        [self setBotao : [SKSpriteNode spriteNodeWithColor: [UIColor redColor] size:CGSizeMake(150, 100)]];
        [[self botao] setSize: CGSizeMake(150, 100)];
        [self botao].position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        [self addChild: [self botao]];
        
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 20;
        myLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:myLabel];

        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        if (CGRectContainsPoint([self botao].frame, location)) {
//        }
//    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (CGRectContainsPoint([self botao].frame, location)) {
            Stage1 * stage = [[Stage1 alloc] initWithSize:self.view.bounds.size];
            stage.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:stage transition:[SKTransition doorsOpenHorizontalWithDuration:0.7] ];
            
//            Fase1 * fase = [Fase1 sceneWithSize: self.view.bounds.size];
//            fase.scaleMode = SKSceneScaleModeAspectFill;
//            [self.view presentScene:fase transition:[SKTransition doorsOpenHorizontalWithDuration:1.5] ];
        }
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
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


@end
