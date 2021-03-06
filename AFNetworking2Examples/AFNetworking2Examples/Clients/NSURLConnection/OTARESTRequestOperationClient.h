//
//  OTARESTRequestOperationClient.h
//  AFNetworking2Examples
//
//  Created by Ari Braginsky on 2/28/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface OTARESTRequestOperationClient : AFHTTPRequestOperationManager

- (BOOL) ota_cancelAllHTTPOperationsWithMethod:(NSString *)method
										  path:(NSString *)path;

@end
