//
//  KCSCustomEndpoints.h
//  KinveyKit
//
//  Created by Michael Katz on 5/30/13.
//  Copyright (c) 2013 Kinvey. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Class to wrap Custom Business Logic Endpoints.
 @since 1.17.0
 */
@interface KCSCustomEndpoints : NSObject

/** Call a custom endpoint
 @param endpoint the name of the custom endpoint
 @param params the body paramaters to pass to the endpoint
 @param completionBlock the response block. `results` will be the value returned by your business logic, and `error` will be non-nil if an error occurred.
 @since 1.17.0
 */
+ (void) callEndpoint:(NSString*)endpoint
               params:(NSDictionary*)params
      completionBlock:(void (^)(id results, NSError* error))completionBlock;

@end
