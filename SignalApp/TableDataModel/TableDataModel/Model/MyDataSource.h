//
//  MyDataSource.h
//  TableDataModel
//
//  Created by xhyx24 on 2021/4/25.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyDataSource : NSObject <NSTableViewDataSource> {
    NSMutableArray *items;
}
@end

NS_ASSUME_NONNULL_END
