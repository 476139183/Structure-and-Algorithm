//
//  Created by matt on 28/09/12.
//

#import "MGBox.h"
@class DataItems;
@interface CollectionCellPhotoBox : MGBox
{
    DataItems *boxDataItem;
}
@property (nonatomic,retain) DataItems *boxDataItem;

+ (CollectionCellPhotoBox *)photoBoxFor:(int)i boxData:(DataItems *)oneDataItem size:(CGSize)size;

- (void)loadPhoto:(DataItems*)oneBoxDataItem;

@end
