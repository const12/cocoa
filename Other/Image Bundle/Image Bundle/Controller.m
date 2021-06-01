//
//  Controller.m
//  Image Bundle
//
//  Created by xhyx24 on 2021/4/27.
//

#import "Controller.h"

@interface Controller ()
@property (weak) IBOutlet NSImageView *imageView;
//@property(nonatomic, strong) NSArray *imagePaths;
@property(nonatomic, strong) NSMutableArray *images; //性能优化，加快载入图像速度
@property(nonatomic, assign) int currentImage;
@end

@implementation Controller

-(void)awakeFromNib {
    NSBundle *mainBundle = [NSBundle mainBundle]; //MARK: 获取文件包引用
//    self.imagePaths = [mainBundle pathsForResourcesOfType:@"jpg" inDirectory:nil];
    NSArray *imagePaths = [mainBundle pathsForResourcesOfType:@"jpg" inDirectory:nil];
    self.images = [NSMutableArray array];
    NSUInteger count = [imagePaths count];
    NSImage *image = [[NSImage alloc]init];
    for (int i = 0; i < count; i++) {
        image = [[NSImage alloc] initWithContentsOfFile:[imagePaths objectAtIndex:i]];
        [self.images addObject:image];
        image = nil;
    }
    self.currentImage = 0;
    
//    NSString *path = [mainBundle pathForResource:@"Abstract Shapes" ofType:@"jpg"];
//    NSLog(@"image path:%@",path);
    /*
    NSImage *image = [[NSImage alloc]initWithContentsOfFile:[self.imagePaths objectAtIndex:self.currentImage]];
    [self.imageView setImage:image];
    image = nil;
     */
    [self.imageView setImage:[self.images objectAtIndex:self.currentImage]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)nextImage:(id)sender {
/*
    self.currentImage++;
    if (self.currentImage == [self.imagePaths count]) {
        self.currentImage = 0;
    }
    
    NSImage *image = [[NSImage alloc]initWithContentsOfFile:[self.imagePaths objectAtIndex:self.currentImage]];
    [self.imageView setImage:image];
    image = nil;
 */
    
    self.currentImage++;
    if (self.currentImage == [self.images count]) {
        self.currentImage = 0;
    }
    
    [self.imageView setImage:[self.images objectAtIndex:self.currentImage]];
}

- (IBAction)previousImage:(id)sender {
    self.currentImage--;
    if (self.currentImage == -1) {
        self.currentImage = (int)[self.images count] - 1;
    }
    
    [self.imageView setImage:[self.images objectAtIndex:self.currentImage]];
}

@end
