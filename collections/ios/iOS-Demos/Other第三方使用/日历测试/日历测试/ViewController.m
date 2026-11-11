//
//  ViewController.m
//  日历测试
//
//  Created by Yutian Duan on 16/5/12.
//  Copyright © 2016年 Yutian Duan. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+WQCalendarLogic.h"
#import "CalendarDayModel.h"
#import "TopicItemHeader.h"

@interface ViewController () < UICollectionViewDelegate, UICollectionViewDataSource> {
  NSMutableArray *calendarMonth;
  /// 今天的日期
  NSDate *today;
  /// 今天某某日之后的日期
  NSDate *before;
  /// 选择的日期
  NSDate *select;
  
  CalendarDayModel *selectcalendarDay;
  
  CGFloat wid;
  
  NSInteger dataIndex;
}
@property (nonatomic, strong)  UICollectionView *dataCollectionView;
@end

@implementation ViewController

static NSString *const MonthHeader = @"MonthHeaderView";

static NSString *const DayCell = @"DayCell";

- (void)viewDidLoad {
  [super viewDidLoad];
  
  dataIndex = 0;
  NSArray *day = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
  
  wid = self.view.frame.size.width/(day.count +1);
  
  // 最好是直接给图片<不然要用第三方才好显示竖起来的文字,比如yykit>
  UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wid, wid)];
  title.backgroundColor = [UIColor redColor];
  [self.view addSubview:title];
  
  // 日期
  for (int i = 0; i < day.count; i++) {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(wid+wid*i, 0, wid, wid)];
    label.text = day[i];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
  }
  
  // 周次
  /*
   写一个方法 判断下上 下 学期 以及上学日期，这样再判断今天和最近的上学日期相差多少周,就ok了
   */
  for (int i = 0; i < 6; i++) {
    UILabel *week = [[UILabel alloc] initWithFrame:CGRectMake(0, wid+wid*i+30, wid, wid)];
    [self.view addSubview:week];
    week.textAlignment = NSTextAlignmentCenter;
    week.textColor = [UIColor blackColor];
    /* 周次判断需要写一个方法 */
    week.text = [NSString stringWithFormat:@"%d",i+10];
  }
  /*UICollectionView 的布局*/
  
  calendarMonth = [[NSMutableArray alloc] init];
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  
  // 每一个UICollectionView 的cell的大小
  layout.itemSize = CGSizeMake(wid - 10, wid);
  
  // 每一个段头的大小
  layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 30);
  
  // UICollectionView 的初始化
  _dataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(wid, wid, self.view.frame.size.width - wid , self.view.frame.size.width) collectionViewLayout:layout];
  [self.view addSubview:_dataCollectionView];
  
  _dataCollectionView.delegate = self;
  _dataCollectionView.dataSource = self;
  
  // UICollectionView 注册cell
  [_dataCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:DayCell];
  
  // UICollectionView 注册段头
  [_dataCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
  
  _dataCollectionView.backgroundColor = [UIColor whiteColor];
  
  
  /*--------------
   数据的获取
   */
  
  // 获取月份数<包含了每个月的日期数> －－－－从这个方法入手就ok了 365或者366
  calendarMonth = [self getMonthArrayOfDayNumber:365 ToDateforString:nil];
  
  // 刷新列表
  [_dataCollectionView reloadData];
  
}


#pragma mark-
/*
 都只是简单的实现一下,具体的话，可以让只显示一个月,点击段头，获取calendarMonth.count中你想要的某一个月的数据,
 
 
 
 */

//定义展示的Section的个数<月数>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

//定义展示的UICollectionViewCell的个数<日起数>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  NSMutableArray *monthArray = [calendarMonth objectAtIndex:dataIndex];
  return monthArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
  // 根据section 取出月份
  NSMutableArray *monthArray = [calendarMonth objectAtIndex:dataIndex];
  
  // 根据row 从月份去除 日期model
  CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
  
  [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
  UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
  label.text = [NSString stringWithFormat:@"%ld月%lu",model.month,(unsigned long)model.day];
  label.font = [UIFont systemFontOfSize:11.0f];
  [cell.contentView addSubview:label];
  cell.backgroundColor = [UIColor whiteColor];
  
  switch (model.style) {
    case CellDayTypeEmpty: {
      // 不显示的时间
      label.textColor = [UIColor lightGrayColor];
    }
      break;
      
    case CellDayTypePast: {
      // 截止今天过去的日期
      label.textColor = [UIColor orangeColor];
    }
      break;
    case CellDayTypeFutur: {
      // 截止今天还没有过去的时间
      label.textColor = [UIColor blackColor];
    }
      break;
    case CellDayTypeClick: {
      // 今天
      cell.backgroundColor = [UIColor blueColor];
    }
    default:
      break;
  }
  
  return cell;
}

/**
 *  返回段头
 *
 *  @param collectionView collectionview
 *  @param kind           段头还是段尾
 *  @param indexPath      indexpath
 *
 *  @return 一个view
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  
  UICollectionReusableView *reusableView = nil;
  
  if (kind == UICollectionElementKindSectionHeader){
    TopicItemHeader *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader forIndexPath:indexPath];
    NSMutableArray *month_Array = [calendarMonth objectAtIndex:dataIndex];
    CalendarDayModel *model = [month_Array objectAtIndex:15];
    NSString *data = [NSString stringWithFormat:@"%zd年 %zd月",model.year,model.month];//@"日期";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wid * 7, 30)];
    label.backgroundColor = [UIColor orangeColor];
    label.text = data;
    [monthHeader addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    reusableView = monthHeader;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    button.backgroundColor = [UIColor redColor];
    button.tag = indexPath.row;
    [button addTarget:self action:@selector(clickleft:) forControlEvents:UIControlEventTouchUpInside];
    [monthHeader addSubview:button];
    
    UIButton *rigth = [[UIButton alloc] initWithFrame:CGRectMake(label.frame.size.width - 30, 0, 30, 30)];
    [monthHeader addSubview:rigth];
    rigth.backgroundColor = [UIColor blueColor];
    [rigth addTarget:self action:@selector(clickrigth) forControlEvents:UIControlEventTouchUpInside];
    
  }
  return reusableView;
}

- (void)clickleft:(UIButton *)sender {
  if (dataIndex == 0) {
    return;
  }
  dataIndex--;
  [_dataCollectionView reloadData];
  // 同时需要跟新周次
}

- (void)clickrigth {
  if (dataIndex == calendarMonth.count -1) {
    return;
  }
  dataIndex++;
  [_dataCollectionView reloadData];
  // 同时需要跟新周次
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma 以下所有方法都是判断日期的一些数据

/**
 *  第一步 获取时间段内的天数数组
 *
 *  @param day    从今天开始往后推算多少天
 *  @param todate nil
 *
 *  @return 包含日期数的月份数组
 */
- (NSMutableArray *)getMonthArrayOfDayNumber:(int)day ToDateforString:(NSString *)todate {
  NSDate *date = [NSDate date];
  NSDate *selectdate  = [NSDate date];
  
  return [self reloadCalendarView:date selectDate:selectdate  needDays:day];
}


/**
 *  第二步 计算当前日期之前几天或者是之后的几天（负数是之前几天，正数是之后的几天）
 *
 *  @param date        当天
 *  @param selectdate  默认选择日期
 *  @param days_number 计算它以后的时间
 *
 *  @return 同第一步
 */
- (NSMutableArray *)reloadCalendarView:(NSDate *)date  selectDate:(NSDate *)selectdate needDays:(int)days_number {
  //如果为空就从当天的日期开始
  if(date == nil){
    date = [NSDate date];
  }
  
  //默认选择中的时间
  if (selectdate == nil) {
    selectdate = date;
  }
  
  today = date;//起始日期
  
  before = [date dayInTheFollowingDay:days_number];//计算它days天以后的时间
  
  select = selectdate;//选择的日期
  
  /// 获取今天 年月日对象
  NSDateComponents *todayDC= [today YMDComponents];
  
  /// 获取今天之后的days_number的 年月日对象
  NSDateComponents *beforeDC= [before YMDComponents];
  
  NSInteger todayYear = todayDC.year;
  
  NSInteger todayMonth = todayDC.month;
  
  NSInteger beforeYear = beforeDC.year;
  
  NSInteger beforeMonth = beforeDC.month;
  
  NSInteger months = (beforeYear-todayYear) * 12 + (beforeMonth - todayMonth);
  
  NSMutableArray *calendarMonth = [[NSMutableArray alloc]init];//每个月的dayModel数组
  
  for (int i = 0; i <= months; i++) {
    
    NSDate *month = [today dayInTheFollowingMonth:i];
    
    NSMutableArray *calendarDays = [[NSMutableArray alloc]init];
    
    /// 计算上月份的天数
    [self calculateDaysInPreviousMonthWithDate:month andArray:calendarDays];
    
    /// 计算当月的天数
    [self calculateDaysInCurrentMonthWithDate:month andArray:calendarDays];
    
    /// 计算下月份的天数
    [self calculateDaysInFollowingMonthWithDate:month andArray:calendarDays];
    
    [calendarMonth insertObject:calendarDays atIndex:i];
  }
  
  return calendarMonth;
  
}


#pragma mark - 日历上+当前+下月份的天数<再第二步 for循环 里调用的方法>

/// 第二步（1） 计算上月份的天数
- (NSMutableArray *)calculateDaysInPreviousMonthWithDate:(NSDate *)date andArray:(NSMutableArray *)array {
  NSUInteger weeklyOrdinality = [[date firstDayOfCurrentMonth] weeklyOrdinality];//计算这个的第一天是礼拜几,并转为int型
  NSDate *dayInThePreviousMonth = [date dayInThePreviousMonth];//上一个月的NSDate对象
  NSUInteger daysCount = [dayInThePreviousMonth numberOfDaysInCurrentMonth];//计算上个月有多少天
  NSUInteger partialDaysCount = weeklyOrdinality - 1;//获取上月在这个月的日历上显示的天数
  NSDateComponents *components = [dayInThePreviousMonth YMDComponents];//获取年月日对象
  
  for (int i = daysCount - partialDaysCount + 1; i < daysCount + 1; ++i) {
    // 拿到上月的日期model
    CalendarDayModel *calendarDay = [CalendarDayModel calendarDayWithYear:components.year month:components.month day:i];
    //    calendarDay.style = CellDayTypeEmpty;//不显示
    [array addObject:calendarDay];
  }
  
  
  return NULL;
}

/// 第二步（2） 计算当月的天数
- (void)calculateDaysInCurrentMonthWithDate:(NSDate *)date andArray:(NSMutableArray *)array {
  
  NSUInteger daysCount = [date numberOfDaysInCurrentMonth];//计算这个月有多少天
  NSDateComponents *components = [date YMDComponents];//今天日期的年月日
  
  for (int i = 1; i < daysCount + 1; ++i) {
    // 拿到当月的日期model
    CalendarDayModel *calendarDay = [CalendarDayModel calendarDayWithYear:components.year month:components.month day:i];
    
    calendarDay.week = [[calendarDay date]getWeekIntValueWithDate];
    //    农历转换函数
    [self LunarForSolarYear:calendarDay];
    
    [self changStyle:calendarDay];
    [array addObject:calendarDay];
  }
}

/// 第二步（3） 计算下月份的天数
- (void)calculateDaysInFollowingMonthWithDate:(NSDate *)date andArray:(NSMutableArray *)array {
  NSUInteger weeklyOrdinality = [[date lastDayOfCurrentMonth] weeklyOrdinality];
  if (weeklyOrdinality == 7) return ;
  
  NSUInteger partialDaysCount = 7 - weeklyOrdinality;
  NSDateComponents *components = [[date dayInTheFollowingMonth] YMDComponents];
  
  for (int i = 1; i < partialDaysCount + 1; ++i) {
    
    // 拿到下月的日期model
    CalendarDayModel *calendarDay = [CalendarDayModel calendarDayWithYear:components.year month:components.month day:i];
    calendarDay.style = CellDayTypeEmpty;
    [array addObject:calendarDay];
  }
}



#pragma mark - 农历转换函数
/**
 *  农历转换函数
 *
 *  @param calendarDay calendarDay description
 */
- (void)LunarForSolarYear:(CalendarDayModel *)calendarDay {
  
  NSString *solarYear = [self LunarForSolarYear:calendarDay.year Month:calendarDay.month Day:calendarDay.day];
  
  NSArray *solarYear_arr = [solarYear componentsSeparatedByString:@"-"];
  
  if([solarYear_arr[0]isEqualToString:@"正"]
     && [solarYear_arr[1]isEqualToString:@"初一"]) {
    
    //正月初一：春节
    calendarDay.holiday = @"春节";
    
  } else if ([solarYear_arr[0]isEqualToString:@"正"]
             && [solarYear_arr[1]isEqualToString:@"十五"]) {
    
    //正月十五：元宵节
    calendarDay.holiday = @"元宵";
    
  } else if ([solarYear_arr[0]isEqualToString:@"二"]
             && [solarYear_arr[1]isEqualToString:@"初二"]) {
    //二月初二：春龙节(龙抬头)
    calendarDay.holiday = @"龙抬头";
    
  } else if ([solarYear_arr[0]isEqualToString:@"五"]
             && [solarYear_arr[1]isEqualToString:@"初五"]) {
    //五月初五：端午节
    calendarDay.holiday = @"端午";
    
  } else if ([solarYear_arr[0]isEqualToString:@"七"]
             && [solarYear_arr[1]isEqualToString:@"初七"]) {
    //七月初七：七夕情人节
    calendarDay.holiday = @"七夕";
  } else if ([solarYear_arr[0]isEqualToString:@"八"]
             && [solarYear_arr[1]isEqualToString:@"十五"]) {
    
    //八月十五：中秋节
    calendarDay.holiday = @"中秋";
    
  } else if ([solarYear_arr[0]isEqualToString:@"九"]
             && [solarYear_arr[1]isEqualToString:@"初九"]) {
    
    //九月初九：重阳节、中国老年节（义务助老活动日）
    calendarDay.holiday = @"重阳";
    
  } else if ([solarYear_arr[0]isEqualToString:@"腊"]
             && [solarYear_arr[1]isEqualToString:@"初八"]) {
    
    //腊月初八：腊八节
    calendarDay.holiday = @"腊八";
    
  } else if ([solarYear_arr[0]isEqualToString:@"腊"]
             && [solarYear_arr[1]isEqualToString:@"二十四"]) {
    
    //腊月二十四 小年
    calendarDay.holiday = @"小年";
    
  } else if ([solarYear_arr[0]isEqualToString:@"腊"]
             && [solarYear_arr[1]isEqualToString:@"三十"]) {
    //腊月三十（小月二十九）：除夕
    calendarDay.holiday = @"除夕";
    
  }
  
  calendarDay.Chinese_calendar = solarYear_arr[1];
}

/**
 *  修改model的状态 CellDayTypePast
 *
 *  @param calendarDay model
 */
- (void)changStyle:(CalendarDayModel *)calendarDay {
  
  NSDateComponents *calendarToDay  = [today YMDComponents];//今天
  NSDateComponents *calendarbefore = [before YMDComponents];//最后一天
  NSDateComponents *calendarSelect = [select YMDComponents];//默认选择的那一天
  
  
  //被点击选中
  if(calendarSelect.year == calendarDay.year
     & calendarSelect.month == calendarDay.month
     & calendarSelect.day == calendarDay.day) {
    
    calendarDay.style = CellDayTypeClick;
    selectcalendarDay = calendarDay;
    
    
    //没被点击选中
  } else {
    
    //昨天乃至过去的时间设置一个灰度
    if (calendarToDay.year >= calendarDay.year
        & calendarToDay.month >= calendarDay.month
        & calendarToDay.day > calendarDay.day) {
      
      calendarDay.style = CellDayTypePast;
      
      //之后的时间时间段
    } else if (calendarbefore.year <= calendarDay.year
               & calendarbefore.month <= calendarDay.month
               & calendarbefore.day <= calendarDay.day) {
      
      calendarDay.style = CellDayTypePast;
      
      //需要正常显示的时间段
    } else {
      
      //周末
      if (calendarDay.week == 1
          || calendarDay.week == 7) {
        calendarDay.style = CellDayTypeWeek;
        
        //工作日
      } else {
        calendarDay.style = CellDayTypeFutur;
      }
    }
  }
  
  
  
  
  //===================================
  //这里来判断节日
  //今天
  if (calendarToDay.year == calendarDay.year
      && calendarToDay.month == calendarDay.month
      && calendarToDay.day == calendarDay.day) {
    calendarDay.holiday = @"今天";
    
    //明天
  } else if (calendarToDay.year == calendarDay.year
             && calendarToDay.month == calendarDay.month
             && calendarToDay.day - calendarDay.day == -1) {
    calendarDay.holiday = @"明天";
    
    //后天
  } else if (calendarToDay.year == calendarDay.year
             && calendarToDay.month == calendarDay.month
             && calendarToDay.day - calendarDay.day == -2) {
    calendarDay.holiday = @"后天";
    
    //1.1元旦
  } else if (calendarDay.month == 1
             && calendarDay.day == 1) {
    calendarDay.holiday = @"元旦";
    //2.14情人节
  } else if (calendarDay.month == 2
             && calendarDay.day == 14) {
    calendarDay.holiday = @"情人节";
    //3.8妇女节
  } else if (calendarDay.month == 3
             && calendarDay.day == 8) {
    calendarDay.holiday = @"妇女节";
    
    //5.1劳动节
  } else if (calendarDay.month == 5
             && calendarDay.day == 1) {
    calendarDay.holiday = @"劳动节";
    //6.1儿童节
  } else if (calendarDay.month == 6
             && calendarDay.day == 1) {
    calendarDay.holiday = @"儿童节";
    
    //8.1建军节
  } else if (calendarDay.month == 8
             && calendarDay.day == 1) {
    calendarDay.holiday = @"建军节";
    
    //9.10教师节
  } else if (calendarDay.month == 9
             && calendarDay.day == 10) {
    calendarDay.holiday = @"教师节";
    
    //10.1国庆节
  } else if (calendarDay.month == 10
             && calendarDay.day == 1) {
    calendarDay.holiday = @"国庆节";
    
    //11.1植树节
  } else if (calendarDay.month == 11
             && calendarDay.day == 1) {
    calendarDay.holiday = @"植树节";
    
    //11.11光棍节
  } else if (calendarDay.month == 11
             && calendarDay.day == 11) {
    calendarDay.holiday = @"光棍节";
    
  } else {
    
    
    //            这里写其它的节日
    
  }
  
}


- (NSString *)LunarForSolarYear:(int)wCurYear Month:(int)wCurMonth Day:(int)wCurDay {
  
  
  
  //农历日期名
  NSArray *cDayName =  [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                        @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                        @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
  
  //农历月份名
  NSArray *cMonName =  [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊",nil];
  
  //公历每月前面的天数
  const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
  
  //农历数据
  const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
    ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
    ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
    ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
    ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
    ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
    ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
    ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
    ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
    ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
  
  static int nTheDate,nIsEnd,m,k,n,i,nBit;
  
  
  //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
  nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
  
  if((!(wCurYear % 4)) && (wCurMonth > 2))
    nTheDate = nTheDate + 1;
  
  //计算农历天干、地支、月、日
  nIsEnd = 0;
  m = 0;
  while(nIsEnd != 1) {
    if(wNongliData[m] < 4095)
      k = 11;
    else
      k = 12;
    n = k;
    while(n >= 0) {
      //获取wNongliData(m)的第n个二进制位的值
      nBit = wNongliData[m];
      for(i = 1;i < n+1; i++)
        nBit = nBit/2;
      
      nBit = nBit % 2;
      
      if (nTheDate <= (29 + nBit)) {
        nIsEnd = 1;
        break;
      }
      
      nTheDate = nTheDate - 29 - nBit;
      n = n - 1;
    }
    if(nIsEnd)
      break;
    m = m + 1;
  }
  wCurYear = 1921 + m;
  wCurMonth = k - n + 1;
  wCurDay = nTheDate;
  if (k == 12) {
    if (wCurMonth == wNongliData[m] / 65536 + 1)
      wCurMonth = 1 - wCurMonth;
    else if (wCurMonth > wNongliData[m] / 65536 + 1)
      wCurMonth = wCurMonth - 1;
  }
  
  
  //生成农历月
  NSString *szNongliMonth;
  if (wCurMonth < 1) {
    szNongliMonth = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
  } else {
    szNongliMonth = (NSString *)[cMonName objectAtIndex:wCurMonth];
  }
  
  //生成农历日
  NSString *szNongliDay = [cDayName objectAtIndex:wCurDay];
  
  //合并
  NSString *lunarDate = [NSString stringWithFormat:@"%@-%@",szNongliMonth,szNongliDay];
  
  return lunarDate;
}


@end

