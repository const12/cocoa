//
//  FoodItem.m
//  KeyValueCoding
//
//  Created by xhyx24 on 2021/4/25.
//

#import "FoodItem.h"

@implementation FoodItem
-(id)init {
    if (self = [super init]) {
        _name = @"New Item";
        _price = [NSNumber numberWithFloat:0.0];
    }
    return self;
}
@end
