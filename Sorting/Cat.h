#import <Foundation/Foundation.h>

@interface Cat : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;

+ (NSMutableArray *)createArrayLength:(NSInteger)size;
- (instancetype)initWithName:(NSString *)name angAge:(NSInteger)age;

@end
