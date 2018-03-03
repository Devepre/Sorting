#import "QuickSort.h"

@implementation QuickSort

+ (void)quickSort:(NSMutableArray<Cat *> *)a andL:(NSInteger)l andR:(NSInteger)r {
    if (r <= l) {
        return;
    }
    
    NSInteger i = [QuickSort partition:a andL:l andR:r];
    [QuickSort quickSort:a andL:l andR:i - 1];
    [QuickSort quickSort:a andL:i + l andR:r];
}

+ (NSInteger)partition:(NSMutableArray<Cat *> *)a andL:(NSInteger)l andR:(NSInteger)r {
    NSInteger i = l - 1;
    NSInteger j = r;
    Cat *v = [a objectAtIndex:r];
    
    for(;;) {
        while ([a objectAtIndex:++i].age < v.age);
        while (v.age < [a objectAtIndex:--j].age)
            if (j == l)
                break;
        if (i >= j)
            break;
        [a exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    [a exchangeObjectAtIndex:i withObjectAtIndex:r];
    
    return i;
}

@end
