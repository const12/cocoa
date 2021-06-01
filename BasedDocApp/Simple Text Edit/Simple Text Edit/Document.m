//
//  Document.m
//  Simple Text Edit
//
//  Created by xhyx24 on 2021/4/26.
//

#import "Document.h"
#import "WindowController.h"

/// 配置信息 https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/DocBasedAppProgrammingGuideForOSX/ApplicationCreationProcess/ApplicationCreationProcess.html#//apple_ref/doc/uid/TP40011179-CH6-997699

//FIXME: 打开文件和保存文件无后缀名
@interface Document ()
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property(nonatomic, strong)NSData* dataFromFile;
@end

@implementation Document

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

-(void)windowControllerDidLoadNib:(NSWindowController *)windowController {
    [super windowControllerDidLoadNib:windowController];
    //文档创建时加载完成xib文件后执行
    //实现额外的界面相关的初始化设置
    if (self.dataFromFile) {
        NSString *text = [[NSString alloc]initWithData:self.dataFromFile encoding:NSUTF8StringEncoding];
        [self.textView setString:text];
        text = nil;
    }
    [self.textView setAllowsUndo:YES];
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    //File菜单点击New新建文档窗口，窗口由返回的xib文件定义
    //也可以实现makeWindowControllers方法返回NSWIndowController的子类去定义Document界面窗口
    //同时实现makeWindowControllers 和 windowNibName，前者优先
    return @"Document";
}

/*
-(void)makeWindowControllers {
    WindowController *wc = [[WindowController alloc]init];
    [self addWindowController:wc];
}
*/

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error if you return nil.
    // Alternatively, you could remove this method and override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
//    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
//    return nil;
    //文档保存它自身的内容
    NSString *text = [self.textView string];
    return [text dataUsingEncoding:NSUTF8StringEncoding];
}


- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error if you return NO.
    // Alternatively, you could remove this method and override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you do, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    //使文本数据可以从文件系统装载到文档。新建文档时，该方法在nib文件尚未完全装载、所有连接尚未建立之前调用。因此，此时文本视图的连接尚未建立。
    //把数据对象保存进dataFromFile变量
//    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    self.dataFromFile = data;
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
