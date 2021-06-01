//
//  main.m
//  KeyValueCoding
//
//  Created by xhyx24 on 2021/4/25.
//

#import <Foundation/Foundation.h>
#import "FoodItem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
        FoodItem *item = [[FoodItem alloc]init];
        [item setValue:@"Aero" forKey:@"name"];
        [item setValue:[NSNumber numberWithFloat:1.25] forKey:@"price"];
        
        NSLog(@"item name:%@\tprice:%@", [item valueForKey:@"name"], [item valueForKey:@"price"]);
    }
    return 0;
}
