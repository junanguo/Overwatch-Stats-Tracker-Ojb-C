//
//  ViewController.m
//  Overwatcher_API
//
//  Created by Junan Guo on 8/18/16.
//  Copyright © 2016 Junan Guo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *err = nil;
    WatcherPlayer *player = [[WatcherPlayer alloc] initWithBattleTag:@"NSError#1663" platform:PLAT_PC andRegion:REGION_US error:&err];
    // do error check here-- Remember to check for errors everytime you load something
    // Create a player with battletag NSError-xxxx, on platform pc, region us. Always start by initializing a WatcherPlayer instance
    
    [player loadPofilewithCompletion:^(NSError *result) {
        if (result == nil){
            NSLog(@"Profile.Name: %@", player.name);
            NSLog(@"Profile.Competitive Lost: %@", player.compLost);
            NSLog(@"Profile.Rank: %@", player.rank);
            // etc...
        }
    }];

    // Load Basic Profile of this player, including win/lose, level, rank, etc..
    
    [player loadAchievementswithCompletion:^(NSError *result) {
        if (result == nil){
          //  NSLog(@"Achievement: %@", player.achievements);
        }
    }];
    // Load achievements
    
    WatcherHeroStats *manager = [[WatcherHeroStats alloc] init]; // Instance of stats manager
    
    [manager getAllHeroStatsOfPlayer:player ofMode:MODE_COMP completion:^(NSError *err) {
        if (err == nil){
            NSLog(@"All Hero Stats: %@", manager.stats);
        }
    }];
    // Load the player's all hero stats in competitive mode
    
    [manager getHeroStatsOfPlayer:player ofHero:HERO_MERCY ofMode:MODE_QUICK completion:^(NSError *err) {
        if (err == nil){
            NSLog(@"Mercy: %@",manager.stats);
        }
    }];
    // Load the player's mercy stats in quick play mode

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
