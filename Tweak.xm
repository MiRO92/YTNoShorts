#import "Tweak.h"


#pragma mark - Hooks
%hook YTAsyncCollectionView
- (id)cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = %orig;

    if ([cell isKindOfClass:NSClassFromString(@"_ASCollectionViewCell")]) {
        _ASCollectionViewCell *cell = %orig;
        if ([cell respondsToSelector:@selector(node)]) {
            if ([[[cell node] accessibilityIdentifier] isEqualToString:@"eml.shorts-shelf"]) {
                [self removeShortsCellAtIndexPath:indexPath];
            }
        }
    } else if ([cell isKindOfClass:NSClassFromString(@"YTReelShelfCell")]) {
        [self removeShortsCellAtIndexPath:indexPath];
    }
    return %orig;
}

%new
- (void)removeShortsCellAtIndexPath:(NSIndexPath *)indexPath {
//    [self performBatchUpdates:^{
        [self deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
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
