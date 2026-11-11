//
//  DYT_userTableViewCell.m
//  LEDAD
//
//  Created by laidiya on 15/8/5.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_userTableViewCell.h"
#import <CoreText/CoreText.h>
#import "DYT_textandpic.h"
@implementation DYT_userTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

    }

    return self;
}


-(void)setDatastring:(NSString *)datastring
{

    
    DLog(@"获取数据=====%@",datastring);

    _datastring = datastring;
    
    NSArray *arrar = [datastring componentsSeparatedByString:@">"];
    
    NSMutableArray *data = [[NSMutableArray alloc]init];
    for (int i = 0; i<arrar.count; i++) {
        NSArray *one = [arrar[i] componentsSeparatedByString:@"<"];
        DLog(@"截取的东西＝＝＝＝%@",one);
    }
    
//    for (int i=0; i<arrar.count; i++) {
//        
//        DYT_textandpic *pic = [[DYT_textandpic alloc]init];
//        NSArray *one = [arrar[i] componentsSeparatedByString:@"<"];
//        
//        pic.name = arrar[0];
//        DLog(@"数组======%@",pic.name);
//        if (one.count==1) {
//            
//            pic.picname = @"";
//        }else
//        {
//            
//        pic.picname = one.lastObject;
//            DLog(@"======%@",pic.picname);
//        }
//        [data addObject:pic];
//    }

    

    NSInteger hei = 0;
//
//    for (int i=0; i<data.count; i++) {

        
//         DYT_textandpic *pic = data[i];
//        DLog(@"我要的数据 === %@",pic.name);

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, hei, 0, 0)];
        label.numberOfLines = 0;
         label.font = [UIFont systemFontOfSize:13];
        label.lineBreakMode = UILineBreakModeCharacterWrap;
        
        CGSize size = [datastring sizeWithFont:label.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        //    根据计算结果重新设置UILabel的尺寸
        [label setFrame:CGRectMake(0, hei,self.frame.size.width, size.height)];
        label.text = datastring;
        DLog(@"显示的数据===%@",label.text);
        [self.contentView addSubview:label];
         hei = label.frame.origin.y+label.frame.size.height;
//        if ([pic.picname isEqualToString:@""]) {
//            
//        }else
//        {
//           
//            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, label.frame.origin.y+label.frame.size.height, self.frame.size.width, 100)];
//            DLog(@"有图片===%@",pic.picname);
//            image.image = [UIImage imageNamed:pic.picname];
//            image.backgroundColor = [UIColor redColor];
//            [self.contentView addSubview:image];
//            
//            hei = image.frame.origin.y+image.frame.size.height;
//        }
//    }
}











-(void)setMymodel:(DYT_usermodel *)mymodel

{

    DLog(@"====%@",mymodel.titel);
    
//    _mymodel = mymodel;
    
//    self.mymodel = mymodel;
    
    if (_mymodel != mymodel) {
        _mymodel = nil;
        _mymodel = mymodel;
    }
    


//    标题
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width, 50)];
    title.text = mymodel.titel;
    title.textColor = [UIColor orangeColor];
    title.numberOfLines = 0;
//    title *font = [UIFont systemFontOfSize:13];

//    title.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:title];
    
//    文本
    
    UILabel *textlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, 0)];
    textlabel.numberOfLines = 0;
    textlabel.font = [UIFont systemFontOfSize:13];
//    textlabel.font = [UIFont fontWithName:@"Arial" size:13];
    
    
    NSString *str = mymodel.text;
    DLog(@"我的---%@",str);
    if (str == nil) {
        str=@"ff";
    }
    
    CGSize size = [str sizeWithFont:textlabel.font constrainedToSize:CGSizeMake(textlabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
//    根据计算结果重新设置UILabel的尺寸
    [textlabel setFrame:CGRectMake(0, 40,self.frame.size.width, size.height)];
    textlabel.text = str;

    
//    CGSize size = CGSizeMake(self.frame.size.width,2000);
//    
//    CGSize titleSize = [mymodel.text sizeWithFont:font constrainedToSize:CGSizeMake(textlabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
//    
//
    
    
//    CGSize labelsize = [mymodel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    
//    [textlabel setFrame:CGRectMake(0,0, titleSize.width, titleSize.height)];
    
    [self.contentView addSubview:textlabel];
    CGRect rect = mymodel.datasize;
    rect.size.height = title.frame.size.height+textlabel.frame.size.height;
    self.mymodel.datasize = rect;
    
    
}


@end
