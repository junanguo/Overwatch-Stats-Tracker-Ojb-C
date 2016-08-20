//
//  WathcerHeroStats.m
//  Overwatcher_API
//
//  Created by Junan Guo on 8/18/16.
//  Copyright © 2016 Junan Guo. All rights reserved.
//

#import "WatcherHeroStats.h"

@implementation WatcherHeroStats : NSObject
@synthesize stats;
-(id)init{
    if (self = [super init]){
        stats = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)getHeroStatsOfPlayer:(WatcherPlayer*) player ofHero:(NSString*)hero ofMode:(NSString*)mode completion:(completionBlock)block{
    __block NSError *err;
    NSString *requestString = [NSString stringWithFormat:@"https://api.lootbox.eu/%@/%@/%@/%@/hero/%@/",player.platform, player.region, player.battleTag,mode,hero];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil){
            NSMutableDictionary *errDetail = [NSMutableDictionary dictionary];
            [errDetail setValue:@"Unable to retrieve data. Please check your connection." forKey:NSLocalizedDescriptionKey];
            err = [NSError errorWithDomain:@"Retrieval" code:1 userInfo:errDetail];
        }else{
            NSError *jsonErr;
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonErr];
            if (jsonErr != nil){
                NSMutableDictionary *errDetail = [NSMutableDictionary dictionary];
                [errDetail setValue:@"Unknown error while trying to collect the data." forKey:NSLocalizedDescriptionKey];
                err = [NSError errorWithDomain:@"Retrieval" code:2 userInfo:errDetail];
            }else{
                if (dataDic[@"statusCode"]){
                    NSMutableDictionary *errDetail = [NSMutableDictionary dictionary];
                    [errDetail setValue:[NSString stringWithFormat:@"%@", dataDic[@"error"]] forKey:NSLocalizedDescriptionKey];
                    err = [NSError errorWithDomain:@"Retrieval" code:[dataDic[@"statusCode"] intValue] userInfo:errDetail];
                }else{
                    self.stats = [NSMutableDictionary dictionaryWithDictionary:dataDic[hero]];
                }
            }
        }
        block(err);

    }] resume];
}
-(void)getAllHeroStatsOfPlayer:(WatcherPlayer*) player ofMode:(NSString*)mode completion:(completionBlock)block{
    __block NSError *err;
    NSString *requestString = [NSString stringWithFormat:@"https://api.lootbox.eu/%@/%@/%@/%@/allHeroes/",player.platform, player.region, player.battleTag,mode];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil){
            NSMutableDictionary *errDetail = [NSMutableDictionary dictionary];
            [errDetail setValue:@"Unable to retrieve data. Please check your connection." forKey:NSLocalizedDescriptionKey];
            err = [NSError errorWithDomain:@"Retrieval" code:1 userInfo:errDetail];
        }else{
            NSError *jsonErr;
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonErr];
            if (jsonErr != nil){
                NSMutableDictionary *errDetail = [NSMutableDictionary dictionary];
                [errDetail setValue:@"Unknown error while trying to collect the data." forKey:NSLocalizedDescriptionKey];
                err = [NSError errorWithDomain:@"Retrieval" code:2 userInfo:errDetail];
            }else{
                if (dataDic[@"statusCode"]){
                    NSMutableDictionary *errDetail = [NSMutableDictionary dictionary];
                    [errDetail setValue:[NSString stringWithFormat:@"%@", dataDic[@"error"]] forKey:NSLocalizedDescriptionKey];
                    err = [NSError errorWithDomain:@"Retrieval" code:[dataDic[@"statusCode"] intValue] userInfo:errDetail];
                }else{
                    self.stats = [NSMutableDictionary dictionaryWithDictionary:dataDic];

                }
            }
        }
        block(err);

    }] resume];
    
}
-(NSArray*)getAllDataTypes:(NSDictionary*)statsDic{
    return [statsDic allKeys];
}
@end
