//
//  OTAJSONResponseSerializer.m
//  AFNetworking2Examples
//
//  Created by Ari Braginsky on 2/28/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "OTAJSONResponseSerializer.h"

@interface OTAJSONResponseSerializer()
@property (nonatomic, readwrite) NSDictionary *responseObject;
@property (nonatomic, readwrite) NSError *customJSONValidationError;
@end

@implementation OTAJSONResponseSerializer

- (NSSet *)acceptableContentTypes {
    return [NSSet setWithObjects:@"application/json", @"text/javascript", nil];
}

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error {
	
	_responseObject = [super responseObjectForResponse:response data:data error:error];
	
	if(_responseObject && !*error) {
		_customJSONValidationError = [self validateResponseObject: _responseObject];
	}
	
	return _responseObject;
}

- (NSError *) validateResponseObject: (NSDictionary *) responseObject {
	// perform custom validation here
	return nil;
}

@end