//
//  KinveyEntity.h
//  KinveyKit
//
//  Copyright (c) 2008-2014, Kinvey, Inc. All rights reserved.
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

#import "KinveyHeaderInfo.h"

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
@end
