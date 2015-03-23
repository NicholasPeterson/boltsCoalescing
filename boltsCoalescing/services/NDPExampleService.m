//
//  NDPExampleService.m
//  boltsCoalescing
//
//  Created by Nicholas Peterson on 3/20/15.
//  Copyright (c) 2015 Nicholas Peterson. All rights reserved.
//

#import "NDPExampleService.h"
#import "NDPService.h"

const NSString *NDPExampleServiceBaseURL = @"http://example.com/";

@implementation NDPExampleService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.internalService = [[NDPService alloc] init]; //TODO: inject this
    }
    return self;
}

- (void)getExampleResourceWithComplete:(void (^) (NSDictionary *data, NSError *error)) complete {
    [self get:@"resource/" parameters:nil withComplete:complete];
}


#pragma mark - internal

- (void)get:(NSString *)endpoint parameters:(NSDictionary *)params withComplete:(void (^) (NSDictionary *data, NSError *error)) complete {

    NSString *URLString = [self fullyQualifiedURLWithEndpoint:endpoint];

    BFTask *task = [self.internalService get:URLString parameters:params];

    [task continueWithBlock:^id(BFTask *task) {
        complete(task.result, task.error);

        return task;
    }];
}

- (NSString *)fullyQualifiedURLWithEndpoint:(NSString *)endpoint {
    return [NSString stringWithFormat:@"%@%@", NDPExampleServiceBaseURL, endpoint];
}



@end
