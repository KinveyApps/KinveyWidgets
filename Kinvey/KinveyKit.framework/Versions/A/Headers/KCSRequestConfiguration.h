//
//  KCSRequestConfiguration.h
//  KinveyKit
//
//  Copyright (c) 2015 Kinvey. All rights reserved.
//
// This software is licensed to you under the Kinvey terms of service located at
// http://www.kinvey.com/terms-of-use. By downloading, accessing and/or using this
// software, you hereby accept such terms of service  (and any agreement referenced
// therein) and agree that you have read, understand and agree to be bound by such
// terms of service and are of legal age to agree to such terms with Kinvey.
//
// This software contains valuable confidential and proprietary information of
// KINVEY, INC and is subject to applicable licensing agreements.
// Unauthorized reproduction, transmission or distribution of this file and its
// contents is a violation of applicable laws.
//

#import <Foundation/Foundation.h>

/**
 Configuration wrapper for setting up Kinvey requests such as Client App Version and Custom Request Properties.
 This configuration object can be used as a global configuration attached to KCSClient or per request using the overload methods in a KCSStore instance.
 @since 1.29.0
 */
@interface KCSRequestConfiguration : NSObject

/**
 The Client Application Version that will be send in each Kinvey request.
 @since 1.29.0
 */
@property (nonatomic, strong) NSString *clientAppVersion;

/**
 The Custom Request Properties that will be send in each Kinvey request.
 @since 1.29.0
 */
@property (nonatomic, strong) NSDictionary *customRequestProperties;

/**
 Creates and initializes a new request configuration to be used in Kinvey request.
 
 @param clientAppVersion client application version that will be send in each Kinvey request.
 @param customRequestProperties custom request properties that will be send in each Kinvey request.
 @return an instance of KCSRequestConfiguration
 @since 1.29.0
 */
+(instancetype)requestConfigurationWithClientAppVersion:(NSString*)clientAppVersion
                             andCustomRequestProperties:(NSDictionary*)customRequestProperties;

/**
 Initializes the request configuration to be used in Kinvey request.
 
 @param clientAppVersion client application version that will be send in each Kinvey request.
 @param customRequestProperties custom request properties that will be send in each Kinvey request.
 @return an instance of KCSRequestConfiguration
 @since 1.29.0
 */
-(instancetype)initWithClientAppVersion:(NSString*)clientAppVersion
             andCustomRequestProperties:(NSDictionary*)customRequestProperties;

@end
