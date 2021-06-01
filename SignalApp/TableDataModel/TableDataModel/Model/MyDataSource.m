//
//  MyDataSource.m
//  TableDataModel
//
//  Created by xhyx24 on 2021/4/25.
//

#import "MyDataSource.h"
#import "FoodItem.h"

@implementation MyDataSource
-(id)init {
    if (self = [super init]) {
        FoodItem *chimi = [[FoodItem alloc]init];
        FoodItem *fajitas = [[FoodItem alloc]init];
        
        [chimi setName:@"Chimichanga"];
        [chimi setPrice:[NSNumber numberWithFloat:8.95]];
        [fajitas setName:@"Steak Fajitas"];
        [fajitas setPrice:[NSNumber numberWithFloat:10.95]];
        
        items = [NSMutableArray array];
        [items addObject:chimi];
        [items addObject:fajitas];
        
        chimi = nil;
        fajitas = nil;
    }
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [items count];
}

// 使用数据绑定可避免重写这个方法
- (id)tableView:(NSTableView *)tableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
            row:(NSInteger)row {
    
    // In IB the tableColumn has the identifier set to the same string as the keys in our dictionary.
    NSString *identifier = tableColumn.identifier;
    
    // We pass us as the owner so we can setup target/actions into this main controller object.
//    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    // Then setup properties on the cellView based on the column.
    FoodItem *item = [items objectAtIndex:row];
    id conten = [item valueForKey:identifier];
    NSLog(@"%@",conten);
//    cellView.textField.stringValue = [item valueForKey:identifier];
    return conten;
}

//数据改动-界面保存到模型
//基于TableView的视图不调用此方法。
- (void)tableView:(NSTableView *)tableView
   setObjectValue:(id)object
   forTableColumn:(NSTableColumn *)tableColumn
              row:(NSInteger)row {
    NSString *identifier = [tableColumn identifier];
    FoodItem *item = [items objectAtIndex:row];
    [item setValue:object forKey:identifier];
}
@end
