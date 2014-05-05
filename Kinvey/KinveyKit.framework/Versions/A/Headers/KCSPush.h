//
//  KCSPush.h
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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "KinveyHeaderInfo.h"


/*! Push Service (APNS) Helper Container

 This Singleton is used as a collection of all items related to the Push Service offered by Kinvey
 
 */
@interface KCSPush : NSObject

#pragma mark push notifications

///---------------------------------------------------------------------------------------
/// @name Initialization & disposal
///---------------------------------------------------------------------------------------

/*! Return the single shared instance of the Push Notification Service
 
 This routine returns the shared Push Service object, creating it if required.  This should be used
 to gain access to all push methods.
 
 @return The shared Push Service object.
 */
+ (KCSPush *)sharedPush;

///---------------------------------------------------------------------------------------
/// @name Startup / Shutdown
///---------------------------------------------------------------------------------------


/** Start the Push Service
 
 To use this routine, place a call to this in the applicationDidLoad:withOptions method in the App Delegate.
 
 @warning Push notifications will not work if this method has not been called.
 @since 1.19.0
 */
+ (void) registerForPush;


/** Removes the device token from the active user. 
 
 This requires a sucessful call to the Kinvey server.
 
 @param completionBlock called when the request to Kinvey completes. If success is YES, then the token was removed.
 @since 1.26.6
 */
- (void) unRegisterDeviceToken:(void (^)(BOOL success, NSError* error))completionBlock;


/*! Clean-up Push Service
 
 This routine is used to clean-up the push service prior to application termination.  This will perform some basic clean-up and will be used to
 help generate accurate analytics.
 
 This method should be called in the applicationWillTerminate: method of the App Delegate class
 `[[KCSPush sharedPush] onUnloadHelper];`
 
 @warning Calling this on application will terminate *does not* prevent Push Notifications from being received by devices, the push notifications will still be received.
 */
- (void)onUnloadHelper;

///---------------------------------------------------------------------------------------
/// @name Receiving Notifications
///---------------------------------------------------------------------------------------

/*! Do library specific remote notification processing
 
 The Kinvey library requires the remote notification to be forwarded this Push Service to provide convienience functions and management,
 this method allows us to obtain all necessary information.
 
 Call this in your implementation for handling remote notifications:
 
    - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
        [[KCSPush sharedPush] application:application didReceiveRemoteNotification:userInfo];
        // Additional push notification handling code should be performed here
    }
 
 @param application The application sending this message.
 @param userInfo The userInfo dictionary provided by the application.
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

///---------------------------------------------------------------------------------------
/// @name Registering for Notifications
///---------------------------------------------------------------------------------------

/** Register for remote notifications
 
 Call this in your implementation for updating the registration in case the device tokens change.
 
     - (void)applicationDidBecomeActive:(UIApplication *)application
     {
         [[KCSPush sharedPush] registerForRemoteNotifications];
         //Additional become active actions
     }
 
 @since 1.17.0
 */
- (void) registerForRemoteNotifications;


/*! Register device for remote notifications
 
 The Kinvey library requires information from the registration of remote notifications to perform several tasks.
 This information needs to be forwarded to the library when received by the App Delegate. This method registers the token with the active user. If there is no active user at the time, the push token is cached and registered automatically registered when the active user is set.

 Call this in your implementation for handling registration:
 
 - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
 [[KCSPush sharedPush] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
 // Additional registration goes here (if neeeded).
 }
 
 
 @param application The application sending this message.
 @param deviceToken The device token of the device this instance of the application is running on.
 @param completionBlock called after the token is registered on the server. `success` will be no if there is no active user at the time, or if the registration fails. If there is a user and the registration fails, then there will be an error object. In the error case, the request should be tried again later if it was a network error.
 
 @since 1.19.0
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken completionBlock:(void (^)(BOOL success, NSError* error))completionBlock;

/*! Failed to register device for remote notifications
 
 The Kinvey library requires information from the registration of remote notifications to perform several tasks.
 This information needs to be forwarded to the library when received by the App Delegate.
 
 This will retry later if there was a connection failure, but not if the user chose to disable remote notifications.
 
 Call this in your implementation for handling failure:
 
     - (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
     {
         [[KCSPush sharedPush] application:application didFailToRegisterForRemoteNotificationsWithError:error];
     }

 @param application The application sending this message.
 @param error The registration failure
 @since 1.17.0
 */
- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

///---------------------------------------------------------------------------------------
/// @name Badge Management
///---------------------------------------------------------------------------------------
/*! Set the number of unread push notifications on the app badge
 
 Reset the number of waiting push notifications on for the app's badge.
 This is a wrapper around the UrbanAirship feature.
 
 @param number The number to set the badge to
 
 */
- (void)setPushBadgeNumber: (int)number;

/*! Reset the app's unread pushes to 0
 
 Reset the push count
 
 */
- (void)resetPushBadge;

@end
