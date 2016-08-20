//
//  WatcherUser.m
//  Overwatcher_API
//
//  Created by Junan Guo on 8/18/16.
//  Copyright © 2016 Junan Guo. All rights reserved.
//

#import "WatcherPlayer.h"

@implementation WatcherPlayer
@synthesize name;
@synthesize avatar;
@synthesize level;
@synthesize rank;
@synthesize rankImg;
@synthesize levelFrame;
@synthesize star;
@synthesize quickWins;
@synthesize quickLost;
@synthesize quickTime;
@synthesize quickPlayed;
@synthesize compLost;
@synthesize compTime;
@synthesize compWins;
@synthesize compPlayed;

-(id)initWithBattleTag:(NSString*)tag platform:(NSString*)plt andRegion:(NSString*)reg error:(NSError**)err{
    if (self = [super init]){
        if (tag.length==0 || plt.length==0 || reg.length==0){
            // Empty parameters
            NSMutableDictionary *errDetail = [NSMutableDictionary dictionary];
            [errDetail setValue:@"The request should not contain any empty parameters" forKey:NSLocalizedDescriptionKey];
            *err = [NSError errorWithDomain:@"initialization" code:-1 userInfo:errDetail];
        }else{
            self.battleTag = [tag stringByReplacingOccurrencesOfString:@"#" withString:@"-"];
            self.platform = plt;
            self.region = reg;
        }
    }
    return self;
}


-(void)loadPofilewithCompletion:(myCompletion)block{
   __block NSError *err = nil;
        NSString *requestString = [NSString stringWithFormat:@"https://api.lootbox.eu/%@/%@/%@/profile",_platform, _region, _battleTag];
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
                NSDictionary *profile = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonErr];
                if (jsonErr != nil){
                    NSMutableDictionary *errDetail = [NSMutableDictionary dictionary];
                    [errDetail setValue:@"Unknown error while trying to collect the data." forKey:NSLocalizedDescriptionKey];
                    err = [NSError errorWithDomain:@"Retrieval" code:2 userInfo:errDetail];
                }else{
                    
                    if (profile[@"statusCode"]){
                        NSMutableDictionary *errDetail = [NSMutableDictionary dictionary];
                        [errDetail setValue:[NSString stringWithFormat:@"%@", profile[@"error"]] forKey:NSLocalizedDescriptionKey];
                        err = [NSError errorWithDomain:@"Retrieval" code:[profile[@"statusCode"] intValue] userInfo:errDetail];
                    }else{
                        name = profile[@"data"][@"username"];
                        level = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",profile[@"data"][@"level"]]];
                        quickWins = profile[@"data"][@"games"][@"quick"][@"wins"];
                        quickLost = [NSString stringWithFormat:@"%@",profile[@"data"][@"games"][@"quick"][@"lost"]];
                        quickPlayed = profile[@"data"][@"games"][@"quick"][@"played"];
                        quickTime = profile[@"data"][@"playtime"][@"quick"];
                        compWins = profile[@"data"][@"games"][@"competitive"][@"wins"];
                        compLost = [NSString stringWithFormat:@"%@",profile[@"data"][@"games"][@"competitive"][@"lost"]];
                        compPlayed = profile[@"data"][@"games"][@"competitive"][@"played"];
                        compTime = profile[@"data"][@"playtime"][@"competitive"];
                        avatar = profile[@"data"][@"avatar"];
                        rank = profile[@"data"][@"competitive"][@"rank"];
                        rankImg = profile[@"data"][@"competitive"][@"rank_img"];
                        levelFrame = profile[@"data"][@"levelFrame"];
                        star = profile[@"data"][@"star"];

                    }

                }
                
            }
            block(err);

        }] resume];
}
-(void)loadAchievementswithCompletion:(myCompletion)block{
    __block NSError *err = nil;
    NSString *requestString = [NSString stringWithFormat:@"https://api.lootbox.eu/%@/%@/%@/achievements",self.platform, self.region, self.battleTag];
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
                    self.achievements = [NSMutableDictionary dictionaryWithDictionary:dataDic];
                }
            }
        }
        block(err);
    }] resume];

}
@end
