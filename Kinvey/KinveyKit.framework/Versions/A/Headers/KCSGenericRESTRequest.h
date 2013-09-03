//
//  KCSGenericRESTRequest.h
//  KinveyKit
//
//  Copyright (c) 2012-2013 Kinvey. All rights reserved.
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
#import "KinveyBlocks.h"
#import "KCSConnectionResponse.h"

typedef enum {
    kGetRESTMethod     = 0,
    kPutRESTMethod     = 1,
    kPostRESTMethod    = 2,
    kDeleteRESTMethod  = 3
} KCSRESTMethod;

#define KCS_JSON_TYPE @"application/json; charset=utf-8"
#define KCS_DATA_TYPE @"application/octet-stream"

@interface KCSGenericRESTRequest : NSObject

@property (nonatomic, copy) NSString *resourceLocation;
@property (nonatomic, copy) NSMutableDictionary *headers;
@property (nonatomic) NSInteger method;
@property (nonatomic) BOOL followRedirects;

- (instancetype)initWithResource:(NSString *)resource usingMethod: (NSInteger)requestMethod;

+ (instancetype) requestForResource: (NSString *)resource usingMethod: (NSInteger)requestMethod withCompletionAction: (KCSConnectionCompletionBlock)complete failureAction:(KCSConnectionFailureBlock)failure progressAction: (KCSConnectionProgressBlock)progress;
+ (NSString *)getHTTPMethodForConstant:(NSInteger)constant;


- (void)start;
@end
