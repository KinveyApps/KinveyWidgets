//
//  KCSMetadata.h
//  KinveyKit
//
//  Copyright (c) 2012 Kinvey. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Fieldname to access an object's creator, using KCSQuery.
 @since 1.10.2
 */
FOUNDATION_EXPORT NSString* KCSMetadataFieldCreator;
/** Fieldname to access an object's last modified time, using KCSQuery.
 @since 1.10.2
 */
FOUNDATION_EXPORT NSString* KCSMetadataFieldLastModifiedTime;

/** This object represents backend information about the entity, such a timestamp and read/write permissions.
 
 To take advantage of KCSMetadata, map an entity property of this type to field `KCSEntityKeyMetadata`. The object that maps a particular instance is the "associated object." 
 */
@interface KCSMetadata : NSObject 
 
/** @name Basic Metadata */

/** The time at which the server recorded the most recent change to the entity. 
 @return the server time when the entity was last saved
 */
- (NSDate*) lastModifiedTime;

/** The id of the user that created the associated entity
 @return the user id that created the entity
 */
- (NSString*) creatorId;

/** @name read/write permissions */

/** 
 A quick test to see the current user can make changes to the associated object. This only takes into account permissions set on the metadata. The user may still have access to change the entity if the collection grants broader write access to its entities.  
 */
- (BOOL) hasWritePermission;

/** A list of users that have explict permission to read this entity. The actual set of users that can read the entity may be greater than this list, depending on the global permissions of the associated object or the object's containing collection. 
 @return an array of user ids that have acess to read this entity
 @see setUsersWithReadAccess:
 @see isGloballyReadable
 */
- (NSArray*) usersWithReadAccess;

/** Update the array of users with explicit read access. 
 
 Any change in permissions do not take effect until the associated object is saved to the backend.
 @param readers a non-nil array of string user id's that have explicit read access to the associated object.
 @see usersWithReadAccess
 @see setGloballyReadable:
 */
- (void) setUsersWithReadAccess:(NSArray*) readers;

/** A list of users that have explict permission to write this entity. The actual set of users that can write the entity may be greater than this list, depending on the global permissions of the associated object or the object's containing collection. 
 @return an array of user ids that have acess to read this entity
 @see setUsersWithWriteAccess:
 @see isGloballyWritable
 */
- (NSArray*) usersWithWriteAccess;

/** Update the array of users with explicit write access. 

 Any change in permissions do not take effect until the associated object is saved to the backend.
 @param writers a non-nil array of string user id's that have explicit write access to the associated object.
 @see usersWithWriteAccess
 @see setGloballyWritable:
 */
- (void) setUsersWithWriteAccess:(NSArray*) writers;

/** The global read permission for the associated entity. This could be broader or more restrictive than its collection's permissions.
 @return `YES` if the entity can be read by any user
 @see usersWithReadAccess
 @see setGloballyReadable:
 */
- (BOOL) isGloballyReadable;

/** Set global read permission for the associated object.
 
 Any change in permissions do not take effect until the associated object is saved to the backend.
 @param readable `YES` to allow the associated object to be read by any user.
 @see setUsersWithReadAccess:
 @see isGloballyReadable
*/
- (void) setGloballyReadable:(BOOL)readable;

/** The global write permission for the associated entity. This could be broader or more restrictive than its collection's permissions.
 @return `YES` if the entity can be modified by any user
 @see usersWithWriteAccess
 @see setGloballyWritable:
 */
- (BOOL) isGloballyWritable;

/** Set global write permission for the associated object.
 
 Any change in permissions do not take effect until the associated object is saved to the backend.
 @param writable `YES` to allow the associated object to be modified by any user.
 @see setUsersWithWriteAccess:
 @see isGloballyWritable
 */
- (void) setGloballyWritable:(BOOL)writable;

@end
