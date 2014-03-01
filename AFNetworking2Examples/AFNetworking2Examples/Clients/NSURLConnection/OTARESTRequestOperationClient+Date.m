//
//  OTARESTRequestOperationClient+Date.m
//  AFNetworking2Examples
//
//  Created by Ari Braginsky on 2/28/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "OTARESTRequestOperationClient+Date.h"
#import "OTATableViewController.h"

static OTARESTRequestOperationClient *sharedClient;

@implementation OTARESTRequestOperationClient (Date)

+ (OTARESTRequestOperationClient *) sharedClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		NSURL *baseURL = [NSURL URLWithString: kDateTestURL];
        sharedClient = [[self alloc] initWithBaseURL: baseURL];
    });
    
    return sharedClient;
}

@end