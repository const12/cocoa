//
//  FoodItem.h
//  KeyValueCoding
//
//  Created by xhyx24 on 2021/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoodItem : NSObject
@property(nonatomic, copy)NSString* name;
@property(nonatomic, strong)NSNumber* price;
@end

NS_ASSUME_NONNULL_END
