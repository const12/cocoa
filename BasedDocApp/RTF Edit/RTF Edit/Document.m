//
//  Document.m
//  RTF Edit
//
//  Created by xhyx24 on 2021/4/26.
//

#import "Document.h"
//FIXME: 字体和颜色设置不起作用
@interface Document ()
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property(nonatomic, strong)NSAttributedString* rtfData;
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

-(void)windowControllerDidLoadNib:(NSWindowController *)windowController {
    [super windowControllerDidLoadNib:windowController];
    if (self.rtfData) {
        [[self.textView textStorage]replaceCharactersInRange:NSMakeRange(0, [[self.textView string]length]) withAttributedString:self.rtfData];
        self.rtfData = nil;
    }
    [self.textView setAllowsUndo:YES];
}

-(BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper ofType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError {
    self.rtfData = [[NSAttributedString alloc]initWithRTF:[fileWrapper regularFileContents] documentAttributes:nil];
    
    if (self.textView) {
        [[self.textView textStorage] replaceCharactersInRange:NSMakeRange(0, [[self.textView string]length]) withAttributedString:self.rtfData];
        self.rtfData = nil;
    }
    return YES;
}

//保存文本内容
-(NSFileWrapper*)fileWrapperOfType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError {
    NSRange range = NSMakeRange(0, [[self.textView string]length]);
    NSFileWrapper *wrapper = [[NSFileWrapper alloc]initRegularFileWithContents: [self.textView RTFFromRange:range]];
    
    return wrapper;
}

- (IBAction)analyzeText:(id)sender {
    int count = 0;
    int fontChange = -1;
    id lastAttribute = nil;
    NSTextStorage *storage = [self.textView textStorage];
    
    while (count < [storage length]) {
        id attributeValue = [storage attribute:NSFontAttributeName atIndex:count effectiveRange:nil];
        
        if (attributeValue != lastAttribute) {
            fontChange++;
        }
        lastAttribute = attributeValue;
        count++;
    }
    
    NSBeginAlertSheet(@"Analysis", //标题
                      @"OK", //默认按钮标签
                      nil, //取消按钮标签
                      nil, //其他按钮标签
                      [self.textView window], //依附窗口
                      nil, //模态窗口委托者
                      NULL, //方法选标
                      NULL, //窗口完成方法选标
                      nil, //上下文信息
                      @"Font changes %i",fontChange);
}

/*
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
*/

@end
