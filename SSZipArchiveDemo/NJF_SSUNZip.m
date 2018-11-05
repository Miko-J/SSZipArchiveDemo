//
//  NJF_SSUNZip.m
//  SSZipArchiveDemo
//
//  Created by niujf on 2018/11/5.
//  Copyright © 2018年 niujf. All rights reserved.
//

#import "NJF_SSUNZip.h"
#import "SSZipArchive/SSZipArchive.h"

@implementation NJF_SSUNZip

+ (void)clearCacheResourcePath{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"NJF_ResourcePhoto"];
}

+ (UIImage *_Nullable)getImageWithImageName:(NSString *_Nullable)imageName{
    @autoreleasepool {
        NSString *unzipPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"NJF_ResourcePhoto"];
        if (unzipPath.length <= 0) {
            NSString *zipPath = [[NSBundle mainBundle] pathForResource:@"NJFPhotos.bundle/Resources/Photos" ofType:@"zip"];
            if (!zipPath) {
                return nil;
            }
            unzipPath = [self tempUnzipPath];
            if (!unzipPath) {
                return nil;
            }
            NSLog(@"要解压的路径%@",unzipPath);
            BOOL success = [SSZipArchive unzipFileAtPath:zipPath
                                           toDestination:unzipPath
                                      preserveAttributes:YES
                                               overwrite:YES
                                          nestedZipLevel:0
                                                password:nil
                                                   error:nil
                                                delegate:nil
                                         progressHandler:nil
                                       completionHandler:nil];
            if (success) {
                NSLog(@"Success unzip");
                [[NSUserDefaults standardUserDefaults] setObject:unzipPath forKey:@"NJF_ResourcePhoto"];
                [NSUserDefaults standardUserDefaults];
            } else {
                NSLog(@"No success unzip");
                return nil;
            }
            NSError *error = nil;
            NSMutableArray<NSString *> *items = [[[NSFileManager defaultManager]
                                                  contentsOfDirectoryAtPath:unzipPath
                                                  error:&error] mutableCopy];
            if (error) {
                return nil;
            }
            NSLog(@"%@",items);
        }
        NSString* imagePath = [unzipPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Photos/%@",imageName]];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        return image;
    }
}

+ (NSString *)tempUnzipPath {
    NSString *path = [NSString stringWithFormat:@"%@/\%@",
                      NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0],
                      [NSUUID UUID].UUIDString];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtURL:url
                             withIntermediateDirectories:YES
                                              attributes:nil
                                                   error:&error];
    if (error) {
        return nil;
    }
    return url.path;
}


@end
