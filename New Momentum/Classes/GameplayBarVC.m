//
//  GameplayBarVC.m
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 10/10/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "GameplayBarVC.h"
#import <SpriteKit/SpriteKit.h>

@interface GameplayBarVC ()

@end

@implementation GameplayBarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+(NSMutableArray *)gameplayBarPreset{
    NSMutableArray *arrayButtons = [[NSMutableArray alloc] init];
    
    CGFloat x = 20;
    for (int i = 0; i < 12; i++) {

        UIButton * buttom = [[UIButton alloc] initWithFrame: CGRectMake(x, 20, 50, 50)];
        [self setImageToButtom: buttom number: i];
        [buttom setTag: i];

        x = x + 61;
        [arrayButtons addObject: buttom];
    }

    return arrayButtons;
}

+(void)setImageToButtom:(UIButton *)buttom number:(int)number{
    switch (number) {
//        case 0:
//            break;
//        case 1:
//            break;
//        case 2:
//            break;
//        case 3:
//            break;
        case 4:
            [buttom setBackgroundImage: [UIImage imageNamed:@"icone voltar.png"] forState: UIControlStateNormal];
            [buttom setBackgroundImage: [UIImage imageNamed:@"blue sphere.png"] forState: UIControlStateSelected];
            break;
        case 5:
            [buttom setBackgroundImage: [UIImage imageNamed:@"icone voltar.png"] forState: UIControlStateNormal];
            [buttom setBackgroundImage: [UIImage imageNamed:@"gold sphere.png"] forState: UIControlStateSelected];
            break;
//        case 6:
//            break;
//        case 7:
//            break;
//        case 8:
//            break;
//        case 9:
//            break;
//        case 10:
//            break;
//        case 11:
//            break;
        default:
            [buttom setBackgroundImage: [UIImage imageNamed:@"icone voltar.png"] forState: UIControlStateNormal];
            [buttom setBackgroundImage: [UIImage imageNamed:@"troll face.png"] forState: UIControlStateSelected];
            break;
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
