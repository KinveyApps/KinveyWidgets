//
//  KCSURLProtocol.h
//  KinveyKit
//
//  Created by Victor Barros on 2015-03-20.
//  Copyright (c) 2015 Kinvey. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 NSURLProtocol wrapper for Kinvey requests.
 @since 1.29.0
 */
@interface KCSURLProtocol : NSURLProtocol

/**
 Register the protocol class in the NSURLProtocol and add the protocol class for Kinvey requests.
 
 @param protocolClass the protocol class to be registered.
 @return YES if the protocol was registered successfully.
 @since 1.29.0
 */
+(BOOL)registerClass:(Class)protocolClass;

/**
 Unregister the protocol class in the NSURLProtocol and remove the protocol class for Kinvey requests.
 
 @param protocolClass the protocol class to be registered.
 @since 1.29.0
 */
+(void)unregisterClass:(Class)protocolClass;

/**
 Returns all registered protocol classes for Kinvey requests.
 
 @return all registered protocol classes for Kinvey requests
 @since 1.29.0
 */
+(NSArray*)protocolClasses;

@end
