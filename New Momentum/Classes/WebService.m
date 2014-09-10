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
    if (networkStatus == NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
