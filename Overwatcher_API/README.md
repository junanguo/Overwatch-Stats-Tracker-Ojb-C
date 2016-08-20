# Overwatcher
An easy-to-use Objective-C class that provides a player's stats in Overwatch. This class supports all servers, platforms. This class wraps up the API provided by Lootbox.eu . 

**If you have made some awsome apps with this, feel free to tell me! I will feature your app here!**

## Overview
With Overwathcer, you can easily retrieve a player's stats with a few lines of codes. The stats include but not limited to (The full list can be found in the comment). 

### General
- Achievements
- Rank
- Level
- Win/lose in quick play mode and competitive mode
- Time played / game played
- Avatar / Frame

### Stats for All Heroes
The average stats of all heroes. This will get the player's average stats with **ANY** hero. 
- Cards
- Eliminations
- Solo Kills
- Death
and other 45 items

### Stats For a Specific Hero
The stats of a specific hero. This includes common stats like eliminations, death, winrate, etc., and other hero-specific stats like "Players Resurrected," "Blaster Kills, " etc. for mercy, or "Souls Consumed," etc. for reaper. 
Keep in mind that there are a large number of hero-specifice stats for each hero, sometimes there are more hero-specific stats than common stats.

## Usage
### installization
Simplily drag "Overwatcher_API" folder into your project, and you are good to go!
### General Usage
First, import the header file to your class.
```objc
#import "Overwatcher.h"
```
Normally, you should start by initializing a ```WatcherPlayer``` instance. ```WatcherPlayer``` collects a player's info like battletag, region, and platform.
For example: 

```objc    
WatcherPlayer *player = [[WatcherPlayer alloc] initWithBattleTag:@"Name#xxxx" platform:PLAT_PC andRegion:REGION_US error:&err]; 
```

Platforms and Regions are strings that are predefined as constants. Check ```w_Constant.h``` for all defined constants. 

Regions:

- REGION_US; // US/NA
- REGION_EU; // European
- REGION_KR; // Korean
- REGION_CN; // China
- REGION_GLB; // Global

Platforms

- PLAT_PC; //PC
- PLAT_PSN; // PSN
- PLAT_XBL; // XBOX

#Then, based on your need, you can load up diffent datas

**Profile**

To load profile 
```objc
    [player loadPofilewithCompletion:^(NSError *result) {
		if (result == nil){
        	// access data here...
        }
	}];
```
profile includes the following datas:
![alt tag](http://i.imgur.com/B3DnRrk.png)
after the  ```loadPofilewithCompletion``` , the property above will be populated. 

Just an example of how you should access the data. 
```objc
    [player loadPofilewithCompletion:^(NSError *result) {
		if (result == nil){
			NSLog(@"Name: %@", player.name);
            NSLog(@"Competitive Lost: %@", player.compLost);
            NSLog(@"Rank: %@", player.rank);
		}
	}];
```
It's highly recommended to access the data in the completion block, and check for errors before you access them.

**Achievement**
To load achievements:

```objc
    [player loadAchievementswithCompletion:^(NSError *result) {
    	if (result == nil){
        	NSLog(@"%@", player.achievements);
        }
    }];
```
Calling this method will populate a NSDictionary called achievements of the WatcherPlayer instance. The dictionary includes the image, description, catogory, and finish status of each achievement.

**All Hero Stats or Specific Hero Stats**
First, you should initialize a ```WatcherHeroStats``` manager.
```objc
WatcherHeroStats *manager = [[WatcherHeroStats alloc] init];
```
For all hero stats, simply call
```objc
    [manager getAllHeroStatsOfPlayer:player ofMode:MODE_QUICK completion:^(NSError *err) {
        if (err == nil){
            NSLog(@"%@", manager.stats);
        }
    }];
```
you should pass in an initialized WatcherPlayer object for the first parameter, and either MODE_QUICK(quick mode) or MODE_COMP (competitive mode) for the second parameter.
If all things work out correctly, a dictionary called stats of the ```WatcherHeroStats``` object will be populated. Access by ```manager.stats```
An example of the dictionary: 
```
{
    Cards = 164;
    DamageDone = "4,580,412";
    "DamageDone-Average" = "8,758";
    "DamageDone-MostinGame" = "31,298";
    Deaths = "6,046";
    "Deaths-Average" = "11.56";
    DefensiveAssists = "1,530";
    "DefensiveAssists-Average" = 3;
    "DefensiveAssists-MostinGame" = 29;
    Eliminations = "10,378";
    "Eliminations-Average" = "19.84";
    "Eliminations-MostinGame" = 74;
    EnvironmentalDeaths = 77;
    EnvironmentalKills = 76;
    FinalBlows = "4,581";
    "FinalBlows-Average" = "8.75";
    "FinalBlows-MostinGame" = 44;
    GamesPlayed = 523;
    GamesWon = 248;
    HealingDone = "1,598,984";
    "HealingDone-Average" = "3,057";
    "HealingDone-MostinGame" = "26,361";
    Medals = "1,579";
    "Medals-Bronze" = 464;
    "Medals-Gold" = 582;
    "Medals-Silver" = 533;
    MeleeFinalBlows = 67;
    "MeleeFinalBlows-Average" = "0.12";
    "MeleeFinalBlows-MostinGame" = 4;
    "Multikill-Best" = 5;
    Multikills = 171;
    ObjectiveKills = "5,371";
    "ObjectiveKills-Average" = "10.26";
    "ObjectiveKills-MostinGame" = 57;
    ObjectiveTime = "14:27:10";
    "ObjectiveTime-Average" = "01:39";
    "ObjectiveTime-MostinGame" = "06:05";
    OffensiveAssists = 346;
    "OffensiveAssists-Average" = 1;
    "OffensiveAssists-MostinGame" = 13;
    SoloKills = "1,031";
    "SoloKills-Average" = "1.97";
    "SoloKills-MostinGame" = 44;
    TeleporterPadsDestroyed = 7;
    TimePlayed = 129hours;
    TimeSpentonFire = "17:59:23";
    "TimeSpentonFire-Average" = "02:03";
    "TimeSpentonFire-MostinGame" = "12:29";
}
```

By the same token, you can easily get the data for a specific hero by calling:
```objc
    [manager getHeroStatsOfPlayer:player ofHero:HERO_MERCY ofMode:MODE_QUICK completion:^(NSError *err) {
        if (err == nil){
            NSLog(@"Mercy: %@",manager.stats);
        }
    }];
```
you should pass in player and mode like getting all hero stats. You just need to pass in one more parameter, "hero." Hero parameter are predefined strings like HERO_MERCY. you can find a list of all defined names in w_Constant.h
If all things work out correctly, a dictionary called stats of the ```WatcherHeroStats``` object will be populated. Access by ```manager.stats```
An example of the dictionary: 
```
{
    BlasterKills = 38;
    "BlasterKills-Average" = 0;
    "BlasterKills-MostinGame" = 4;
    Cards = 74;
    CriticalHitAccuracy = "6%";
    CriticalHits = 36;
    "CriticalHits-MostinGame" = 6;
    "CriticalHits-MostinLife" = 5;
    DamageDone = "11,070";
    "DamageDone-Average" = "94.51";
    "DamageDone-MostinGame" = 721;
    "DamageDone-MostinLife" = 416;
    Deaths = 776;
    "Deaths-Average" = "6.62";
    DefensiveAssists = "1,255";
    "DefensiveAssists-Average" = 11;
    "DefensiveAssists-MostinGame" = 31;
    Eliminations = 38;
    "Eliminations-Average" = "0.32";
    "Eliminations-MostinGame" = 4;
    "Eliminations-MostinLife" = 3;
    EliminationsperLife = "0.04";
    EnvironmentalDeaths = 14;
    "FinalBlow-MostinGame" = 1;
    FinalBlows = 15;
    "FinalBlows-Average" = "0.12";
    GamesPlayed = 117;
    GamesWon = 57;
    HealingDone = "611,518";
    "HealingDone-Average" = "5,220.93";
    "HealingDone-MostinGame" = "11,758";
    "HealingDone-MostinLife" = "8,009";
    "KillStreak-Best" = 3;
    Medals = 192;
    "Medals-Bronze" = 33;
    "Medals-Gold" = 120;
    "Medals-Silver" = 38;
    ObjectiveKills = 12;
    "ObjectiveKills-Average" = "0.1";
    "ObjectiveKills-MostinGame" = 2;
    ObjectiveTime = "59:04";
    "ObjectiveTime-Average" = "00:30";
    "ObjectiveTime-MostinGame" = "02:43";
    OffensiveAssists = 279;
    "OffensiveAssists-Average" = 2;
    "OffensiveAssists-MostinGame" = 11;
    PlayersResurrected = 493;
    "PlayersResurrected-Average" = "4.2";
    "PlayersResurrected-MostinGame" = 10;
    SelfHealing = "85,616";
    "SelfHealing-MostinGame" = "1,914";
    "SoloKill-MostinGame" = 1;
    SoloKills = 3;
    "SoloKills-Average" = "0.02";
    TimePlayed = 14hours;
    TimeSpentonFire = "01:46:50";
    WeaponAccuracy = "20%";
    WinPercentage = "48%";
}
```
As I mentioned before, there are many hero-specific stats. If you want to know what entries are in the dictionary, simply call ```[dictionary allKeys] ```

### Common Errors
It's possible to have some errors in the process, so it's highly recommended to check the NSError.
Here are some common errors

Code: -1        Error when initializing a WatcherPlayer object with empty parameters.

Code: 1         Internet connection error

Code: 2         Error while trying to achieve the data

Others    Errors returned by the server

## Contact
If you have any questions or suggestions, feel free to contact me at ijunanguo@gmail.com


## Permission
MIT


