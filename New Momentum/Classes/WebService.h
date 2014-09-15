//
//  WebService.h
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 10/09/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface WebService : NSObject

extern NSString *usuarioUniversal;

+(BOOL)check;

//testing
+(BOOL)carregarPontosUsuario: (NSString *)userID;
+(BOOL)getFacebookAchievements: (NSString *)userID;
+(BOOL)postFacebookAchievement: (NSString *)userID;

+(void)requestPermission:(NSArray*)permissionsNeeded forID:(NSString *)userID;
+(void)makeRequestForUserData;

@end
