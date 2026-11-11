//
//  GEGifView.h
//
//  Created by godera@yeah.net on 9/14/13.
//  Copyright (c) 2013. All rights reserved.
//
//  QQ: 719181178
/* supports both gif and image, based on SvGifView and OLImageView */
/* MRC */

#define KEY_FRAME_IMAGES @"KEY_FRAME_IMAGES"
#define KEY_FRAME_START_TIMES @"KEY_FRAME_START_TIMES"
#define KEY_GE_MEDIA_TYPE @"KEY_GE_MEDIA_TYPE"

#import "GEGifView.h"
#import <ImageIO/ImageIO.h>
#import <QuartzCore/CoreAnimation.h>

typedef enum {
    GEMediaType_GIF = 0,
    GEMediaType_IMAGE,
}GEMediaType;

@interface GEGifView()
{
    NSInteger _comparedFrameIndex;
    NSTimeInterval _currentTimePoint; // compared to item in _frameStartTimes
    
    CGFloat _width;
    CGFloat _height;
    
    NSInteger _decreasingCount;
    
    GEMediaType _mediaType;
    BOOL _canRestart;
    CADisplayLink* _displayLink;
    BOOL _addSubviewsOnce;
}
@property (retain, nonatomic) UIImageView* contentView; // frame container

@property (copy, nonatomic) NSArray* frameImages; // UIImages
@property (copy, nonatomic) NSArray* frameStartTimes; // the 0 frame corresponds to time point 0.

@end


@implementation GEGifView

- (void)dealloc
{
    [_runLoopMode release];
    
    [_contentView release];
    
    [_frameImages release];
    [_frameStartTimes release];
    
    [super dealloc];
}

-(void)willMoveToWindow:(UIWindow *)newWindow
{
    if (newWindow == nil) // at the moment the method like viewWillDisappear in view controller
    {
        if (_isAnimating)
        {
            [self stop];
            _canRestart = YES;
        }
    }
    else // at the moment the method like viewWillAppear in view controller
    {
        if (_canRestart)
        {
            _canRestart = NO;
            [self start];
        }
    }
}

-(void)addSubviewsOnce
{
    if (_addSubviewsOnce == YES) {
        return;
    }
    _addSubviewsOnce = YES;
        
    UIImageView* imageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self addSubview:imageView];
    self.contentView = imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubviewsOnce];
        
        self.userInteractionEnabled = NO;
        
        _runLoopMode = NSDefaultRunLoopMode;
        
        _clearWhenStop = YES;
        
        _comparedFrameIndex = 0;
        
        _width = 0;
        _height = 0;
        
        _repeatCount = NSUIntegerMax;
    }
    return self;
}

#pragma mark - data source init methods
-(id)initWithData:(NSData *)data
{
    self = [self init];
    
    [self setData:data];
    
    return self;
}

-(id)initWithFileName:(NSString *)fileName
{
    self = [self init];
    
    [self setFileName:fileName];
    
    return self;
}

-(id)initWithFilePath:(NSString *)filePath
{
    self = [self init];

    [self setFilePath:filePath];
    
    return self;
}

-(id)initWithFrameItems:(NSDictionary *)frameItems
{
    self = [self init];

    [self setFrameItems:frameItems];

    return self;
}

#pragma mark - data source setters
-(void)setData:(NSData *)data
{
    CGImageSourceRef gifSource = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    
    [self getFrameInfosFromGifSource:gifSource];
    
    if (gifSource) {
        CFRelease(gifSource);
    }
}

-(void)setFileName:(NSString *)fileName
{
    NSString *filePath = nil;
    if ([fileName hasSuffix:@".gif"]) {
        filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:nil];
    }else{
        filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"gif"];
    }
    
    [self setFilePath:filePath];
}

-(void)setFilePath:(NSString *)filePath
{    
    NSURL* fileURL = [NSURL fileURLWithPath:filePath];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileURL, NULL);
    
    [self getFrameInfosFromGifSource:gifSource];
    
    if (gifSource) {
        CFRelease(gifSource);
    }
}

-(void)setFrameItems:(NSDictionary *)frameItems
{
    self.frameImages = [frameItems objectForKey:KEY_FRAME_IMAGES];
    self.frameStartTimes = [frameItems objectForKey:KEY_FRAME_START_TIMES];
    _mediaType = (GEMediaType)[[frameItems objectForKey:KEY_GE_MEDIA_TYPE] integerValue];
}

-(NSDictionary *)frameItems
{
    return @{KEY_FRAME_IMAGES:_frameImages, KEY_FRAME_START_TIMES:_frameStartTimes, KEY_GE_MEDIA_TYPE:@(_mediaType)};
}

#pragma mark - gif information getter
/*
 * @brief gets gif information
 */
- (void)getFrameInfosFromGifSource:(CGImageSourceRef)gifSource
{
    // get frame count
    size_t frameCount = CGImageSourceGetCount(gifSource);
    
    if (frameCount <= 1)
    {
        _mediaType = GEMediaType_IMAGE;
        
        CGImageRef frameCG = CGImageSourceCreateImageAtIndex(gifSource, 0, NULL);
        UIImage* frame = [[UIImage alloc] initWithCGImage:frameCG];
        CGImageRelease(frameCG);
        self.contentView.image = frame;
        [frame release];
        
        // copy values
        self.frameImages = @[frame];
        self.frameStartTimes = @[@(0),@(CGFLOAT_MAX)];
        return;
    }
    
    _mediaType = GEMediaType_GIF;
    // init
    NSMutableArray* frameImages = [NSMutableArray new];
    NSMutableArray* frameStartTimes = [NSMutableArray new];
    NSMutableArray* frameDelayTimes = [NSMutableArray new];
    
    for (size_t i = 0; i < frameCount; ++i)
    {
        // get each frame
        CGImageRef frameCG = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage* frame = [[UIImage alloc] initWithCGImage:frameCG];
        CGImageRelease(frameCG);
        [frameImages addObject:frame];
        [frame release];
        
        // get gif info with each frame
        NSDictionary *dict = (NSDictionary*)CGImageSourceCopyPropertiesAtIndex(gifSource, i, NULL);
        GELOG_GIF(@"kCGImagePropertyGIFDictionary %ld = %@", i,[dict objectForKey:(NSString*)kCGImagePropertyGIFDictionary]);
        
        // get gif size
        _width = [[dict objectForKey:(NSString*)kCGImagePropertyPixelWidth] floatValue];
        _height = [[dict objectForKey:(NSString*)kCGImagePropertyPixelHeight] floatValue];
        
        // kCGImagePropertyGIFDictionary中kCGImagePropertyGIFDelayTime，kCGImagePropertyGIFUnclampedDelayTime值是一样的
        NSDictionary *gifDict = [dict objectForKey:(NSString*)kCGImagePropertyGIFDictionary];
        
        id aDelayTime = [gifDict objectForKey:(NSString*)kCGImagePropertyGIFDelayTime];
        [frameDelayTimes addObject:aDelayTime];
        
        CFRelease(dict);
    }
    
    // get frame start times
    [frameStartTimes addObject:@(0)];
    CGFloat currentFrameStartTime = 0;
    for (id aDelayTime in frameDelayTimes)
    {
        currentFrameStartTime += [aDelayTime floatValue];
        [frameStartTimes addObject:@(currentFrameStartTime)];
    }
    
    [frameDelayTimes release];
    
    // copy values
    self.frameImages = frameImages;
    [frameImages release];
    self.frameStartTimes = frameStartTimes;
    [frameStartTimes release];
}

- (void)changeFrame:(CADisplayLink*)displayLink
{
    _currentTimePoint += displayLink.duration;
    
    GELOG_GIF(@"time point = Current:%f--%f:Compared",_currentTimePoint,[_frameStartTimes[_comparedFrameIndex] doubleValue]);
    
    if (_currentTimePoint >= [_frameStartTimes[_comparedFrameIndex] doubleValue])
    {
        if (_comparedFrameIndex >= _frameImages.count) // one loop
        {
            if (_repeatCount != NSUIntegerMax)
            {
                _decreasingCount --;
                if (_decreasingCount == 0)
                {
                    [self stop];
                    return;
                }
            }
            _comparedFrameIndex = 0;
            _currentTimePoint = 0;
        }
        self.contentView.image = _frameImages[_comparedFrameIndex];
        _comparedFrameIndex ++; // next compared frame index
    }
}

- (void)start
{
    if ([self isPreparedToPlay] == NO)
    {
        return;
    }
    
    if (_mediaType == GEMediaType_IMAGE)
    {
        self.contentView.image = _frameImages[0];
        return;
    }
    
    if (_displayLink.paused == YES) // recover from pause state
    {
        _displayLink.paused = NO;
    }
    else // a new start
    {
        _currentTimePoint = 0;
        _decreasingCount = _repeatCount;
        
        self.contentView.image = _frameImages[0];
        _comparedFrameIndex = 1;
        
        [_displayLink invalidate];
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeFrame:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:_runLoopMode];
    }
    
    _isAnimating = YES;
}

- (void)stop
{
    if (_mediaType == GEMediaType_IMAGE)
    {
        if (_clearWhenStop)
        {
            self.contentView.image = nil;
        }
        return;
    }
    
    [_displayLink invalidate];
    _displayLink = nil;
    
    if (_clearWhenStop)
    {
        self.contentView.image = nil;
    }
    
    _isAnimating = NO;
}

- (void)pause
{
    if (_mediaType == GEMediaType_IMAGE)
    {
        return;
    }
    
    _displayLink.paused = YES;
    _isAnimating = NO;
}

-(CGFloat)duration
{
    return [[_frameStartTimes lastObject] floatValue];
}

-(void)setImage:(UIImage *)image
{
    self.contentView.image = image;
}

-(UIImage *)image
{
    return self.contentView.image;
}

-(BOOL)isPreparedToPlay
{
    return self.frameImages && self.frameStartTimes;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"repeat count = %ld, frame count = %lu, frame items = %@", (long)_repeatCount, (unsigned long)_frameImages.count, [self frameItems]];
}

@end


