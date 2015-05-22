//
//  ViewController.m
//  UI多线程网络测试题练习
//
//  Created by dwt on 15-5-6.
//  Copyright (c) 2015年 dwt. All rights reserved.
//

#import "ViewController.h"
#import "pthread.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // iOS中多线程的实现方案有4种
    /**
     pthread
     NSThread
     GCD
     NSOperation
     */
    
    /**
     C语言:重要的是，*函数*（参数可以通过头文件里函数上的注释来记）
     C语言是面向过程的语言，提供给我们的功能，是通过函数来封装的。所以调用C语言的库，就是调用函数库。重要的是函数。
     
     OC语言:重要的是 *对象* 以及对象对应的方法
     OC是面向对象的编程语言，提供给我们的功能，是通过*类*，来封装的。执行时，是通过调用类对应的方法来执行。
     */
    

    //1.pthread 方式
    {
        { /**
             优点：
             一套通用的多线程API
             适用于Unix\Linux\Windows等系统
             跨平台\可移植

             缺点：
             使用难度大
             （功能简单）
             
             语言:C
             
             线程生命周期：程序员管理
             使用频率：几乎不用
           */}//优缺点
        
    /**
     C语言主旨：1.个方法
     pthread_create
     */

    }
    [self dwt_pThread];
    
    
    
    //2.NSThread 方式
    {
        {/**
             NSThread
             使用更加面向对象
             简单易用，可直接操作线程对象

             语言：OC
             
             线程生命周期：程序员管理

             使用频率：偶尔使用（一般使用静态方法居多）*/} //优缺点
    
    /**
     OC主旨：1个类，3个方法，
     NSThread：使用静态方法居多

     // 静态方法
     [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"我是参数"];

     // 动态方法
      NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"哈哈"];
         // 开启线程
         [thread start];
     
     
     // 分类方法
     [self performSelectorInBackground:@selector(run:) withObject:@"abc参数"];
     */
    }
    [self dwtNSThread];

/******************************************
 * GCD和NSOperation 中引入了任务与队列的概念  
 *    任务(block) ：执行什么操作
 *    队列(queue) ：用来存放任务
 
 *     步骤
 *  1. 定制任务
 *  2. 将任务添加到队列中
 ******************************************/

    //3.GCD方法
    {
        { /*
         旨在替代NSThread等线程技术
         充分利用设备的多核
           
           GCD的优势
           GCD是苹果公司为多核的并行运算提出的解决方案
           GCD会自动利用更多的CPU内核（比如双核、四核）
           GCD会自动管理线程的生命周期（创建线程、调度任务、销毁线程）
           程序员只需要告诉GCD想要执行什么任务，不需要编写任何线程管理代码
         
         语言:C
         
         线程生命周期:
         自动管理

         使用频率
         经常使用
           */}//优缺点

    
    
    /**
     C语言主旨：2.个方法
     
     // 任务（执行任务的函数）
     dispatch_sync  // 同步方法
     dispatch_async// 异步方法
     
     //    同步和异步的区别
     //    同步：在当前线程中执行
     //    异步：在另一条线程中执行
     
     // 队列
     dispatch_queue_create  创建队列（默认情况下是串行队列）
     dispatch_get_global_queue // 获得全局并发队列
     dispatch_get_main_queue() //获得主队列（串行队列）。
     
     // 队列组
     dispatch_group_create() 创建队列组
     dispatch_group_notify  // 等前面的异步操作都执行完毕后，回到对应...
     */
    }
    [self dwtDispatch];
    
    
   // NSOperation
    {
        {/*
         NSOperation
         
         优点：基于GCD（底层是GCD）
         比GCD多了一些更简单实用的功能
         使用更加面向对象
         
         语言：OC
         

         线程生命周期：自动管理

         使用频率：经常使用

         三个类，NSOperationQueue（队列），NSBlockOperation（任务），NSInvocationOperation（任务）
         主要功能：线程间有依赖
         
        */}// 优缺点
        
        
        /**NSOperation
         记住3个类
         操作类(任务)
         NSBlockOperation
         NSInvocationOperation
         
         队列类
         NSOperationQueue
         */
    }
    [self dwtNSOperation];
    

    
}



-(void)operation_run:(NSString *)str{
    NSThread *test = [NSThread currentThread];
    test.name  =  str;
 NSLog(@"%@ %@",test.name,[NSThread currentThread]);

}



#pragma mark  ---pthread 代码 ---
-(void)dwt_pThread{
// 使用 pthread 需要导入 #import <pthread.h>
    
    
    //1 创建线程
    pthread_t thread;

    /**
     参数
     1.线程编号地址。
     2.线程的属性。
     3.线程要执行的函数（函数指正一般用$函数名）
     4.线程要执行的函数的参数
     */
    NSString *str= @"123";
    pthread_create(&thread, nil, &run_pthread, (__bridge void *)(str));
 
}

// 线程要执行的函数 需传参
void *run_pthread(void *data)
{
    NSLog(@"run_pthread --- %@,%@",[NSThread currentThread],data);
    return NULL;
}


#pragma mark  ---NSThread 代码 ---
-(void)dwtNSThread{
    // 方式1 隐式创建。
    // 隐式创建线程, 并且直接(自动)启动
    // 在后台线程中执行 === 在子线程中执行
    [self performSelectorInBackground:@selector(thread_run:) withObject:@"NSThread_分类创建_参数"];
    
    /**
     * 方式2
     * NSThread的创建方式
     * 创建完线程直接(自动)启动
     */
    [NSThread detachNewThreadSelector:@selector(thread_run:) toTarget:self withObject:@"NSThread_静态方法_参数"];
    
    /**
     * 方式3
     * NSThread的创建方式
     * 1> 先创建初始化线程
     * 2> start开启线程 (需要调用start方法来开启线程，所以称 NSThread 的线程生命周期需要程序员自己管理)
     */
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(thread_run:) object:@"NSThread_动态方法_参数"];
    thread.name = @"NSThread_动态方法_线程A";
    // 开启线程
    [thread start];
    
    
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(thread_run:) object:@"NSThread_动态方法_参数"];
    thread2.name = @"NSThread_动态方法_线程B";
    // 开启线程
    [thread2 start];
    
    
    /***** 以下为静态方法。（常用的方法）*******/
    
    // 获得主线程
    [NSThread mainThread];
    // 获得当前线程
    [NSThread currentThread];
    // 阻塞（暂停）线程
    [NSThread sleepForTimeInterval:0.5];
    // 是否为主线程（同时有对象方法）
    [NSThread isMainThread];
    // 线程死亡（注意：一旦线程停止（死亡）了，就不能再次开启任务）
    [NSThread exit];
    
}

-(void)thread_run:(NSString *)str {
    NSLog(@"thread_run___str====%@,%@",str,[NSThread currentThread]);
}


#pragma mark  ---GCD 代码 ---
-(void)dwtDispatch{

    /***** 队列 *****************************************************************/

    
    
    /***** 并发队列 ****/
    /** 1.获得全局的并发队列
     * dispatch_get_global_queue(long identifier, unsigned long flags);
     * 参数：
     * 1.  long identifier      == 队列的优先级
     * 2.  unsigned long flags  == 此参数暂时无用，用0即可
     * 
     */
    dispatch_queue_t queue_global =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    /**
     全局并发队列的优先级
     #define DISPATCH_QUEUE_PRIORITY_HIGH 2 // 高
     #define DISPATCH_QUEUE_PRIORITY_DEFAULT 0 // 默认（中）
     #define DISPATCH_QUEUE_PRIORITY_LOW (-2) // 低
     #define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN // 后台
     */
    
    
    /***** 串行队列 ****/
    /**1.创建串行队列
     * dispatch_queue_create(const char *label, dispatch_queue_attr_t attr);
     * 参数:
     1.const char *label             == 队列名称
     2.dispatch_queue_attr_t attr    == 队列属性，一般用NULL即可
     */
    dispatch_queue_t queue_create = dispatch_queue_create("com.itheima.queue", NULL);
    /*
     注:dispatch_release(queue); // 非ARC需要释放手动创建的队列
     */
    // 1.获得主队列
    dispatch_queue_t queue_main = dispatch_get_main_queue();
    
    
    /***** 添加任务到队列中 执行 ****/
    // 异步方法
    dispatch_async(queue_global, ^{
        NSLog(@"----dispatch_async1-----%@", [NSThread currentThread]);
    });
    // 同步方法
    dispatch_sync(queue_global, ^{
        NSLog(@"----dispatch_sync1-----%@", [NSThread currentThread]);
    });
    
    
    /***** 队列组 ****/
    /*有这么1种需求
      首先：分别异步执行2个耗时的操作
      其次：等2个异步操作都执行完毕后，再回到主线程执行操作
      如果想要快速高效地实现上述需求，可以考虑用队列组
     */
    
    dispatch_group_t group =  dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程...
    });
   
}

#pragma mark  ---NSOperation 代码 ---
-(void)dwtNSOperation{
    // 操作类写代码的地方
    // NSBlockOperation 封装操作
    
    
    NSBlockOperation *operation_block_1 = [[NSBlockOperation alloc]init];
    // 静态方法创建
    NSBlockOperation *operation_block_2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"----operation_block_2-----%@", [NSThread currentThread]);
        
    }];
    
    // 使用 addExecutionBlock 添加操作。
    [operation_block_1 addExecutionBlock:^{
        NSLog(@"----operation_block_1.1-----%@", [NSThread currentThread]);
    }];
    
    [operation_block_1 addExecutionBlock:^{
        NSLog(@"----operation_block_1.2-----%@", [NSThread currentThread]);
    }];
    

    
    // 1.NSInvocationOperation 封装操作
    NSInvocationOperation *operation_A = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation_run:) object:@"operation_A"];
    
    NSInvocationOperation *operation_B = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation_run:) object:@"operation_B"];
    
    NSInvocationOperation *operation_C = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation_run:) object:@"operation_C"];
    
    
    
    /*
     NSOperation 抽象类中的方法
     可以监听一个操作的执行完毕
     */
    [operation_block_1 setCompletionBlock:^{
        NSLog(@"----operation_block_1-----操作完毕%@", [NSThread currentThread]);
    }];
    
    
    /**
     
     NSOperation可以调用start方法来执行任务，但默认是同步执行的
     如果将NSOperation添加到NSOperationQueue（操作队列）中，系统会自动异步执行NSOperation中的操作
     
     */
    
    // 2.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    /**
     最大并发数:
     同时执行的任务数
     比如，同时开3个线程执行3个任务，并发数就是3
     */
    queue.maxConcurrentOperationCount = 2; // 2 ~ 3为宜
    
    
    
    // 设置依赖
    [operation_B addDependency:operation_A];
    [operation_C addDependency:operation_B];
    
    /**
     operation_B 依赖于 operation_A
     operation_C 依赖于 operation_B
     
     operation_B 只有在 operation_A 执行完毕后才会执行
     operation_C 只有在 operation_B 执行完毕后才会执行
    
     执行顺序是 operation_A -> operation_B -> operation_C
     */
    
    [queue addOperations:@[operation_block_1,operation_block_2,operation_A,operation_B,operation_C] waitUntilFinished:YES];
    
    //    // 取消所有队列
    //    [queue cancelAllOperations];
    //    [queue setSuspended:YES]; // YES代表暂停队列，NO代表恢复队列
    //    [queue isSuspended];// 判断次队列是否在暂停状态
    
}


@end
