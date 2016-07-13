//
//  ViewController.m
//  03UILessonArchiverAndUnArchiver
//
//  Created by UntilYou-QC on 16/5/25.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 归档：归档是指把复杂数据类型 存储到 沙盒的文档当中
    // 反归档：从沙盒的文档当中 把复杂的数据类型读取出来
    // 复杂数据类型：数据模型model 或者是 数组里面装载的model
    
//    [self archiverModel];
//    [self unArchiverModel];
//    [self archiverArray];
    [self unArchiverArray];
}

#pragma mark ----- 归档一个的Model
- (void)archiverModel {
    Model *model = [[Model alloc] init];
    model.name = @"yoona";
    model.gender = @"gui";
    model.age = 999;
    
    // 初始化data
    NSMutableData *data = [NSMutableData data];
    // model进行归档的时候 系统会自动把model的信息拼接给data 最后我们是把data写入到文档当中
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    NSLog(@"data1================%@", data);
    // 归档model 实际上就是存储model里面的各个属性
    // 归档model时 系统会自动调用Model类里面encodeWithCoder方法 如果没有实现 则会导致程序崩溃
    [archiver encodeObject:model forKey:@"model"];
    // 这行代码必须写 否则 归档是失败的
    [archiver finishEncoding];
    NSLog(@"data2================%@", data);
    
    NSString *filePath = [[self documentsFilePath] stringByAppendingPathComponent:@"model.txt"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        [manager createFileAtPath:filePath contents:nil attributes:nil];
    }
    NSLog(@"filePath===============%@", filePath);
    [data writeToFile:filePath atomically:YES];
}

#pragma mark ----- 反归档model
- (void)unArchiverModel {
    NSString *filePath = [[self documentsFilePath] stringByAppendingPathComponent:@"model.txt"];
    // 从路径中取出data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // 创建反归档对象
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // 反归档model对象
    Model *model = [unArchiver decodeObjectForKey:@"model"];
    NSLog(@"model===================%@", model);
    NSLog(@"%@ %@ %ld", model.name, model.gender, model.age);
}

#pragma mark ----- 归档数组（数组里装载model）
- (void)archiverArray {
    NSString *filePath = [[self documentsFilePath] stringByAppendingPathComponent:@"array.txt"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        [manager createFileAtPath:filePath contents:nil attributes:nil];
    }
    NSLog(@"filePath===============%@", filePath);
    NSMutableArray *modelArray = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        Model *model = [[Model alloc] init];
        model.name = [NSString stringWithFormat:@"姓名%d", i];
        model.gender = [NSString stringWithFormat:@"性别%d", i];
        model.age = 999;
        [modelArray addObject:model];
    }
    
    // 初始化data
    NSMutableData *data = [NSMutableData data];
    // model进行归档的时候 系统会自动把model的信息拼接给data 最后我们是把data写入到文档当中
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    NSLog(@"data1================%@", data);
    // 归档model 实际上就是存储model里面的各个属性
    // 归档model时 系统会自动调用Model类里面encodeWithCoder方法 如果没有实现 则会导致程序崩溃
    [archiver encodeObject:modelArray forKey:@"model"];
    // 这行代码必须写 否则 归档是失败的
    [archiver finishEncoding];
    NSLog(@"data2================%@", data);
    
    [data writeToFile:filePath atomically:YES];
}

#pragma mark ----- 反归档数组
- (void)unArchiverArray {
    NSString *filePath = [[self documentsFilePath] stringByAppendingPathComponent:@"array.txt"];
    // 从路径中取出data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // 创建反归档对象
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // 反归档model对象
    NSArray *array = [unArchiver decodeObjectForKey:@"model"];
    NSLog(@"array===================%@", array);
    for (Model *model in array) {
        NSLog(@"%@ %@ %ld", model.name, model.gender, model.age);
    }
}

- (NSString *)documentsFilePath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
