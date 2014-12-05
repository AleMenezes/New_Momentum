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
#import "GameplayBarVC.h"


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
        //self.physicsWorld.gravity = CGVectorMake(0, -9.98);
        self.physicsWorld.gravity = CGVectorMake(0, 0);

        
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
    [self.stageElements removeFromParent];
    [self.stageElements removeAllActions];
    [self.stageElements removeAllChildren];
    self.stageElements = nil;
    
    self.edgeBottomLeft = nil;
    self.edgeBottomRight = nil;
    
    self.blueBall = nil;
    self.goldBall = nil;
}

-(void)buildStage:(CGSize)size{
    //ideally load from a external file with a parameter
    self.stageElements = [[SKSpriteNode alloc] init];
    self.targetGotHit = NO;
    
    CGSize baseSize = CGSizeMake(size.width*2/5, 50);
    self.edgeBottomLeft = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: baseSize];
    self.edgeBottomLeft.position = CGPointMake(self.edgeBottomLeft.size.width/2, self.edgeBottomLeft.size.height/2);
    self.edgeBottomLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: baseSize];
    [Atributter setEdgePropertiesTo: self.edgeBottomLeft];
    
    self.edgeBottomRight = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size: baseSize];
    self.edgeBottomRight.position = CGPointMake(size.width - self.edgeBottomRight.size.width/2, self.edgeBottomRight.size.height/2);
    self.edgeBottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: baseSize];
    [Atributter setEdgePropertiesTo: self.edgeBottomRight];
    
    [self setGoldBall: [BallGenerator createType:0]]; //each stage should place the balls at their own initial place
    [self setBlueBall: [BallGenerator createType:1]];
    
    CGSize targetSize =  CGSizeMake(50, 50);
    self.target = [SKSpriteNode spriteNodeWithImageNamed:@"baby troll.png"];
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
    self.buttonsArray = [GameplayBarVC gameplayBarPreset];
    
    for (UIButton * botao in self.buttonsArray) {
        [self setSelectorTo: botao];
    }
    
    //remove from the array the buttons that have an independent toggle
    //done from highest index to lower, else it will bug =x, couldnt think of a better solution for the independent toggles
    [self.buttonsArray removeObjectAtIndex: 11];
    
    [self.buttonsArray removeObjectAtIndex: 3];
    
    [self.buttonsArray removeObjectAtIndex: 0];
}

-(void)willMoveFromView:(SKView *)view{
    
//    [[self buttomReset] removeFromSuperview];
//    [[self buttomReturnToMenu] removeFromSuperview];
    
}

-(void)setSelectorTo:(UIButton*)buttom{
    switch ([buttom tag]) {
        case 0:{
            [buttom addTarget:self action:@selector(backToMenu) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview: buttom];
            break;
        }
        case 1:{
            break;
        }
        case 2:{
            break;
        }
        case 3:{
            [buttom addTarget:self action:@selector(toggleGravity:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview: buttom];
            break;
        }
        case 11:{
            CABasicAnimation *anime = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            anime.duration = 0.001;
            anime.additive = YES;
            anime.removedOnCompletion = NO;
            anime.fillMode = kCAFillModeForwards;
            anime.toValue = [NSNumber numberWithFloat:M_PI/2];
            [buttom.layer addAnimation:anime forKey:nil];
            
            [buttom addTarget:self action:@selector(resetStage) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview: buttom];
            break;
        }
        default:{
            [buttom addTarget: self action: @selector(buttomPressed:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview: buttom];
            break;
        }
    }
}


-(void)toggleGravity:(id)sender{
    UIButton *b = (UIButton *)sender;
    b.selected = !b.selected;
    if (b.selected) {
        self.physicsWorld.gravity = CGVectorMake(0, -9.98);
    }
    else{
        self.physicsWorld.gravity = CGVectorMake(0, 0);
    }
}

-(void)buttomPressed:(id)sender{
   //continua aki +/-
    UIButton *b = (UIButton *)sender;
    self.selectedButtomTag = (int)b.tag;
    

    for (UIButton * botao in self.buttonsArray) {
        if (botao != b) {
            botao.selected = NO;
        }
        else{
            botao.selected = YES;
        }
    }
}

-(void)backToMenu{
    for (UIButton * view in [self.view subviews]) {
        [view removeFromSuperview];
    }
    
    [self cleanStage];
    [self removeAllChildren];
    [self removeFromParent];
    InitialMenu* menu = [[InitialMenu alloc] initWithSize:self.view.bounds.size];
    menu.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene: menu transition:[SKTransition doorsCloseHorizontalWithDuration:0.7] ];
}

-(void)resetStage{
    [self cleanStage];
    [self buildStage: self.view.bounds.size];
    
    for (UIButton * botao in [self.view subviews]) {
        if ([botao isKindOfClass: [UIButton class]] && (int)botao.tag == 3) {
            botao.selected = NO;
            self.physicsWorld.gravity = CGVectorMake(0, 0);
        }
    }
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

#pragma colision methods
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
        if ( !self.targetGotHit) {
            self.targetGotHit = YES;
            
            self.frameCoordinates = [self loadSpriteSheetFromImageWithName:@"sprites troll.png" withNumberOfSprites:2 withNumberOfRows:1 withNumberOfSpritesPerRow:2];
            SKAction* targetAction = [SKAction animateWithTextures:self.frameCoordinates timePerFrame:0.5f];
            [self.target runAction:targetAction];
            
            self.frameCoordinates = nil;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"troll alimentado!" message:@"culpa do viera" delegate:self cancelButtonTitle:@"daora" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
        }
    }
}

-(NSMutableArray*)loadSpriteSheetFromImageWithName:(NSString*)name withNumberOfSprites:(int)numSprites withNumberOfRows:(int)numRows withNumberOfSpritesPerRow:(int)numSpritesPerRow{
    
    NSMutableArray* animationSheet = [NSMutableArray array];
    
    SKTexture* mainTexture = [SKTexture textureWithImageNamed:name];
    
    for(int i = numRows-1; i >= 0;i--){
        for(int j = 0;j < numSpritesPerRow;j++){
            SKTexture* part = [SKTexture textureWithRect:CGRectMake(j*(1.0f/numSpritesPerRow), i*(1.0f/numRows), 1.0f/numSpritesPerRow, 1.0f/numRows) inTexture:mainTexture];
            
            [animationSheet addObject:part];
            
            if(animationSheet.count == numSprites)
                break;
        }
        if(animationSheet.count == numSprites)
            break;
    }
    return animationSheet;
}


- (BOOL)shouldAutorotate{
    return NO;
}

@end
