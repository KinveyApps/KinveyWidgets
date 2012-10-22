//
//  KCSUser+SocialExtras.h
//  KinveyKit
//
//  Created by Michael Katz on 9/18/12.
//  Copyright (c) 2012 Kinvey. All rights reserved.
//

#import <KinveyKit/KinveyKit.h>

/** Completion block for `getAccessDictionaryFromTwitterFromPrimaryAccount:` returns either the access dictionary to pass to `+[KCSUser loginWithWithSocialIdentity:accessDictionary:withCompletionBlock]` or an error.
 */
typedef void (^KCSLocalCredentialBlock)(NSDictionary* accessDictOrNil, NSError* errorOrNil);

/**
 These are additional helpers for KCSUser to obtain credentials from social services. This requires linking in `Twitter.framework` and `Accounts.framework`.
 @since 1.9
 */
@interface KCSUser (SocialExtras)

/**
 Checks that the a twitter account has been set up by the user on the device and that the KCSClient has been configured to obtain an auth token.
 @return true if there is enough information to request an access token from twitter
 @since 1.9
 */
+ (BOOL) canUseNativeTwitter;

/** Calls the Twitter reverse auth service to obtain an access token for the native user.
 
 In order for this method to succeed, you need to register an application with Twitter ( https://dev.twitter.com ) and supply the app's client key and client secret when setting up KCSClient (as `KCS_TWITTER_CLIENT_KEY`, and `KCS_TWITTER_CLIENT_SECRET`). You must also separately request and be granted reverse auth priveleges for your application ( https://support.twitter.com/forms/platform ). 
 
 If sucessful, the completion block will provide a dictionary ready for `+[KCSUser loginWithWithSocialIdentity:accessDictionary:withCompletionBlock]`.
 
 If the user has multiple twitter accounts configured in Settings, this will use the first one in the list. 
 
 @param completionBlock the block to be called when the request completes or faults.
 @since 1.9
 */
+ (void) getAccessDictionaryFromTwitterFromPrimaryAccount:(KCSLocalCredentialBlock)completionBlock;

@end
