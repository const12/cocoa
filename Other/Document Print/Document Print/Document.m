//
//  Document.m
//  Document Print
//
//  Created by xhyx24 on 2021/4/27.
//

#import "Document.h"

//???: bug  NSWindow drag regions should only be invalidated on the Main Thread!
@interface Document ()
@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation Document

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

+ (BOOL)autosavesInPlace {
    return YES;
}


- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}


- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error if you return nil.
    // Alternatively, you could remove this method and override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return nil;
}


- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error if you return NO.
    // Alternatively, you could remove this method and override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you do, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return YES;
}

- (NSPrintOperation*)printOperationWithSettings:
    (NSDictionary<NSPrintInfoAttributeKey, id> *)printSettings
    error:(NSError * _Nullable *)outError {
    NSPrintInfo *printInfo = [self printInfo];
    //设置页边距
    [printInfo setTopMargin:36.0];
    [printInfo setLeftMargin:36.0];
    [printInfo setHorizontallyCentered:NO];
    [printInfo setVerticallyCentered:NO];
    
    NSPrintOperation *printOp = [NSPrintOperation printOperationWithView:self.textView printInfo:printInfo];
    [printOp setCanSpawnSeparateThread:YES];//独立线程运行打印操作
    [[[printOp printInfo]dictionary]addEntriesFromDictionary:printSettings];
    
    return printOp;
}
@end
