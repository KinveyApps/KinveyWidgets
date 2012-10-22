//
//  KCSUniqueNumber
//  KinveyKit
//
//  Copyright (c) 2012 Kinvey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KinveyPersistable.h"
#import "KCSMetadata.h"

/** The default sequence id */
#define KCSSequenceId @"_sequence"

#define KCSSequenceType @"KinveySequence"

/** A KCSUniqueNumber is a special object that represents an unqiue set of numbers. Each time the value is read from the backend, it will have a different and larger value. This way you can generate unique numbers.
 
 @warning Although the `value`s are gauranteed to be unique and increasing, they are not guaranteed to be incremental. Fetching this object from the backend, the value will  change every time. 
 
 By default, each collection can contain one unique sequence, with the id `KCSSequenceId`. Additional sequences can be created and saved to any collection. These will have their own unique ids. These special objects will be an instance of the `KCSUniqueNumber` class, regardless of the class type set for the collection.
 
 To fetch the new value from a collection:
      
     KCSCollection* collection = [KCSCollection collectionFromString:@"<#Collection Name#>" ofClass:[<#CollectionClass#> class]];
     KCSAppdataStore* store = [KCSAppdataStore storeWithCollection:collection options:nil];
     [store loadObjectWithID:KCSSequenceId withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
         KCSUniqueNumber* x = [objectsOrNil objectAtIndex:0];
         NSLog(@"The new value is %i",x.value);
      } withProgressBlock:nil];

 @warning Each collection can have a sequence number, which exists as an entity in that collection. Any query that fetches all objects (such as `[KCSQuery query]`) will return an array of matching entities, each sequence entity will be a `KCSUniqueNumber` and the rest will be of the collection class. 
 
 New sequences can be created with their own ids, so multiple sequences can exist in a collection (and in fact, you can create a collection just for sequences). The initial value can be set before saving. Additionally, any sequence can be reset to a known value through `setValue:`.
 
 For example,
 
     KCSUniqueNumber* seq = [[[KCSUniqueNumber alloc] init] autorelease];
     seq.value = 100;
     [store saveObject:seq withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
         KCSUniqueNumber* x = [objectsOrNil objectAtIndex:0]; // the "value" property will be 100.
      } withProgressBlock:nil];

 
 @since 1.8.1
 */
@interface KCSUniqueNumber : NSObject <KCSPersistable>
/** The current value of the sequence. Saving this object will reset to this value. Fetching the object will obtain the next number.
 */
@property (nonatomic) NSInteger value;
/**
 The entity `_id` for the this object. The default for any collection is `_sequence`, but additional sequences can be created with different ids.
 */
@property (nonatomic, retain) NSString* sequenceId;
@property (nonatomic, retain) KCSMetadata* metadata;

/** The object for the default sequence available per collection
 @return a object representing the sequence entity for a collection
 */
+ (KCSUniqueNumber*) defaultSequence;

/** Start the sequence back at a zero.
 */
- (void) reset;

@end
