#import "Tweak.h"


#pragma mark - Hooks
%hook YTAsyncCollectionView
- (id)cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = %orig;

    if ([cell isKindOfClass:objc_lookUpClass("_ASCollectionViewCell")]) {
        _ASCollectionViewCell *cell = %orig;
        if ([cell respondsToSelector:@selector(node)]) {
            NSString *idToRemove = [[cell node] accessibilityIdentifier];
            if ([idToRemove isEqualToString:@"eml.shorts-grid"] || [idToRemove isEqualToString:@"eml.shorts-shelf"]) {
                [self removeCellsAtIndexPath:indexPath];
            }
        }
    } else if ([cell isKindOfClass:objc_lookUpClass("YTReelShelfCell")]) {
        [self removeCellsAtIndexPath:indexPath];
    }
    return %orig;
}

%new
- (void)removeCellsAtIndexPath:(NSIndexPath *)indexPath {
//    [self performBatchUpdates:^{
        [self deleteItemsAtIndexPaths:@[indexPath]];
//    } completion:nil];
}
%end

#pragma mark - ctor
%ctor {
    @autoreleasepool {
        if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.miro.ytnoshorts.list"]) return;
        [[NSBundle bundleWithPath:[NSString stringWithFormat:@"%@/Frameworks/Module_Framework.framework", [[NSBundle mainBundle] bundlePath]]] load];
    }
}
