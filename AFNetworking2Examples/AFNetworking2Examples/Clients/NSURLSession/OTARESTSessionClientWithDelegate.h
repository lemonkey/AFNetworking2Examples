//
//  OTARESTSessionClientWithDelegate.h
//  AFNetworking2Examples
//
//  Created by Ari Braginsky on 2/28/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//
//
//	Demonstrates using delegate methods instead of callback blocks.

#import "AFHTTPSessionManager.h"

@protocol OTARESTSessionClientDelegate;

@interface OTARESTSessionClientWithDelegate : AFHTTPSessionManager
@property (weak, nonatomic) id<OTARESTSessionClientDelegate>delegate;

+ (OTARESTSessionClientWithDelegate *)sharedClient;
- (void)loadData;

@end

@protocol OTARESTSessionClientDelegate <NSObject>
@required
- (void)otaRESTSessionClientWithDelegate:(OTARESTSessionClientWithDelegate *)client didUpdateWithData:(id)data;
- (void)otaRESTSessionClientWithDelegate:(OTARESTSessionClientWithDelegate *)client didFailWithError:(NSError *)error;
@end