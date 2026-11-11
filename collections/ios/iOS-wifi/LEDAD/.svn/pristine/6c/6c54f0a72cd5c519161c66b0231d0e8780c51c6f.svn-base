//
//  ProjectItemCell
//  LEDAD
//  项目列表的Cell
//  Created by yixingman on 8/21/14.
//  Copyright (c) 2014 yixingman. All rights reserved.
//


#import "ProjectItemCell.h"
#import "Config.h"


@implementation ProjectItemCell
@synthesize projectObject = _projectObject;
@synthesize delegate = _delegate;
@synthesize myCheckBoxOfIndexPath = _myCheckBoxOfIndexPath;
@synthesize iselectcell = _iselectcell;
-(ProjectListObject *)projectObject{
    return _projectObject;
}

-(void)setProjectObject:(ProjectListObject *)projectObject{
    @try {
        if (projectObject!=_projectObject) {
            [_projectObject release],_projectObject = nil;
            _projectObject = [projectObject retain];
            
            [_projectNameLabel setText:projectObject.project_name];
            [_projectObject setProject_indexpath:_myCheckBoxOfIndexPath];
            if ([_projectObject.project_list_type isEqualToString:IS_GROUP_XML]) {
                [_myCheckBox setHidden:YES];
            }else{
                [_myCheckBox setHidden:NO];
            }
            [_myCheckBox setSelected:projectObject.isSelected];
            
            [audioIndicatorView setHidden:(!projectObject.isIncludeMusic)];
            if (projectObject.isp) {
                [_myCheckBox setHidden:(!projectObject.isExist)];
                //判断是否存在
                [ExistIndicatorLable setHidden:(!projectObject.isExist)];
            }else{
                [ExistIndicatorLable setHidden:YES];
            }
        }

//        if (_iselectcell) {
//            _projectNameLabel.textColor = [UIColor redColor];
//        }
//        else
//        {
//            _projectNameLabel.textColor = [UIColor lightGrayColor];
//
//        }
    }
    @catch (NSException *exception) {
        DLog(@"项目列表项数据设置时出错 = %@",exception);
    }
    @finally {
        
    }
    
}

-(UIView*)getCellView{
    float cellViewHeight = [ProjectItemCell projectItemCellHeight];
    float cellViewWidth = 320.0f;
    
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,cellViewWidth,cellViewHeight)];
    
    float checkBoxWidth = cellViewWidth/4.0f;
    
    _projectNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, cellViewWidth - checkBoxWidth, cellViewHeight)];
    [_projectNameLabel setBackgroundColor:[UIColor clearColor]];
    if (_iselectcell) {
        _projectNameLabel.textColor = [UIColor redColor];
    }
    [cellView addSubview:_projectNameLabel];
    [_projectNameLabel release];

    CGRect myCheckBoxRect = CGRectMake(_projectNameLabel.frame.origin.x + _projectNameLabel.frame.size.width, 0, checkBoxWidth, cellViewHeight);
    _myCheckBox = [[QCheckBox alloc]initWithDelegate:self];
    [_myCheckBox setFrame:myCheckBoxRect];
    [_myCheckBox setTitle:@"" forState:UIControlStateNormal];
    [_myCheckBox setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_myCheckBox.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [cellView addSubview:_myCheckBox];
    [_myCheckBox release];
    
    audioIndicatorView = [[UIImageView alloc]initWithFrame:CGRectMake(cellViewWidth-45, 7, 30, 30)];
    [audioIndicatorView setImage:[UIImage imageNamed:@"audioIndicatorView.jpg"]];
    [cellView addSubview:audioIndicatorView];
    [audioIndicatorView setHidden:YES];
    
    
    //是否存在的表示符号
    ExistIndicatorLable = [[UILabel alloc]initWithFrame:CGRectMake(cellViewWidth/2+10, 7, 70, 20)];
    [ExistIndicatorLable setText:[Config DPLocalizedString:@"adedit_Published"]];
    ExistIndicatorLable.textColor=[UIColor cyanColor];
    [cellView addSubview:ExistIndicatorLable];
    [ExistIndicatorLable setHidden:YES];
    //audioImage.jpg
    return cellView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *cellView = [self getCellView];
        [self.contentView addSubview:cellView];
    }
    return self;
}

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    DLog(@"checkbox = %@,checkbox = %d",checkbox,checked);
    [_projectObject setIsSelected:checked];
    [_delegate didSelectedCheckBoxWithIndexPath:_myCheckBoxOfIndexPath checked:checked];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(float)projectItemCellHeight{
    return 44.0f;
}

-(void)dealloc{
    RELEASE_SAFELY(_delegate);
    RELEASE_SAFELY(_projectObject);
    [super dealloc];
}
@end
