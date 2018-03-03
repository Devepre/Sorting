#import <Foundation/Foundation.h>

@interface Cat : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (strong, nonatomic) NSString *name2;
@property (strong, nonatomic) NSString *name3;

+ (NSMutableArray *)createArrayLength:(NSInteger)size isShuffled:(BOOL)isShuffled;
- (instancetype)initWithName:(NSString *)name andAge:(NSInteger)age;

@end
