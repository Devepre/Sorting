#import "Cat.h"

@implementation Cat

- (instancetype)initWithName:(NSString *)name angAge:(NSInteger)age {
    self = [super init];
    if (self) {
        self.name = name;
        self.age = age;
    }
    return self;
}

+ (NSMutableArray *)createArrayLength:(NSInteger)size {
    NSMutableArray *arr = [NSMutableArray new];
    
    for (int i = 0; i < size; i++) {
        Cat *tempCat = [[Cat alloc] initWithName:@"Cat" angAge:i];
        [arr addObject:tempCat];
    }
    
//    [self shuffleArray:arr];
    
    return arr;
//    return [arr copy];
}

+ (void)shuffleArray:(NSMutableArray *)arr {
    for (NSUInteger i = [arr count] - 1; i >= 1; i--) {
        NSUInteger j = arc4random_uniform((uint32_t)i + 1);
        
        [arr exchangeObjectAtIndex:j withObjectAtIndex:i];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%ld", self.age];
}

@end