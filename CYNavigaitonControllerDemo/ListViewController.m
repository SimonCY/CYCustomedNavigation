//
//  ViewController.m
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "ListViewController.h"
#import "CYMagicMoveTransition.h"
#import "DetailViewController.h"

@interface ListViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,CYMagicMoveTransitionFromViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic) CYMagicMoveTransition *animatedTransition;

@property (strong,nonatomic) UICollectionViewCell *sourceCell;
@end

static NSString * const CellReuseIdentifier = @"CellReuseIdentifier";

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    
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

#pragma mark - getter

- (CYMagicMoveTransition *)animatedTransition {

    if (_animatedTransition == nil) {
        _animatedTransition = [[CYMagicMoveTransition alloc] init];
        _animatedTransition.fromViewDataSource = self;
    }
    return _animatedTransition;
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

    NSIndexPath *sourceIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    self.sourceCell = [self.collectionView cellForItemAtIndexPath:sourceIndexPath];

    DetailViewController *detailVC = segue.destinationViewController;
    self.animatedTransition.toViewDataSource = detailVC;
    self.animatedTransition.delegate = detailVC;
}

#pragma mark - CYMagicMoveTransitionDataSource

- (UIView *)fromViewForCYMagicMoveTransition {

    return [self.sourceCell viewWithTag:1];
}

#pragma mark <UINavigationControllerDelegate>

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{

    if ([toVC isKindOfClass:[DetailViewController class]]) {

        return self.animatedTransition;
    }else{
        return nil;
    }
}

@end
