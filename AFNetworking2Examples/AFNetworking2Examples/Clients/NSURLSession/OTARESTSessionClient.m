//
//  OTARESTSessionClient.m
//  AFNetworking2Examples
//
//  Created by Ari Braginsky on 2/28/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

#import "OTARESTSessionClient.h"

@implementation OTARESTSessionClient

- (id)initWithBaseURL:(NSURL *)url
{
	NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
	sessionConfig.HTTPMaximumConnectionsPerHost = 5;
	
    self = [super initWithBaseURL: url sessionConfiguration:sessionConfig];
    if (self) {
		
		// default request serializer
		self.requestSerializer = [AFHTTPRequestSerializer serializer];
		[self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];

		// default JSON response serializer
		self.responseSerializer = [AFJSONResponseSerializer serializer];
		self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", nil];
		
		[AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
		
		self.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    
    return self;
}

#pragma mark - NSURLSessionTask cancellation

- (BOOL) ota_cancelAllHTTPOperationsWithMethod:(NSString *)method path:(NSString *)path
{
	method = (method ?: @"GET");
	
	__block BOOL didCancel = NO;
	
	[self.session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
		for(NSURLSessionDataTask *dataTask in dataTasks) {
			didCancel = [self cancelURLSessionTask:dataTask withMethod:method path:path];
		}
		for(NSURLSessionDownloadTask *downloadTask in downloadTasks) {
			didCancel = [self cancelURLSessionTask:downloadTask withMethod:method path:path];
		}
		for(NSURLSessionUploadTask *uploadTask in uploadTasks) {
			didCancel = [self cancelURLSessionTask:uploadTask withMethod:method path:path];
		}
	}];
	
	return didCancel;
}

- (BOOL) cancelURLSessionTask:(NSURLSessionTask *)task withMethod:(NSString *)method path:(NSString *)path {
	if(!task || method.length == 0 || path.length == 0) {
		return NO;
	}
	
	BOOL hasMatchingMethod = !method || [method isEqualToString:[task.originalRequest HTTPMethod]];
	BOOL hasMatchingPath = [[[task.originalRequest URL] path] isEqual:path];
	
	if (hasMatchingMethod && hasMatchingPath) {
		[task cancel];
		return YES;
	}
	
	return NO;
}

@end