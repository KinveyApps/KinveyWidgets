//
//  KinveyEntity.h
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
#import "KinveyPersistable.h"
#import "KCSClient.h"
#import "KCSBlockDefs.h"

#import "KinveyHeaderInfo.h"

/*!  Describes required selectors for requesting entities from the Kinvey Service.
*
* This Protocol should be implemented by a client for processing the results of an Entity request against the KCS
* service.
* @deprecatedIn 1.19.0
*/
KCS_DEPRECATED(Use KCSStore API instead, 1.19.0)
@protocol KCSEntityDelegate <NSObject>

/*!
*  Called when a request fails for some reason (including network failure, internal server failure, request issues...)
 @param entity The Object that was attempting to be fetched.
 @param error The error that occurred
 @deprecatedIn 1.19.0
*/
- (void) entity: (id <KCSPersistable>)entity fetchDidFailWithError: (NSError *)error KCS_DEPRECATED(Use KCSStore methods instead, 1.19.0);

/*!
* Called when a request completes successfully.
 @param entity The Object that was attempting to be fetched.
 @param result The result of the completed request as an NSDictionary
 @deprecatedIn 1.19.0
*/
- (void) entity: (id <KCSPersistable>)entity fetchDidCompleteWithResult: (NSObject *)result KCS_DEPRECATED(Use KCSStore methods instead, 1.19.0);

@end

/*!  Add ActiveRecord-style capabilities to the built-in root object (NSObject) of the AppKit/Foundation system.
*
* This category is used to cause any NSObject to be able to be saved into the Kinvey Cloud Service.
*/
@interface NSObject (KCSEntity) <KCSPersistable>

/*! Return the client property name for the kinvey id
 *
 * @returns the client property name for the kinvey id
 */
- (NSString *)kinveyObjectIdHostProperty;

/*! Return the `KCSEntityKeyId` value for this entity
*
* @returns the `KCSEntityKeyId` value for this entity.
*/
- (NSString *)kinveyObjectId;

/** Sets the `KCSEntityKeyId` value for this entity
 @param objId the string `_id` for the entity
 */
- (void) setKinveyObjectId:(NSString*) objId;

/*! Returns the value for a given property in this entity
*
* @param property The property that we're interested in.
* @returns the value of this property.
*/
//- (NSString *)valueForProperty: (NSString *)property;

/*! Set a value for a given property (Depricated as of version 1.2)
* @param value The value to set for the given property
* @param property The property to assign this value to.
*/
- (void)setValue: (NSString *)value forProperty: (NSString *)property;


/*! Load an entity with a specific ID and replace the current object
* @param objectID The ID of the entity to request
* @param collection Collection to pull the entity from
* @param delegate The delegate to notify upon completion of the load.
* @deprecatedIn 1.19.0
*/
- (void)loadObjectWithID: (NSString *)objectID fromCollection: (KCSCollection *)collection withDelegate:(id <KCSEntityDelegate>)delegate KCS_DEPRECATED(Use KCSStore API Instead, 1.19.0);

// Undocumented
- (void)saveToCollection: (KCSCollection *)collection
     withCompletionBlock: (KCSCompletionBlock)onCompletion
       withProgressBlock: (KCSProgressBlock)onProgress;

- (void)deleteFromCollection: (KCSCollection *)collection
         withCompletionBlock: (KCSCompletionBlock)onCompletion
           withProgressBlock: (KCSProgressBlock)onProgress;

@end
