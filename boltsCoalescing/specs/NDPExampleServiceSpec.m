//
//  NDPExampleServiceSpecSpec.m
//  boltsCoalescing
//
//  Created by Nicholas Peterson on 3/23/15.
//  Copyright 2015 Nicholas Peterson. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NDPExampleService.h"
#import "NDPService.h"

SPEC_BEGIN(NDPExampleServiceSpec)

describe(@"NDPExampleService", ^{
    
    describe(@"When network called 3 times", ^{

        it(@"internally only calls the network once", ^{

            // To make this test fail go to NDPServiceTaskStore and return nil from -taskSourceForMethod:URL:parameters:

            NDPExampleService *service = [[NDPExampleService alloc] init];
            service.internalService.requestManager = [[service.internalService.requestManager class] mock];

            [[service.internalService.requestManager should] receive:@selector(GET:parameters:success:failure:) withCount:1];

            [service getExampleResourceWithComplete:^(NSDictionary *data, NSError *error) {
            }];
            [service getExampleResourceWithComplete:^(NSDictionary *data, NSError *error) {
            }];
            [service getExampleResourceWithComplete:^(NSDictionary *data, NSError *error) {
            }];

        });
    });
});

SPEC_END