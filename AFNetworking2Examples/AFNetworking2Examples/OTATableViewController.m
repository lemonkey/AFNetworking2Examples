//
//  OTATableViewController.m
//  AFNetworking2Examples
//
//  Created by Ari Braginsky on 2/28/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "OTATableViewController.h"
#import "OTARESTSessionClientWithDelegate.h"
#import "OTARESTSessionClient+Date.h"
#import "OTARESTRequestOperationClient+Date.h"

NSInteger const kTestCount									= 6;

#define kAFHTTPRequestOperation								@"AFHTTPRequestOperation"
#define kAFHTTPRequestOperationManager						@"AFHTTPRequestOperationManager"
#define kAFHTTPRequestOperationManagerClientCategory		@"AFHTTPRequestOperationManagerClientCategory"
#define kAFHTTPURLSessionManager							@"AFHTTPURLSessionManager"
#define kAFHTTPURLSessionManagerClientWithDelegate			@"AFHTTPURLSessionManagerClientWithDelegate"
#define kAFHTTPURLSessionManagerClientCategory				@"AFHTTPURLSessionManagerClientCategory"

typedef enum : NSInteger {
	AFNetworking2ExampleRequestOperation					= 0,
	AFNetworkingExampleRequestOperationManager				= 1,
	AFNetworkingExampleRequestOperationClientCategory		= 2,
	AFNetworkingExampleURLSessionManager					= 3,
	AFNetworkingExampleURLSessionManagerClientWithDelegate	= 4,
	AFNetworkingExampleURLSessionManagerClientCategory		= 5,
} AFNetworking2Example;

NSString * const kDateTestURL								= @"http://date.jsontest.com";


@interface OTATableViewController () <OTARESTSessionClientDelegate>
@property (strong, nonatomic) OTARESTRequestOperationClient *dateRequestOperationClient;
@property (strong, nonatomic) OTARESTSessionClientWithDelegate *dateSessionClientWithDelegate;
@property (strong, nonatomic) OTARESTSessionClient *dateSessionClient;
@end

@implementation OTATableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		self.dateRequestOperationClient = [OTARESTRequestOperationClient sharedClient];
		
		self.dateSessionClientWithDelegate = [OTARESTSessionClientWithDelegate sharedClient];
		self.dateSessionClientWithDelegate.delegate = self;
		
		self.dateSessionClient = [OTARESTSessionClient sharedClient];
	});
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return kTestCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier;
	
	switch (indexPath.row) {
		case AFNetworking2ExampleRequestOperation: {
			cellIdentifier = kAFHTTPRequestOperation;
			break;
		}
		case AFNetworkingExampleRequestOperationManager: {
			cellIdentifier = kAFHTTPRequestOperationManager;
			break;
		}
		case AFNetworkingExampleURLSessionManager: {
			cellIdentifier = kAFHTTPURLSessionManager;
			break;
		}
		case AFNetworkingExampleURLSessionManagerClientWithDelegate: {
			cellIdentifier = kAFHTTPURLSessionManagerClientWithDelegate;
			break;
		}
		case AFNetworkingExampleURLSessionManagerClientCategory: {
			cellIdentifier = kAFHTTPURLSessionManagerClientCategory;
			break;
		}
		case AFNetworkingExampleRequestOperationClientCategory: {
			cellIdentifier = kAFHTTPRequestOperationManagerClientCategory;
			break;
		}
		default:
			break;
	}
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
	
	switch (indexPath.row) {
		case AFNetworking2ExampleRequestOperation: {
			[self testAFNetworking2ExampleRequestOperation];
			break;
		}
		case AFNetworkingExampleRequestOperationManager: {
			[self testAFNetworkingExampleRequestOperationManager];
			break;
		}
		case AFNetworkingExampleURLSessionManager: {
			[self testAFNetworkingExampleURLSessionManager];
			break;
		}
		case AFNetworkingExampleURLSessionManagerClientWithDelegate: {
			[self testAFNetworkingExampleURLSessionManagerClientWithDelegate];
			break;
		}
		case AFNetworkingExampleURLSessionManagerClientCategory: {
			[self testAFNetworkingExampleURLSessionManagerClientCategory];
			break;
		}
		case AFNetworkingExampleRequestOperationClientCategory: {
			[self testAFNetworkingExampleRequestOperationClientCategory];
			break;
		}
		default:
			break;
	}
}

#pragma mark - AFNetworking tests

#pragma mark - NSURLConnection

- (void)testAFNetworking2ExampleRequestOperation {
	
	NSString *testName = @"AFHTTPRequestOperation";
	
	NSURL *URL = [NSURL URLWithString:kDateTestURL];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
	
	AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	
	// JSON response serialization
	op.responseSerializer = [AFJSONResponseSerializer serializer];

	[op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		[self showResult:[NSString stringWithFormat:@"%@", responseObject]
				fromTest:testName];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[self showResult:error.description
				fromTest:testName];
	}];
	
	[op start];
}

- (void)testAFNetworkingExampleRequestOperationManager {
	
	NSString *testName = @"AFHTTPRequestOperationManager";
	
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	
	// JSON response serialization
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	
	NSDictionary *parameters = @{@"format": @"json"};

	[manager POST:kDateTestURL
	   parameters:parameters
		  success:^(AFHTTPRequestOperation *operation, id responseObject) {
			  [self showResult:[NSString stringWithFormat:@"%@", responseObject]
					  fromTest:testName];
		  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			  [self showResult:error.description
					  fromTest:testName];
		  }];
}

- (void)testAFNetworkingExampleRequestOperationClientCategory {
	
	NSString *testName = @"AFHTTPRequestOperationManagerClientCategory";
	
	[self.dateRequestOperationClient ota_cancelAllHTTPOperationsWithMethod:@"POST"
																	  path:kDateTestURL];
	
	NSDictionary *parameters = @{@"format": @"json"};
	
	[self.dateRequestOperationClient POST:kDateTestURL
							   parameters:parameters
								  success:^(AFHTTPRequestOperation *task, id responseObject) {
									  [self showResult:[NSString stringWithFormat:@"%@", responseObject]
											  fromTest:testName];
								  } failure:^(AFHTTPRequestOperation *task, NSError *error) {
									  [self showResult:error.description
											  fromTest:testName];
								  }];
}

#pragma mark - NSURLSession

- (void)testAFNetworkingExampleURLSessionManager {
	
	NSString *testName = @"AFHTTPSessionManager";
	
	NSURL *baseURL = [NSURL URLWithString:kDateTestURL];
	
	NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
	sessionConfiguration.timeoutIntervalForRequest = 10.0;
	sessionConfiguration.HTTPAdditionalHeaders = @{@"Accept" : @"application/json"};
	
	AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL: baseURL
															 sessionConfiguration:sessionConfiguration];
	
	// JSON request serialization
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	
	// JSON response serialization
	manager.responseSerializer = [AFJSONResponseSerializer serializer];

	NSDictionary *parameters = @{@"format": @"json"};

	[manager POST:@"/" parameters:parameters
		 success:^(NSURLSessionDataTask *task, id responseObject) {
			 [self showResult:[NSString stringWithFormat:@"%@", responseObject]
					 fromTest:testName];
		 } failure:^(NSURLSessionDataTask *task, NSError *error) {
			 [self showResult:error.description
					 fromTest:testName];
		 }];
}

- (void)testAFNetworkingExampleURLSessionManagerClientWithDelegate {
	[self.dateSessionClientWithDelegate loadData];
}
-(void)otaRESTSessionClientWithDelegate:(OTARESTSessionClientWithDelegate *)client didUpdateWithData:(id)data {
	[self showResult:[NSString stringWithFormat:@"%@", data]
			fromTest:@"AFHTTPSessionManagerClientWithDelegate"];
}
-(void)otaRESTSessionClientWithDelegate:(OTARESTSessionClientWithDelegate *)client didFailWithError:(NSError *)error {
	[self showResult:[NSString stringWithFormat:@"%@", error.description]
			fromTest:@"AFHTTPSessionManagerClientWithDelegate"];
}

- (void)testAFNetworkingExampleURLSessionManagerClientCategory {
	
	NSString *testName = @"AFHTTPURLSessionManagerClientCategory";
	
	[self.dateSessionClient ota_cancelAllHTTPOperationsWithMethod:@"POST"
															 path:kDateTestURL];
	
	NSDictionary *parameters = @{@"format": @"json"};
	
	[self.dateSessionClient POST:kDateTestURL
					  parameters:parameters
						 success:^(NSURLSessionDataTask *task, id responseObject) {
							 [self showResult:[NSString stringWithFormat:@"%@", responseObject]
									 fromTest:testName];
						 } failure:^(NSURLSessionDataTask *task, NSError *error) {
							 if(error.code != NSURLErrorCancelled) {
								 [self showResult:error.description
										 fromTest:testName];
							 }
							 else {
								 [self showResult:@"Task cancelled!"
										 fromTest:testName];
							 }
						 }];
}

#pragma mark - Helper methods

- (void)showResult:(NSString *)result fromTest:(NSString *)test {
	if(!result || !test) {
		return;
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Result for %@", test]
													message:result
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[alert show];
	});
}

@end
