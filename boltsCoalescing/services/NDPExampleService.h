//
//  NDPExampleService.h
//  boltsCoalescing
//
//  Created by Nicholas Peterson on 3/20/15.
//  Copyright (c) 2015 Nicholas Peterson. All rights reserved.
//
#import <Foundation/Foundation.h>

@class NDPService;

@interface NDPExampleService : NSObject
@property (nonatomic, strong) NDPService *internalService;

- (void)getExampleResourceWithComplete:(void (^) (NSDictionary *data, NSError *error)) complete;
@end
