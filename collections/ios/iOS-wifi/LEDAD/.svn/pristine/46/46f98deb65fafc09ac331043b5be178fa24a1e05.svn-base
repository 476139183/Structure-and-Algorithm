//
//  HeadView.m
//  QQ好友列表
//
//  Created by TianGe-ios on 14-8-21.
//  Copyright (c) 2014年 TianGe-ios. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "HeadView.h"
#import "Group.h"

@interface HeadView()
{
    UIButton *_bgButton;
    UILabel *_numLabel;
    
    
    
    UIButton *_upbutton;
    
    UIButton *_downbutton;
}
@end

@implementation HeadView

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";
    
    HeadView *headView = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[HeadView alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [bgButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [bgButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        _bgButton = bgButton;
        
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:numLabel];
        _numLabel = numLabel;
        
//      选择框
        UIButton *choosebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [choosebutton setBackgroundImage:[UIImage imageNamed:@"李文涛丑"] forState:UIControlStateNormal];
        [choosebutton setBackgroundImage:[UIImage imageNamed:@"选中框"] forState:UIControlStateSelected];
        choosebutton.imageView.clipsToBounds = NO;
        choosebutton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [choosebutton addTarget:self action:@selector(headbutchoose:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:choosebutton];
        _choose = choosebutton;
        
//        下载
        
        UIButton *upbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [upbutton setBackgroundImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
        upbutton.imageView.clipsToBounds = NO;
        upbutton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [upbutton addTarget:self action:@selector(downbutton) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:upbutton];
        _upbutton = upbutton;
        
        
//        上传upbutton
        
        UIButton *downbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [downbutton setBackgroundImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
        downbutton.imageView.clipsToBounds = NO;
        downbutton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [downbutton addTarget:self action:@selector(upbutton) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:downbutton];
        _downbutton = downbutton;

        
        
    }
    return self;
}

- (void)headBtnClick
{
    _group.opened = !_group.isOpened;
    if ([_delegate respondsToSelector:@selector(clickHeadView:)]) {
        [_delegate clickHeadView:self.mytag];
    }
}



//勾
-(void)headbutchoose:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.qchek = sender.selected;
    if ([self.delegate respondsToSelector:@selector(chooseview:andchoose:)]) {
        [self.delegate chooseview:self.mytag andchoose:sender.selected];
    }
    
}


//上传
-(void)upbutton
{
    if ([self.delegate respondsToSelector:@selector(uploadview:)]) {
        [self.delegate uploadview:self.mytag];
    }

}
//下载
-(void)downbutton
{
    if ([self.delegate respondsToSelector:@selector(downloadview:)]) {
        [self.delegate downloadview:self.mytag];
    }
    


}


- (void)setGroup:(Group *)group
{
    _group = group;
    
    [_bgButton setTitle:group.Grouping_Name forState:UIControlStateNormal];
}

- (void)didMoveToSuperview
{
    _bgButton.imageView.transform = _group.isOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgButton.frame = self.bounds;
    
    _numLabel.frame = CGRectMake(self.frame.size.width - 70, 0, 60, self.frame.size.height);
    
    _downbutton.frame = CGRectMake(self.bounds.size.width-40, (self.frame.size.height-30)/2, 30, 30);
    
    
    _upbutton.frame = CGRectMake(_downbutton.frame.origin.x-40, _downbutton.frame.origin.y, 30, 30);
    
    _choose.frame = CGRectMake(_upbutton.frame.origin.x - 40, _upbutton.frame.origin.y, 30, 30);
    _choose.selected = self.qchek;
    
//    是本地项目
    if (self.mytag>=2000&&self.mytag<3000) {
        _upbutton.hidden = YES;
        _choose.hidden = YES;
    }
    
//    移动 ☑️
    if (self.mytag>=3000) {
         _upbutton.hidden = YES;
        _downbutton.hidden = YES;
        _choose.frame = CGRectMake(self.bounds.size.width-40, (self.frame.size.height-30)/2, 30, 30);
        
    }
    
    
}

@end
