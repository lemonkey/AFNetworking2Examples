//
//  OTARESTRequestOperationClient.m
//  AFNetworking2Examples
//
//  Created by Ari Braginsky on 2/28/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

#import "OTARESTRequestOperationClient.h"
#import "OTAJSONResponseSerializer.h"

@implementation OTARESTRequestOperationClient

- (id) initWithBaseURL:(NSURL *)url {
	self = [super initWithBaseURL:url];
    if (self) {
		
		// default request serializer
		self.requestSerializer = [AFHTTPRequestSerializer serializer];
		[self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
		
		// Example of a custom response serializer based on AFJSONResponseSerializer
		self.responseSerializer = [OTAJSONResponseSerializer serializer];
		
		[self.operationQueue setMaxConcurrentOperationCount: 5];

		[AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
	}
	
	return self;
}

- (BOOL) ota_cancelAllHTTPOperationsWithMethod:(NSString *)method
										  path:(NSString *)path {
	NSURLRequest *matchingRequest = [self.requestSerializer requestWithMethod:(method ?: @"GET")
																	URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString]
																   parameters:nil
																		error:nil];
	
	NSString *pathToBeMatched = [[matchingRequest URL] path];
	
	BOOL didCancel = NO;
    for (NSOperation *operation in [self.operationQueue operations]) {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
            continue;
        }
        
        BOOL hasMatchingMethod = !method || [method isEqualToString:[[(AFHTTPRequestOperation *)operation request] HTTPMethod]];
        BOOL hasMatchingPath = [[[[(AFHTTPRequestOperation *)operation request] URL] path] isEqual:pathToBeMatched];
		
        if (hasMatchingMethod && hasMatchingPath) {
            [operation cancel];
			didCancel = YES;
        }
    }
	
	return didCancel;
}

@end
