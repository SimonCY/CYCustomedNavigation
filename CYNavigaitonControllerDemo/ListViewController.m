//
//  ViewController.m
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString * const CellReuseIdentifier = @"CellReuseIdentifier";

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(18, 0, 0, 0);
    
    layout.itemSize = CGSizeMake((self.view.bounds.size.width - 18 * 3) / 2,(self.view.bounds.size.width - 18 * 3) / 2 * 1.5);
    
    layout.sectionInset = UIEdgeInsetsMake(40,18,18,18);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.minimumLineSpacing = 18;
    
    layout.minimumInteritemSpacing = 18;
 
}

#pragma mark - collectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    ((UILabel *)[[cell contentView] viewWithTag:10]).layer.borderColor = ((UILabel *)[[cell contentView] viewWithTag:10]).textColor.CGColor;
    ((UILabel *)[[cell contentView] viewWithTag:10]).layer.borderWidth = 3;
    
    if (indexPath.section == 0) {
        ((UILabel *)[[cell contentView] viewWithTag:10]).text = @"自定义动画";
    } else {
        
        ((UILabel *)[[cell contentView] viewWithTag:10]).text = [NSString stringWithFormat:@"controller %@", @(indexPath.item)];
    }
    
    
    return cell;
}



@end
