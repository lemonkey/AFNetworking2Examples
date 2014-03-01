//
//  OTARESTSessionClientWithDelegate.m
//  AFNetworking2Examples
//
//  Created by Ari Braginsky on 2/28/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "OTARESTSessionClientWithDelegate.h"
#import "OTATableViewController.h"

@implementation OTARESTSessionClientWithDelegate

+ (OTARESTSessionClientWithDelegate *)sharedClient {
	static OTARESTSessionClientWithDelegate *_sharedClient = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kDateTestURL]];
	});
	
	return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
	
	NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
	sessionConfig.timeoutIntervalForRequest = 10.0f;
	sessionConfig.timeoutIntervalForResource = 10.0f;
	
	self = [super initWithBaseURL:url sessionConfiguration:sessionConfig];
	
	if(self) {
		self.responseSerializer = [AFJSONResponseSerializer serializer];
		self.requestSerializer = [AFJSONRequestSerializer serializer];
	}
	
	return self;
}

- (void)loadData {
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	parameters[@"format"] = @"json";
	
	[self GET:@"/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
		if([self.delegate respondsToSelector:@selector(otaRESTSessionClientWithDelegate:didUpdateWithData:)]) {
			[self.delegate otaRESTSessionClientWithDelegate:self didUpdateWithData:responseObject];
		}
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		if([self.delegate respondsToSelector:@selector(otaRESTSessionClientWithDelegate:didFailWithError:)]) {
			[self.delegate otaRESTSessionClientWithDelegate:self didFailWithError:error];
		}
	}];
}

@end
