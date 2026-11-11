//
//  MusicPickerTableViewController.m
//  LEDAD
//
//  Created by yixingman on 14-9-10.
//
//
#define TAG_MUSIC_CELL 800990
#define TAG_BUTTON_OFFSET 100000

#import "MusicPickerTableViewController.h"
#import "Config.h"



@interface MusicPickerTableViewController ()

@end

@implementation MusicPickerTableViewController
@synthesize delegate;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MusicCellIdentifier"];
    self.myMusicItems = [[NSMutableArray alloc]init];
    //监听歌曲播放完成的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMusicList) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:nil];
    [self initMusicItems];
}


#pragma mark - Private Method
-(void)initMusicItems{
    @try {
        if (!self.myMusicItems) {
            self.myMusicItems = [[NSMutableArray alloc]init];
        }
        [self.myMusicItems removeAllObjects];
        NSFileManager *myFileManager = [NSFileManager defaultManager];
        NSString *musicDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectMusic/"];
        NSArray *musicSubfileArray = [myFileManager contentsOfDirectoryAtPath:musicDirectory error:nil];
        if (!musicSubfileArray) {
            return;
        }
        for (NSString *musicNameString in musicSubfileArray) {
            NSString *musicAllPath = [[NSString alloc]initWithFormat:@"%@/%@",musicDirectory,musicNameString];
            DLog(@"musicAllPath = %@",musicAllPath);
            [self.myMusicItems addObject:musicAllPath];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadMusicList{
    [self initMusicItems];
    //音乐播放完成刷新table
    [self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myMusicItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MusicCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *musicPathString = self.myMusicItems[indexPath.row];
    //歌曲名
    NSString *musicName = nil;
    //专辑封面
    UIImage *img = nil;
    NSURL *url = [[NSURL alloc]initFileURLWithPath:musicPathString];
    AVAsset *myMusicAsset  = [AVAsset assetWithURL:url];
    for (AVMutableMetadataItem *myItem in [myMusicAsset commonMetadata]) {
        if ([[myItem commonKey] isEqualToString:@"title"]) {
            musicName = [[NSString alloc]initWithFormat:@"%@",[myItem value]];
        }
        if ([[myItem commonKey] isEqualToString:@"artwork"]) {
            img = [[UIImage alloc]initWithData:[myItem dataValue]];
        }
    }
    
    
    if (!img) {
        img = [UIImage imageNamed:@"musicImage.png"];
    }
    if (!musicName) {
        musicName = [musicPathString lastPathComponent];
    }
    cell.imageView.image = img;
    cell.textLabel.text = musicName; //歌曲名称
    [cell setTag:(TAG_MUSIC_CELL+indexPath.row)];

    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    UISwipeGestureRecognizer *mySwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeShowDelButton:)];
    [mySwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [cell addGestureRecognizer:mySwipe];
    return cell;
}

-(void)swipeShowDelButton:(UISwipeGestureRecognizer *)myGesture{
    UIButton *delButton = [[UIButton alloc]init];
    [delButton setTitle:[Config DPLocalizedString:@"adedit_musicdelbutton"] forState:UIControlStateNormal];
    [delButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [delButton setBackgroundImage:[UIImage imageNamed:@"redbutton_background"] forState:UIControlStateNormal];
    NSInteger iDelButton = 60;
    [delButton setFrame:CGRectMake(myGesture.view.frame.size.width - iDelButton, 0, iDelButton, myGesture.view.frame.size.height)];
    [delButton setTag:(myGesture.view.tag-TAG_BUTTON_OFFSET)];
    [delButton addTarget:self action:@selector(delButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myGesture.view addSubview:delButton];
    [delButton release];
    NSLog(@"%@",myGesture.view);
}

-(void)delButtonClicked:(UIButton *)sender{
    NSInteger indexOfMusicItems = (sender.tag - (TAG_MUSIC_CELL-TAG_BUTTON_OFFSET));
     NSString *musicPathString = self.myMusicItems[indexOfMusicItems];
    NSFileManager *myFileMgr = [NSFileManager defaultManager];
    [myFileMgr removeItemAtPath:musicPathString error:nil];
    [self.myMusicItems removeObjectAtIndex:indexOfMusicItems];
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消删除按钮
    [[self.view viewWithTag:(TAG_MUSIC_CELL-TAG_BUTTON_OFFSET+indexPath.row)] removeFromSuperview];

    NSString *musicPathString = self.myMusicItems[indexPath.row];
    NSString *musicName = nil;
    NSURL *url = [[NSURL alloc]initFileURLWithPath:musicPathString];
    AVAsset *myMusicAsset  = [AVAsset assetWithURL:url];
    
    for (AVMutableMetadataItem *myItem in [myMusicAsset commonMetadata]) {
        DLog(@"%@",[myItem commonKey]);
        if ([[myItem commonKey] isEqualToString:@"title"]) {
            musicName = [[NSString alloc]initWithFormat:@"%@",[myItem value]];
        }
    }
    if (!musicName) {
        musicName = [musicPathString lastPathComponent];
    }
//    DLog(@"%@ = %lf",musicName,[myMusicAsset duration]);
    
    [self playMusicWithPath:musicPathString];
    
    [self.delegate selectedMuisc:musicPathString andMusicName:musicName];
    
//    [self.tableView reloadData];
}

-(void)stopMusicPlayer{
    [self.myMusicPlayer stop];
    [self.myMusicPlayer setCurrentTime:100000];
}

-(void)playMusicWithPath:(NSString *)myPathString{
    if (!myPathString) {
        return;
    }
    NSURL *url = [[NSURL alloc]initFileURLWithPath:myPathString];
    DLog(@"myPathString = %@",myPathString);
    [self.myMusicPlayer stop];
    [self.myMusicPlayer setCurrentTime:100000];
    AVAudioPlayer *myAVAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.myMusicPlayer = myAVAudioPlayer;
    [myAVAudioPlayer prepareToPlay];
    myAVAudioPlayer.enableRate = YES;
    myAVAudioPlayer.meteringEnabled = YES;
    myAVAudioPlayer.delegate = self;
    [myAVAudioPlayer play];
}

-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    DLog(@"开始播放 = %@",[player url]);
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    DLog(@"完成播放 = %@",[player url]);
}

-(void)dealloc{
    RELEASE_SAFELY(self.myMusicItems);
    [super dealloc];
}

@end
