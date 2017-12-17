//
//  ViewController.m
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "ListViewController.h"
#import "CYAnimatedTransition.h"
#import "DetailViewController.h"
#import "aViewController.h"

@interface ListViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,CYAnimatedTransitionSourceViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic) UICollectionViewCell *sourceCell;
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

    CGFloat itemW = (self.view.bounds.size.width - 18 * 3) / 2;
    layout.itemSize = CGSizeMake(itemW,itemW * 1004 / 690);
    
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

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {


    DetailViewController *detailVC = segue.destinationViewController;

    static int a = 0;
    a++;
    if (a%2 == 0) {

        CYMagicMoveTransition *animatedTransition = [[CYMagicMoveTransition alloc] init];
        animatedTransition.sourceViewDataSource = self;
        animatedTransition.destinationViewDataSource = detailVC;
        animatedTransition.delegate = detailVC;
        [detailVC setCY_animatedTransition:animatedTransition forSourceViewController:self];
    }

}

#pragma mark - CYAnimatedTransitionDataSource

- (UIView *)sourceViewForCYAnimatedTransition:(CYBaseAnimatedTransition *_Nullable)animatedTransition; {

    NSIndexPath *sourceIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    return [[self.collectionView cellForItemAtIndexPath:sourceIndexPath] viewWithTag:1];
}

@end
