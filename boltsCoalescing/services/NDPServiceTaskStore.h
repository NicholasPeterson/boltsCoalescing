//
//  NDPServiceTaskStore.h
//  boltsCoalescing
//
//  Created by Nicholas Peterson on 3/20/15.
//  Copyright (c) 2015 Nicholas Peterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bolts/Bolts.h>

@interface NDPServiceTaskStore : NSObject
@property (nonatomic, copy) NSDictionary *taskStore;

- (BFTaskCompletionSource *)taskSourceForMethod:(NSString *)method URL:(NSString *)URLString parameters:(NSDictionary *)params;
- (void)removeTaskSourceForMethod:(NSString *)method URL:(NSString *)URLString parameters:(NSDictionary *)params;
- (BFTaskCompletionSource *)addTaskSourceForMethod:(NSString *)method URL:(NSString *)URLString parameters:(NSDictionary *)params;

@end
