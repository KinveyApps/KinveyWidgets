//
//  KCSEntityCache.h
//  KinveyKit
//
//  Created by Michael Katz on 10/23/12.
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

#import "KCSOfflineSaveStore.h"

NSString* KCSMongoObjectId();

@protocol KCSPersistable;
@class KCSQuery;
@class KCSGroup;
@class KCSReduceFunction;

@protocol KCSEntityCache <NSObject>

#pragma mark Queries
- (void) removeQuery:(KCSQuery*) query;
- (void) setResults:(NSArray*)results forQuery:(KCSQuery*)query;
- (NSArray*) resultsForQuery:(KCSQuery*)query;

#pragma mark Invidual Elements
- (id) objectForId:(NSString*)objId;
- (void) addResult:(id)obj;
- (void) addResults:(NSArray*)objects;
- (void) removeIds:(NSArray*)keys;
- (NSArray*) resultsForIds:(NSArray*)keys;

#pragma mark Group
- (void) setResults:(KCSGroup*)results forGroup:(NSArray*)fields reduce:(KCSReduceFunction *)function condition:(KCSQuery *)condition;
- (void) removeGroup:(NSArray*)fields reduce:(KCSReduceFunction *)function condition:(KCSQuery *)condition;

#pragma mark Persistence
- (void) setPersistenceId:(NSString*)key;
- (void) clearCaches;

#pragma mark Saving
- (void) addUnsavedObject:(id)obj;

#pragma mark Internal
- (void) setSaveContext:(NSDictionary*)saveContext;

@end


@interface KCSEntityCache : NSObject <KCSEntityCache>

@property (nonatomic, unsafe_unretained) id<KCSOfflineSaveDelegate> delegate;
//TODO remove?
- (void) startSaving;

#pragma mark Persistence

+ (void) clearAllCaches;

@end

@interface KCSCachedStoreCaching : NSObject
+ (id<KCSEntityCache>) cacheForCollection:(NSString*)collectionName;
@end

