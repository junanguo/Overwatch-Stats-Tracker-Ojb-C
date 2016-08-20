//
//  WathcerHeroStats.h
//  Overwatcher_API
//
//  Created by Junan Guo on 8/18/16.
//  Copyright © 2016 Junan Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "w_Constant.h"
#import "WatcherPlayer.h"

typedef void(^completionBlock) (NSError *err);
@interface WatcherHeroStats : NSObject
@property (nonatomic,retain) NSMutableDictionary *stats;

-(id)init;
-(void)getHeroStatsOfPlayer:(WatcherPlayer*) player ofHero:(NSString*)hero ofMode:(NSString*)mode completion:(completionBlock)block;
-(void)getAllHeroStatsOfPlayer:(WatcherPlayer*) player ofMode:(NSString*)mode completion:(completionBlock)block;
-(NSArray*)getAllDataTypes:(NSDictionary*)statsDic;
@end
