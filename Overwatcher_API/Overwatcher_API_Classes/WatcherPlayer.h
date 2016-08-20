//
//  WatcherUser.h
//  Overwatcher_API
//
//  Created by Junan Guo on 8/18/16.
//  Copyright © 2016 Junan Guo. All rights reserved.
//




#import <Foundation/Foundation.h>
typedef void(^myCompletion)(NSError *result);

@interface WatcherPlayer : NSObject
@property (nonatomic,retain) NSString *battleTag;
@property (nonatomic,retain) NSString *platform;
@property (nonatomic,retain) NSString *region;

// Player Info

@property (nonatomic, retain) NSString *name; // user name
@property (nonatomic, retain) NSString *rank; // rank of this season
@property (nonatomic, retain) NSString *rankImg; // image of the rank icon
@property (nonatomic, retain) NSString *levelFrame; // the portrait of current level ( image link )
@property (nonatomic, retain) NSString *star; // the stars of current level ( image link )
@property (nonatomic, retain) NSString *quickWins; // number of wins in quick play mode
@property (nonatomic, retain) NSString *quickPlayed; // number of games played in quick play mode
@property (nonatomic, retain) NSString *quickTime; // time played in quick play mode
@property (nonatomic, retain) NSString *compWins; // number of wins in competitive mode
@property (nonatomic, retain) NSString *compPlayed; // number of games played in competitive mode
@property (nonatomic, retain) NSString *compTime; // time played in cometitive mode
@property (nonatomic, retain) NSString *avatar; // the player's icon ( image link )
@property (nonatomic, assign) NSString *level; // level
@property (nonatomic, retain) NSString *quickLost; // number of games lost in quick play mode
@property (nonatomic, retain) NSString *compLost; // number of games lost in competitive mode

@property (nonatomic, retain) NSDictionary *achievements;


-(id)initWithBattleTag:(NSString*)tag platform:(NSString*)plt andRegion:(NSString*)reg error:(NSError**)err;
-(void)loadPofilewithCompletion:(myCompletion)block;
-(void)loadAchievementswithCompletion:(myCompletion)block;
@end
