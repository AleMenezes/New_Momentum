//
//  WebService.m
//  New Momentum
//
//  Created by Alessandro Camillo Gimenez de Menezes on 10/09/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "WebService.h"
#import "Reachability.h"

@implementation WebService

+(BOOL)check{
    // Allocate a reachability object
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable){
        return NO;
    }
    else{
        return YES;
    }
}

+(BOOL)carregarPontosUsuario: (NSString *)userID{
    if ([self check]){
        NSString *url =  @"graph.facebook.com";
        NSString *post = [NSString stringWithFormat:@"/%@/", userID];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: url]];
        [request setHTTPMethod: @"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody: postData ];
        
        NSURLResponse *response;
        NSError *err;
        NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
        
        //se precisar de um json maneiro
        NSError* error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:returnData //1
                              
                              options:kNilOptions
                              error:&error];
        //return json;
        NSLog(@"%@",json);
//        NSUserDefaults *preferencias = [NSUserDefaults standardUserDefaults];
//        if (preferencias) {
//            [preferencias setObject:userID forKey:@"userName"];
//            [preferencias setInteger: [[json valueForKey:@"metal"] intValue] forKey:@"qteMetal"];
//            [preferencias synchronize];
//        }
//        else{
//            return NO;
//        }
        return YES;
    }
    return NO;
}

+(BOOL)testedefault{
    if ([self check]){
        
        return YES;
    }
    return NO;
}


+(BOOL)teste{
    if ([self check]){
        NSMutableDictionary<FBGraphObject> *action = [FBGraphObject graphObject];
        action[@"metal"] = @"http://samples.ogp.me/719481568100795";
        
        [FBRequestConnection startForPostWithGraphPath:@"me/new_momentum:recycle"
                                           graphObject:action
                                     completionHandler:^(FBRequestConnection *connection,
                                                         id result,
                                                         NSError *error) {
                                         // handle the result
                                         NSLog(@"%@",result);
                                     }];
        return YES;
    }
    return NO;
}

+(BOOL)teste2{
    if ([self check]){
        [FBRequestConnection startWithGraphPath:@"me/new_momentum:recycle"
                              completionHandler:^(FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error) {
                                  // handle the result
                                  NSLog(@"%@",result);
                              }];
        return YES;
    }
    return NO;
}

+(BOOL)getScore{
    if ([self check]){
        /* make the API call */
        [FBRequestConnection startWithGraphPath:@"/me/scores"
                                     parameters:nil
                                     HTTPMethod:@"GET"
                              completionHandler:^(
                                                  FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error
                                                  ) {
                                  /* handle the result */
                                  NSLog(@"%@",result);
                              }];
        return YES;
    }
    return NO;
}

+(BOOL)setScore{
    
    if ([self check]){
        /* make the API call */
        NSString *string = [NSString stringWithFormat:@"%d", arc4random()%10000];
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                string, @"score",
                                nil
                                ];
        /* make the API call */
        [FBRequestConnection startWithGraphPath:@"/me/scores"
                                     parameters:params
                                     HTTPMethod:@"POST"
                              completionHandler:^(
                                                  FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error
                                                  ) {
                                  /* handle the result */
                                  NSLog(@"%@",result);
                              }];
        return YES;
    }
    return NO;
}

#pragma mark Facebook related methods
//      graphs api testing        //

+(BOOL)getInfoUser: (NSString *)userID{ 
    if ([self check]){
        /* make the API call */
        [FBRequestConnection startWithGraphPath:@"/me"
                                     parameters:nil
                                     HTTPMethod:@"GET"
                              completionHandler:^(
                                                  FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error
                                                  ) {
                                  /* handle the result */
                                  //NSLog(@"%@",result);
                              }];
        return YES;
    }
    return NO;
}


/**
 *  for learning, not a priority
 *
 *  @param userID Facebook id of the user
 *
 *  @return boolean
 */
+(BOOL)getFacebookAchievements: (NSString *)userID{
    if ([self check]){
        [FBRequestConnection startWithGraphPath:[NSString stringWithFormat:@"/%@/achievements",userID]
                                     parameters:nil
                                     HTTPMethod:@"GET"
                              completionHandler:^(
                                                  FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error
                                                  ) {
                                  /* handle the result */
                                  //NSLog(@"%@",result);
                              }];
        return YES;
    }
    return NO;
}

/**
 *  for learning, not a priority
 *
 *  @param userID Facebook id of the user
 *
 *  @return boolean
 */
+(BOOL)postFacebookAchievement: (NSString *)userID{
    if ([self check]){
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"{url-of-achievement-type}", @"achievement",
                                nil
                                ];
        /* make the API call */
        [FBRequestConnection startWithGraphPath:@"/me/achievements"
                                     parameters:params
                                     HTTPMethod:@"POST"
                              completionHandler:^(
                                                  FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error
                                                  ) {
                                  /* handle the result */
                              }];
        return YES;
    }
    return NO;
}



/**
 *  placeholder for future implementation, not using it for now
 *
 *  @param permissionsNeeded
 *  @param userID
 */
+(void)requestPermission:(NSArray*)permissionsNeeded forID:(NSString *)userID{
    // @"user_games_activity", @"friends_games_activity", @"publish_actions"
    //NSArray *permissionsNeeded = @[@"basic_info", @"user_birthday"];
    
    // Request the permissions the user currently has
    [FBRequestConnection startWithGraphPath: [NSString stringWithFormat:@"/%@/permissions",userID]
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error){
                                  // These are the current permissions the user has:
                                  NSDictionary *currentPermissions= [(NSArray *)[result data] objectAtIndex:0];
                                  
                                  // We will store here the missing permissions that we will have to request
                                  NSMutableArray *requestPermissions = [[NSMutableArray alloc] initWithArray:@[]];
                                  
                                  // Check if all the permissions we need are present in the user's current permissions
                                  // If they are not present add them to the permissions to be requested
                                  for (NSString *permission in permissionsNeeded){
                                      if (![currentPermissions objectForKey:permission]){
                                          [requestPermissions addObject:permission];
                                      }
                                  }
                                  
                                  // If we have permissions to request
                                  if ([requestPermissions count] > 0){
                                      // Ask for the missing permissions
                                      [FBSession.activeSession
                                       requestNewReadPermissions:requestPermissions
                                       completionHandler:^(FBSession *session, NSError *error) {
                                           if (!error) {
                                               // Permission granted
                                               NSLog(@"new permissions %@", [FBSession.activeSession permissions]);
                                               // We can request the user information
                                               [self makeRequestForUserData];
                                           } else {
                                               // An error occurred, we need to handle the error
                                               // See: https://developers.facebook.com/docs/ios/errors
                                           }
                                       }];
                                  } else {
                                      // Permissions are present
                                      // We can request the user information
                                      [self makeRequestForUserData];
                                  }
                                  
                              } else {
                                  // An error occurred, we need to handle the error
                                  // See: https://developers.facebook.com/docs/ios/errors
                              }
                          }];
}

+ (void)makeRequestForUserData{
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // Success! Include your code to handle the results here
           // NSLog(@"user info: %@", result);
        } else {
            // An error occurred, we need to handle the error
        }
    }];
}


@end
