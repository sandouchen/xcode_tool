//
//  SDCollectionViewTest.m
//  Category
//
//  Created by fqq3 on 17/6/2.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDCollectionViewTest.h"
#import "SDFlowLayout.h"

static NSString *const ID = @"cell";

@interface SDCollectionViewTest () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation SDCollectionViewTest

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"流水布局";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    
    // 创建布局
    SDFlowLayout *layout = [[SDFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 20;
    
    // 创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.sd_width, 150) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

@end
