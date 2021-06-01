//
//  Controller.m
//  Favorite
//
//  Created by xhyx24 on 2021/4/27.
//

#import "Controller.h"

@interface Controller ()
@property(nonatomic, weak)NSUserDefaults *prefs;
@property (weak) IBOutlet NSTextField *bookText;
@property (weak) IBOutlet NSTextField *colorText;
@property (weak) IBOutlet NSTextField *foodText;
@property (weak) IBOutlet NSTextField *cityText;
@end

@implementation Controller

-(id)init {
    if (self = [super init]) {
        NSMutableDictionary *defaultPrefs = [NSMutableDictionary dictionary];
        [defaultPrefs setObject :@"Learning Cocoa"
        forKey:@"FavBook"] ;
        [defaultPrefs setObject:@"San Francisco" forKey:@"FavCity"] ;
        [defaultPrefs setObject :@"Red" forKey: @"FavColor"] ;
        [defaultPrefs setObject:@"Mexican" forKey:@"FavFood"] ;
        
        _prefs = [NSUserDefaults standardUserDefaults];
        [_prefs registerDefaults:defaultPrefs];
        
//        [defaultPrefs removeAllObjects];
//        defaultPrefs = nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self.bookText setStringValue:[self.prefs stringForKey:@"FavBook"]];
    [self.colorText setStringValue:[self.prefs stringForKey:@"FavColor"]];
    [self.foodText setStringValue:[self.prefs stringForKey:@"FavFood"]];
    [self.cityText setStringValue:[self.prefs stringForKey:@"FavCity"]];
}

- (IBAction)textFieldChange:(id)sender {
    if (sender == self.bookText) {
        [self.prefs setObject:[self.bookText stringValue] forKey:@"FavBook"];
    } else if (sender == self.colorText) {
        [self.prefs setObject:[self.colorText stringValue] forKey:@"FavColor"];
    } else if (sender == self.foodText) {
        [self.prefs setObject:[self.foodText stringValue] forKey:@"FavFood"];
    } else if (sender == self.cityText) {
        [self.prefs setObject:[self.cityText stringValue] forKey:@"FavCity"];
    } else {
        
    }
}
@end
