//
//  OTAJSONResponseSerializer.h
//  AFNetworking2Examples
//
//  Created by Ari Braginsky on 2/28/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "AFURLResponseSerialization.h"

@interface OTAJSONResponseSerializer : AFJSONResponseSerializer

@property (nonatomic, readonly) NSDictionary *responseObject;
@property (nonatomic, readonly) NSError *customJSONValidationError;

@end