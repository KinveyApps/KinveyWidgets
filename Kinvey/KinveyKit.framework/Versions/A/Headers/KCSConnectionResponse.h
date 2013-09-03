//
//  KCSConnectionResponse.h
//  KinveyKit
//
//  Copyright (c) 2008-2013, Kinvey, Inc. All rights reserved.
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

@interface KCSConnectionResponse : NSObject

@property (readonly) NSInteger responseCode; // See KinveyHTTPSStatusCodes for definitions
@property (retain, readonly) NSData *responseData;
@property (retain, readonly) NSDictionary *userData;
@property (retain, readonly) NSDictionary *responseHeaders;
@property (retain, readonly) NSString* requestId;


+ (instancetype)connectionResponseWithCode:(NSInteger)code responseData:(NSData *)data headerData:(NSDictionary *)header userData:(NSDictionary *)userDefinedData; 

- (NSString*) stringValue;
- (id) jsonResponseValue;
- (id) jsonResponseValue:(NSError**) anError;


@end
