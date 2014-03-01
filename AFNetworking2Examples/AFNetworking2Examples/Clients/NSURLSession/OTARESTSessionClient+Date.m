//
//  OTARESTSessionClient+Date.m
//  AFNetworking2Examples
//
//  Created by Ari Braginsky on 2/28/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "OTARESTSessionClient+Date.h"
#import "OTATableViewController.h"

static OTARESTSessionClient *sharedClient;

@implementation OTARESTSessionClient (Date)

+ (OTARESTSessionClient *) sharedClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		NSURL *baseURL = [NSURL URLWithString: kDateTestURL];
        sharedClient = [[self alloc] initWithBaseURL: baseURL];
    });
    
    return sharedClient;
}

@end
