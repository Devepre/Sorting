// Important!
//this program doesn't use ARC
//in order to use plain C qsort

#import <Foundation/Foundation.h>
#import <mach/mach.h>
#import <malloc/malloc.h>
#import "Cat.h"
#import "QuickSort.h"

static const int quantity = 1000 * 1000 * 10;
static NSDate *methodStart;
static NSMutableArray<Cat *> *cats;

void report_memory(void);
void performSortUsingCQSort(void);
void performSortUsingArrayAndBlock(void);
void performSortUsingArrayCopyAndBlock(void);
void performSortUsingDescriptors(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        performSortUsingCQSort();
        performSortUsingArrayAndBlock();
        performSortUsingArrayCopyAndBlock();
        performSortUsingDescriptors();
//        performSortUsingManualQSort();
    }
    return 0;
}

int cmpfunc (const void * a, const void * b) {
    return (int)(*(Cat **)b).age - (int)(*(Cat **)a).age;
    
    // what is going here actually is:
//    Cat **objA = a;
//    Cat *catA = *objA;
//    Cat **objB = b;
//    Cat *catB = *objB;
//    return catB.age - catA.age;
}

void performSortUsingCQSort(void) {
    printf("Sorting using C qsort and malloc:\n");
    report_memory();

    Cat **values = malloc(sizeof(pointer_t) * quantity);
//    Cat *values[quantity];
    for (int i = 0; i < quantity; i++) {
        Cat *newCat = [Cat new];
        newCat.age = i;
        values[i] = newCat;
    }
    
    printf("[%ld -> %ld]\n", values[0].age, values[quantity - 1].age);
    
    NSDate *methodStart = [NSDate date];
    qsort(values, quantity, 8, cmpfunc);
    NSTimeInterval executionTime = [[NSDate date] timeIntervalSinceDate:methodStart];
    
    printf("[%ld -> %ld]\n", values[0].age, values[quantity - 1].age);
    report_memory();
    printf("%f\n\n", executionTime);
    free(values);
}

void printArrayTails(NSMutableArray *source) {
    printf("[%ld -> %ld]\n", [[source firstObject] age], [[source lastObject] age]);
}

void beginTransaction(char *message) {
    printf("%s", message);
    report_memory();
    
    cats = [Cat createArrayLength:quantity];
    printArrayTails(cats);
    methodStart = [NSDate date];
}

void endTransaction(void) {
    NSTimeInterval executionTime = [[NSDate date] timeIntervalSinceDate:methodStart];
    printArrayTails(cats);
    report_memory();
    printf("%f\n\n", executionTime);
    cats = nil;
}

void performSortUsingArrayAndBlock(void) {
    beginTransaction("Sorting using NSMutableArray and Block\n");
    
    [cats sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return ((Cat *)obj1).age < ((Cat *)obj2).age;
    }];
    
    endTransaction();
}

void performSortUsingArrayCopyAndBlock(void) {
    beginTransaction("Sorting using creating new NSMutableArray and Block:\n");
    
    //using source array as destination array
    cats = [cats sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return ((Cat *)obj1).age < ((Cat *)obj2).age;
    }];
    
    endTransaction();
}

void performSortUsingDescriptors(void) {
    beginTransaction("Sorting using NSMutableArray and Descriptors:\n");
    
    NSSortDescriptor *desc = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    NSArray<NSSortDescriptor *> *sortingRules = [[NSArray alloc] initWithObjects:desc, nil];
    [cats sortUsingDescriptors:sortingRules];
    
    endTransaction();
}

void performSortUsingManualQSort(void) {
    beginTransaction("Sorting using manual QSort alg:\n");
    
    [QuickSort quickSort:cats andL:0 andR:[cats count] - 1];

    endTransaction();
}

void report_memory(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    if( kerr == KERN_SUCCESS ) {
        printf("Memory occupation: %f\n", ((CGFloat)info.resident_size / 1000000));
    } else {
        printf("Error with task_info(): %s", mach_error_string(kerr));
    }
}

void extra(void) {
    /*
    size_t sizeOfObject = class_getInstanceSize ([Cat class]);
    NSLog(@"%zd", malloc_size((__bridge const void *) cat1));
    NSData *objData = [NSData dataWithBytes:(__bridge const void * _Nullable)(cat1) length:malloc_size((__bridge const void *)(cat1))];
    NSLog(@"Object contains %@", objData);
     */
}
