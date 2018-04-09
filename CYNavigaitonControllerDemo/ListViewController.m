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


@interface ListViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,CYAnimatedTransitionSourceViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic) UICollectionViewCell *sourceCell;
@end

static NSString * const CellReuseIdentifier = @"CellReuseIdentifier";

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    [self setupUI];
}

- (void)setupNav {
 
    self.navigationItem.title = @"CYAnimatedTranstion";
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

#pragma mark - collectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    
    cell.contentView.layer.shadowOffset = CGSizeMake(5, 5);
    cell.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.contentView.layer.shadowOpacity = 0.4;
    cell.contentView.layer.shadowRadius = 5;
    
    cell.layer.cornerRadius = 20;
 
    // Configure the cell
    ((UILabel *)[[cell contentView] viewWithTag:10]).layer.borderColor = ((UILabel *)[[cell contentView] viewWithTag:10]).textColor.CGColor;
    ((UILabel *)[[cell contentView] viewWithTag:10]).layer.borderWidth = 3;
    ((UILabel *)[[cell contentView] viewWithTag:10]).layer.cornerRadius = 20;
    
    switch (indexPath.section) {
        case 0:
            
            ((UILabel *)[[cell contentView] viewWithTag:10]).text = @"自定义Present";
            break;
        case 1:
            
            ((UILabel *)[[cell contentView] viewWithTag:10]).text = [NSString stringWithFormat:@"自定义push"];
            break;
        case 2:
            ((UILabel *)[[cell contentView] viewWithTag:10]).text = [NSString stringWithFormat:@"present模仿push"];

            break;
            
        default:
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    DetailViewController *detailVC = [board instantiateViewControllerWithIdentifier: @"detailVC"];

    if (indexPath.section == 0) {
        
        //自定义present
        CYMagicMoveTransition *animatedTransition = [[CYMagicMoveTransition alloc] init];
        animatedTransition.sourceViewDataSource = self;
        animatedTransition.destinationViewDataSource = detailVC;
        animatedTransition.delegate = detailVC;
        [detailVC setCY_presentAnimatedTransition:animatedTransition];
        [self presentViewController:detailVC animated:YES completion:nil];
    } else if (indexPath.section == 1) {
        
        //自定义push
        CYMagicMoveTransition *animatedTransition = [[CYMagicMoveTransition alloc] init];
        animatedTransition.sourceViewDataSource = self;
        animatedTransition.destinationViewDataSource = detailVC;
        animatedTransition.delegate = detailVC;
        [detailVC setCY_pushAnimatedTransition:animatedTransition forSourceViewController:self];
        [self.navigationController pushViewController:detailVC animated:YES];
    } else {
        
        //用present自定义系统push
        if (indexPath.row == 0) {
            
            detailVC.isNeedCY_customedNavigationBar = YES;
        } else {
            
            detailVC.isNeedCY_customedNavigationBar = NO;
        }
        [detailVC cy_presentFromTopViewControllerWithAnimated:YES];
    }
}


#pragma mark - CYAnimatedTransitionDataSource

- (UIView *)sourceViewForCYAnimatedTransition:(CYBaseAnimatedTransition *_Nullable)animatedTransition; {

    NSIndexPath *sourceIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    return [[self.collectionView cellForItemAtIndexPath:sourceIndexPath] viewWithTag:1];
}

@end
