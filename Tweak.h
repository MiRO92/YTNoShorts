#import <UIKit/UIKit.h>


@interface ELMCellNode
@end

@interface _ASCollectionViewCell : UICollectionViewCell
- (id)node;
@end

@interface YTAsyncCollectionView : UICollectionView
- (void)removeShortsCellAtIndexPath:(NSIndexPath *)indexPath;
@end
