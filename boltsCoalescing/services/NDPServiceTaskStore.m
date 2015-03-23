//
//  NDPServiceTaskStore.m
//  boltsCoalescing
//
//  Created by Nicholas Peterson on 3/20/15.
//  Copyright (c) 2015 Nicholas Peterson. All rights reserved.
//

#import "NDPServiceTaskStore.h"
#import <AFNetworking/AFURLRequestSerialization.h>

@implementation NDPServiceTaskStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.taskStore = @{};
    }
    return self;
}

- (BFTaskCompletionSource *)taskSourceForMethod:(NSString *)method URL:(NSString *)URLString parameters:(NSDictionary *)params {

    NSString *identifier = [self requestIdentifierForMethod:method URL:URLString parameters:params];

    return [self taskSourceForIdentifier:identifier];
}

- (BFTaskCompletionSource *)addTaskSourceForMethod:(NSString *)method URL:(NSString *)URLString parameters:(NSDictionary *)params {

    NSString *identifier = [self requestIdentifierForMethod:method URL:URLString parameters:params];

    BFTaskCompletionSource *taskSource = [BFTaskCompletionSource taskCompletionSource];
    [self addTaskSource:taskSource forIdentifier:identifier];
    return taskSource;
}

- (void)removeTaskSourceForMethod:(NSString *)method URL:(NSString *)URLString parameters:(NSDictionary *)params {

    NSString *identifier = [self requestIdentifierForMethod:method URL:URLString parameters:params];

    [self removeTaskSourceForIdentifier:identifier];
}

- (NSString *)requestIdentifierForMethod:(NSString *)method URL:(NSString*)URLString parameters:(NSDictionary *)params{
    NSMutableURLRequest *tempRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:method URLString:URLString parameters:params error:nil]; //TODO: Inject this

    return [NSString stringWithFormat:@"%@%@", tempRequest.URL, method];
}


- (BFTaskCompletionSource *)taskSourceForIdentifier:(NSString *)identifier {

    return self.taskStore[identifier];

}


- (void)addTaskSource:(BFTaskCompletionSource *)taskSource forIdentifier:(NSString *)identifier {
    NSMutableDictionary *taskStore = [self.taskStore mutableCopy];
    taskStore[identifier] = taskSource;
    self.taskStore = taskStore;
}

- (void)removeTaskSourceForIdentifier:(NSString *)identifier {
    NSMutableDictionary *taskStore = [self.taskStore mutableCopy];
    [taskStore removeObjectForKey:identifier];
    self.taskStore = taskStore;
}
@end
