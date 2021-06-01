//
//  Controller.m
//  Simple Inspector
//
//  Created by xhyx24 on 2021/4/27.
//

#import "Controller.h"

@interface Controller ()
@property (weak) IBOutlet NSTextField *textLengthField;
@property (weak) IBOutlet NSTextView *textView;
@property (strong) IBOutlet NSPanel *infoPanel;
@property (strong) IBOutlet NSWindowController *infoPanelController;
@end

@implementation Controller

-(void)awakeFromNib {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(textDidChange:) name:NSTextDidChangeNotification object:self.textView];
    //窗口关闭通知
    [center addObserver:self selector:@selector(hideInfoPanel) name:NSWindowWillCloseNotification object:self.view.window];
}

-(void)textDidChange:(NSNotification *)obj {
    [self.textLengthField setIntValue:(int)[[self.textView textStorage]length]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)hideInfoPanel {
    NSLog(@"window close");
    if ([self.infoPanel isVisible]) {
        [self.infoPanelController close];
    }
}

- (IBAction)showInfoPanel:(id)sender {
    if (!self.infoPanelController) {
//        [NSBundle loadNibNamed:@"Info.xib" owner:self];
        self.infoPanelController = [[NSWindowController alloc]initWithWindowNibName:@"Info" owner:self];
    }
//    NSLog(@"windowController:%@\t window:%@\t self.infoPanel:%@\t length:%lu",
//          self.infoPanelController,
//          self.infoPanelController.window,
//          self.infoPanel,
//          (unsigned long)[[self.textView textStorage]length]);
    [self.textLengthField setIntValue:(int)[[self.textView textStorage]length]];
    [self.infoPanelController showWindow:self];
}

@end
