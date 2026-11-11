//
//  MusicPickerTableViewController.h
//  LEDAD
//
//  Created by yixingman on 14-9-10.
//
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ASValueTrackingSlider.h"
@protocol MyMusicListSelectDelegate <NSObject>

@optional
-(void)selectedMuisc:(NSString *)mySelectedMediaItem andMusicName:(NSString *)sMyMusicName;
@end

@interface MusicPickerTableViewController : UITableViewController<AVAudioPlayerDelegate>


@property (nonatomic,assign) id<MyMusicListSelectDelegate> delegate;
@property (nonatomic,retain) NSMutableArray *myMusicItems;         //存放本地歌曲
@property (nonatomic,retain) AVAudioPlayer *myMusicPlayer;
-(void)playMusicWithPath:(NSString *)myPathString;
-(void)stopMusicPlayer;
/**
 *  重新加载音乐列表
 */
-(void)reloadMusicList;
@end
