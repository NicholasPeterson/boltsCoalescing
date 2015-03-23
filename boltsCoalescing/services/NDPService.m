//
//  NDPService.m
//  boltsCoalescing
//
//  Created by Nicholas Peterson on 3/20/15.
//  Copyright (c) 2015 Nicholas Peterson. All rights reserved.
//

#import "NDPService.h"
#import "NDPServiceTaskStore.h"

@implementation NDPService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestManager = [AFHTTPRequestOperationManager manager];
        self.taskStore = [[NDPServiceTaskStore alloc] init];
    }
    return self;
}

- (BFTask *)get:(NSString *)URLString parameters:(NSDictionary *)params {
    BFTaskCompletionSource *taskSource = [self.taskStore taskSourceForMethod:@"GET" URL:URLString parameters:params];

    if (!taskSource) {
        taskSource = [self.taskStore addTaskSourceForMethod:@"GET" URL:URLString parameters:params];

        [self.requestManager GET:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [taskSource setResult:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [taskSource setError:error];
        }];
    }
    
    //Remove the task when the chain starts
    BFTask *task = taskSource.task;
    [task continueWithBlock:^id(BFTask *task) {
        [self.taskStore removeTaskSourceForMethod:@"GET" URL:URLString parameters:params];
        return task;
    }];

    return taskSource.task;
}

@end
