//
//  BlockTester.m
//  BlockTester
//
//  Created by Melborne on 11/04/17.
//  Copyright © 2017 Melborne. All rights reserved.
//

#import "BlockTester.h"

@interface BlockTester()

@property(nonatomic, copy) void (^Block)(id, NSUInteger, BOOL *);

@end
@implementation BlockTester

-(void)runTests{

    
    //1 - Creating and calling a block
    void(^MyBlock)(id, NSUInteger, BOOL*) = ^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
        NSLog(@"Video game :%@", (NSString *)obj);
    };
    BOOL stop;
    MyBlock (@"Path of exile",0,&stop);
    
    
    //2- Passing a block to a method
    NSArray *videoGames = @[@"Fallout 2", @"Deus Ex", @"Final Fantasy IV"];
    [videoGames enumerateObjectsUsingBlock:MyBlock];
    
    
    //3 - inline form (MOST COMMON)
    NSString *favGame = @"Fallout 2";
    
     __block int countOfGames = 0; //moves variable to heap and update it later
    
    [videoGames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
        NSString *game = (NSString *)obj;
        if ([game isEqualToString:favGame]) {
            NSLog(@"w00t %@ is my favorite game!",game);
        }
        
        NSLog(@"Video game :%@", (NSString *)obj);
        countOfGames++;
    }];
    
    NSLog(@"count of games is %d",countOfGames);
     __weak BlockTester *weakSelf = self;
    
    //4- calling a method with a block as a parameter
    [self doSomethingWithBlock:^(id obj, NSUInteger  idx, BOOL *stop) {
        //STEP 4 : IT LOGGED THAT IT WAS DONE
        //NSLog(@"Done");
       
        [weakSelf logDone];
    }];
    
    //STEP 1 : WE CRAETED A BLOCK WITH CODE
    
}




-(void)doSomethingWithBlock:(void(^)(id,NSUInteger,BOOL *))block{

    
    //STEP 2 :WE STORED THE BLOCK IN A VARIABLE (PROPERTY)
    //store the clock in property to use later
    self.Block = block;
    [self performSelector:@selector(afterOneSecond) withObject:nil afterDelay:1.5];

}


-(void)logDone{

NSLog(@"Done");
}
-(void)afterOneSecond{

    //STEP 3: A SECOND LATER THAT BLOCK (IN A VARIABLE) WAS CALLED WITH A STRING LEGEND OF ZELDA
    BOOL stop;
    self.Block(@"The Legend of Zelda",0,&stop);
}

-(void)dealloc{
    NSLog(@"Deallocated");
}
@end
