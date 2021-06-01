//
//  Controller.m
//  Localization
//
//  Created by xhyx24 on 2021/4/27.
//

#import "Controller.h"

@interface Controller ()
@property (weak) IBOutlet NSButton *radioCrash;
@property (weak) IBOutlet NSButton *radioCredit;
@property (weak) IBOutlet NSTextField *statusText;
@property(nonatomic, assign) int payType;
@property(nonatomic, assign) BOOL isPay;

@end

@implementation Controller

-(void)awakeFromNib {
    self.payType = -1;
    self.isPay = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)submitClick:(id)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.alertStyle = NSAlertStyleWarning;
    [alert addButtonWithTitle:NSLocalizedString(@"Confirm",nil)];
    alert.messageText = NSLocalizedString(@"Pay",nil);

    if (self.isPay) {
        alert.informativeText = NSLocalizedString(@"You have been submitted!",nil);

        [alert beginSheetModalForWindow:[NSApplication sharedApplication].keyWindow completionHandler:nil];
    }else if (self.payType == -1) {
        alert.informativeText = NSLocalizedString(@"Please select the method of payment!",nil);

        [alert beginSheetModalForWindow:[NSApplication sharedApplication].keyWindow completionHandler:nil];
    } else {
        [self.statusText setStringValue:NSLocalizedString(@"Submitted", nil)];
        self.isPay = YES;
    }
}

- (IBAction)radioGroupClcik:(id)sender {
    NSButton *radio = sender;
    self.payType = (int)radio.tag;
    /*
    if (radio.tag == 0) {
        //
    } else if(radio.tag == 1) {
        
    } else {}
     */
}


@end
