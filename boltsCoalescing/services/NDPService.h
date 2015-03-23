//
//  NDPService.h
//  boltsCoalescing
//
//  Created by Nicholas Peterson on 3/20/15.
//  Copyright (c) 2015 Nicholas Peterson. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Bolts/Bolts.h>

@class NDPServiceTaskStore;

@interface NDPService : NSObject
@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;
@property (nonatomic, strong) NDPServiceTaskStore *taskStore;

- (BFTask *)get:(NSString *)URLString parameters:(NSDictionary *)params;

@end
