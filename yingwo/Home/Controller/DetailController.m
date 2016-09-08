//
//  DetailController.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "DetailController.h"
#import "AnnounceController.h"
#import "MainNavController.h"

#import "YWDetailTableViewCell.h"
#import "YWDetailBaseTableViewCell.h"
#import "YWDetailReplyCell.h"

#import "DetailViewModel.h"
#import "YWDetailBottomView.h"
#import "YWDetailCommentView.h"
#import "YWCommentView.h"

#import "TieZiComment.h"


@interface DetailController ()<UITableViewDelegate,UITableViewDataSource,YWDetailTabeleViewProtocol,GalleryViewDelegate,UITextFieldDelegate,YWDetailCellBottomViewDelegate,YWKeyboardToolViewProtocol,ISEmojiViewDelegate,HPGrowingTextViewDelegate>

@property (nonatomic, strong) UITableView         *detailTableView;
@property (nonatomic, strong) UIBarButtonItem     *leftBarItem;
@property (nonatomic, strong) UIBarButtonItem     *rightBarItem;

@property (nonatomic, strong) YWDetailBottomView  *replyView;
@property (nonatomic, strong) YWDetailCommentView *commentView;
@property (nonatomic, strong) GalleryView         *galleryView;

@property (nonatomic, strong) DetailViewModel     *viewModel;
@property (nonatomic, strong) RequestEntity       *requestEntity;
@property (nonatomic, strong) TieZiComment        *commentEntity;

@property (nonatomic, strong) UITextField         *popTextField;
@property (nonatomic, strong) UIView              *commentListView;

@property (nonatomic,assign ) CGFloat             navgationBarHeight;

@property (nonatomic, strong) NSMutableArray      *tieZiReplyArr;

@property (nonatomic,assign ) NSInteger           comment_id;

@property (nonatomic, assign) CGFloat keyboardHeight;

@end

@implementation DetailController

static NSString *detailCellIdentifier      = @"detailCell";
static NSString *detailReplyCellIdentifier = @"replyCell";

#pragma mark 懒加载

- (UITableView *)detailTableView {
    if (_detailTableView == nil) {
        _detailTableView                 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _detailTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _detailTableView.backgroundColor = [UIColor clearColor];
        _detailTableView.delegate        = self;
        _detailTableView.dataSource      = self;
        _detailTableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
      //  _detailTableView.fd_debugLogEnabled = YES;
        [_detailTableView registerClass:[YWDetailTableViewCell class] forCellReuseIdentifier:detailCellIdentifier];
        [_detailTableView registerClass:[YWDetailReplyCell class] forCellReuseIdentifier:detailReplyCellIdentifier];

    }
    return _detailTableView;
}

- (DetailViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[DetailViewModel alloc] init];
    }
    return _viewModel;
}

- (RequestEntity *)requestEntity {
    if (_requestEntity == nil) {
        _requestEntity = [[RequestEntity alloc] init];
    }
    return _requestEntity;
}

- (TieZiComment *)commentEntity {
    if (_commentEntity == nil) {
        _commentEntity = [[TieZiComment alloc] init];
    }
    return _commentEntity;
}

- (TieZi *)model {
    if (_model == nil) {
        _model = [[TieZi alloc] init];
    }
    return _model;
}

- (UIBarButtonItem *)leftBarItem {
    if (_leftBarItem == nil) {
        _leftBarItem = [[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"nva_con"] style:UIBarButtonItemStylePlain target:self action:@selector(jumpToConfigurationPage)];
    }
    return _leftBarItem;
}

- (UIBarButtonItem *)rightBarItem {
    if (_rightBarItem == nil) {
        _rightBarItem = [[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:nil];
    }
    return _rightBarItem;
}

- (YWDetailBottomView *)replyView {
    if (_replyView == nil) {
        _replyView                       = [[YWDetailBottomView alloc] init];
        _replyView.messageField.delegate = self;
    }
    return _replyView;
}

- (GalleryView *)galleryView {
    if (_galleryView == nil) {
        _galleryView                 = [[GalleryView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _galleryView.backgroundColor = [UIColor blackColor];
        _galleryView.delegate        = self;
    }
    return _galleryView;
}

- (YWDetailCommentView *)commentView {
    if (_commentView == nil) {
        _commentView                              = [[YWDetailCommentView alloc] initWithFrame:CGRectMake(0,
                                                                                                          0,
                                                                                                        SCREEN_WIDTH,
                                                                                                          45)];
        _commentView.delegate                     = self;
        self.commentView.messageTextView.delegate = self;

    }
    return _commentView;
}

- (UIView *)commentListView {
    if (_commentListView == nil) {
        _commentListView = [[UIView alloc] init];
    }
    return _commentListView;
}

- (NSMutableArray *)tieZiReplyArr {
    if (_tieZiReplyArr == nil) {
        _tieZiReplyArr = [[NSMutableArray alloc] init];
    }
    return _tieZiReplyArr;
}

- (CGFloat)navgationBarHeight {
    //导航栏＋状态栏高度
    return  self.navigationController.navigationBar.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
}



#pragma mark add action

- (void)addAllAction {
    
}

#pragma mark Button action

- (void)jumpToConfigurationPage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)jumpToFollowTieZiPage {
    AnnounceController *announceVC = [self.storyboard instantiateViewControllerWithIdentifier:CONTROLLER_OF_ANNOUNCE_IDENTIFIER];
    announceVC.isFollowTieZi       = YES;
    announceVC.post_id             = self.model.tieZi_id;
    MainNavController *mainNav = [[MainNavController alloc] initWithRootViewController:announceVC];

    [self presentViewController:mainNav animated:YES completion:nil];
}

//跳转传参，这里是跟帖，需要贴子的id
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[AnnounceController class]]) {
        if ([segue.identifier isEqualToString:SEGUE_IDENTIFY_FOLLOW_TIEZI]) {
            AnnounceController *announceVC = segue.destinationViewController;
            announceVC.isFollowTieZi       = YES;
            announceVC.post_id             = self.model.tieZi_id;
        }
    }
}

#pragma mark UITextfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.replyView.messageField) {
        [self jumpToFollowTieZiPage];
    }
    return YES;
}

#pragma  mark UI布局

- (void)setAllUILayout {
    self.replyView.mas_key = @"replyView";
    
    [self.replyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view.mas_bottom).priorityLow();
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化楼主数据
    [self.tieZiReplyArr addObject:self.model];
    
    [self.view addSubview:self.detailTableView];
    [self.view addSubview:self.replyView];
    
    __weak DetailController *weakSelf = self;
    self.detailTableView.mj_header    = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    self.detailTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
    }];
    
    [self.detailTableView.mj_header beginRefreshing];
    
    [self setAllUILayout];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"帖子";
    self.navigationItem.leftBarButtonItem  = self.leftBarItem;
    self.navigationItem.rightBarButtonItem = self.rightBarItem;

    [self judgeNetworkStatus];


}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //监听键盘frame改变事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
}

//键盘弹出后调用
- (void)keyboardWillChangeFrame:(NSNotification *)note {
    
    //获取键盘的frame
    CGRect endFrame     = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = endFrame.size.height;

}

/**
 *  下拉刷新
 */
- (void)loadData {
    
    TieZi *tieZi                  = [self.tieZiReplyArr objectAtIndex:0];
    self.requestEntity.requestUrl = TIEZI_RELPY_URL;
    self.requestEntity.paramaters = @{@"post_id":@(tieZi.tieZi_id)};

    [self loadForType:HeaderReloadDataModel];
    
}

/**
 *  上拉加载
 */
- (void)loadMoreData {
    
    TieZi *tieZi                  = [self.tieZiReplyArr objectAtIndex:0];
    self.requestEntity.requestUrl = TIEZI_RELPY_URL;
    self.requestEntity.paramaters = @{@"post_id":@(tieZi.tieZi_id)};

    [self loadForType:FooterReoladDataModel];
}

- (void)loadForType:(ReloadModel)type{
    
    @weakify(self);
    [[self.viewModel.fetchDetailEntityCommand execute:self.requestEntity] subscribeNext:^(NSArray *tieZiList) {
        @strongify(self);
        if (type == HeaderReloadDataModel) {
            
            //tieZiList 这里应该返回的是model成员数组，不是字典数组
            if (tieZiList.count != 0) {
                
                //最开始里面会存放一个楼主的贴子信息
                if (self.tieZiReplyArr.count == 1) {
                    
                    [self.tieZiReplyArr addObjectsFromArray:tieZiList];
                    NSLog(@"tieZiList.count:%lu",tieZiList.count);
                    NSLog(@"self.tieZiReplyArr.count:%lu",self.tieZiReplyArr.count);
                }
                else {
                    [self.tieZiReplyArr removeAllObjects];
                    [self.tieZiReplyArr addObject:self.model];
                    [self.tieZiReplyArr addObjectsFromArray:tieZiList];
                }
            }
            
            [self.detailTableView.mj_header endRefreshing];
            [self.detailTableView reloadData];
            
        }
        else if (type == FooterReoladDataModel) {
            
            [self.tieZiReplyArr addObjectsFromArray:tieZiList];
            [self.detailTableView.mj_footer endRefreshing];
            [self.detailTableView reloadData];
            
        }
    }];
    
}

#define mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tieZiReplyArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TieZiReply *replyModel;
    replyModel                      = [self.tieZiReplyArr objectAtIndex:indexPath.row];
    NSString *cellIdentifier        = [self.viewModel idForRowByIndexPath:indexPath model:replyModel];

    YWDetailBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle             = UITableViewCellSelectionStyleNone;
    cell.delegate                   = self;
    cell.bottomView.delegate        = self;

    [self.viewModel setupModelOfCell:cell model:replyModel];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TieZiReply *replyModel;
    replyModel                      = [self.tieZiReplyArr objectAtIndex:indexPath.row];
    NSString *cellIdentifier        = [self.viewModel idForRowByIndexPath:indexPath model:replyModel];

    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self.viewModel setupModelOfCell:cell model:replyModel];
    }];
}

//  tableview header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hiddenKeyboard];
}

#pragma mark YWDetailTabeleViewProtocol

- (void)didSeletedImageView:(UIImageView *)seletedImageView {
    
    [self covertImageView:seletedImageView];
}

/**
 *  坐标转换
 *
 *  @param imageView
 */
- (void)covertImageView:(UIImageView *)imageView {
    
    UIImageView *newImageView = [[UIImageView alloc] init];
    newImageView.frame        = [imageView.superview convertRect:imageView.frame toView:self.view];
    newImageView.image        = imageView.image;
    newImageView.y            += self.navgationBarHeight;
    newImageView.tag          = 1;

    [self showImageView:newImageView];
    
}
/**
 *  展示图片
 *
 *  @param imageView
 */
- (void)showImageView:(UIImageView *)imageView {
    
    NSMutableArray *imageViewArr = [NSMutableArray arrayWithCapacity:1];
    [imageViewArr addObject:imageView];
    
    [self.galleryView setImages:imageViewArr showAtIndex:0];
    [self.navigationController.view addSubview:self.galleryView];

}

#pragma mark - GalleryView Delegate

- (void)galleryView:(GalleryView *)galleryView didShowPageAtIndex:(NSInteger)pageIndex
{
}

- (void)galleryView:(GalleryView *)galleryView didSelectPageAtIndex:(NSInteger)pageIndex
{
    [self.galleryView removeImageView];
    
}

- (void)galleryView:(GalleryView *)galleryView removePageAtIndex:(NSInteger)pageIndex {
    self.galleryView = nil;
}

#pragma mark YWDetailCellBottomViewDelegate

- (void)didSelectMessageWith:(NSInteger)post_id onSuperview:(UIView *)view{
    
    //这个textField无实际意义，只为了能弹出键盘用的
    self.popTextField                    = [[UITextField alloc] init];
    self.popTextField.returnKeyType      = UIReturnKeyDone;

    self.popTextField.inputAccessoryView = self.commentView;
    //回贴所在的id
    self.comment_id                      = post_id;

    self.commentListView                 = view;

    [self.view addSubview:self.popTextField];
    [self.popTextField becomeFirstResponder];
}

#pragma mark YWKeyboardToolViewProtocol

- (void)didSelectedEmoji {
    
    [self.commentView.messageTextView becomeFirstResponder];
        
    ISEmojiView *emojiView = [[ISEmojiView alloc] initWithTextField:self.commentView.messageTextView
                                                           delegate:self];
    
    self.commentView.messageTextView.internalTextView.inputView = emojiView;
    [self.commentView.messageTextView.internalTextView reloadInputViews];
}

- (void)didSelectedKeyboard {
    
    [self.commentView.messageTextView becomeFirstResponder];
    
    //先去除表情包的所占的inputView，否则弹不出键盘
    self.commentView.messageTextView.internalTextView.inputView = nil;
    
    self.commentView.messageTextView.internalTextView.keyboardType = UIKeyboardTypeDefault;
    [self.commentView.messageTextView.internalTextView reloadInputViews];
    
}

#pragma mark ISEmojiViewDelegate

-(void)emojiView:(ISEmojiView *)emojiView didSelectEmoji:(NSString *)emoji{
    self.commentView.messageTextView.text = [self.commentView.messageTextView.text stringByAppendingString:emoji];
}

-(void)emojiView:(ISEmojiView *)emojiView didPressDeleteButton:(UIButton *)deletebutton{
    if (self.commentView.messageTextView.text.length > 0) {
        NSRange lastRange = [self.commentView.messageTextView.text rangeOfComposedCharacterSequenceAtIndex:self.commentView.messageTextView.text.length-1];
        self.commentView.messageTextView.text = [self.commentView.messageTextView.text substringToIndex:lastRange.location];
    }
}

#pragma mark HPGrowingTextViewDelegate

- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView {
    
    //没有内容不让发送
    if ([Validate validateIsEmpty:self.commentView.messageTextView.text]) {
    
        [SVProgressHUD showErrorWithStatus:@"请填写内容～"];
        
    }
    else
    {
        [self commentTieZi];
    }
    
    
    return YES;
}
- (void)growingTextView:(HPGrowingTextView *)growingTextView didChangeHeight:(float)height {
    
//    self.commentView.backgroundColor = [UIColor greenColor];
    
    if (height == 0) {
        if (self.commentView.height <= 45) {
            return;
        }
        else
        {
            self.commentView.height -= 45;
        }
    }
    else
    {
//        self.commentView.frame = CGRectMake(0,
//                                            self.commentView.y-height/2,
//                                            self.commentView.width,
//                                            self.commentView.height+height/2);
//        
        [self.commentView.backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(self.commentView);
            make.height.equalTo(@(self.commentView.backgroundView.height+height));
        }];
        [self.commentView.messageTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(self.commentView.backgroundView);
        }];
//        self.commentView.backgroundView.frame = CGRectMake(self.commentView.backgroundView.x,
//                                            self.commentView.backgroundView.y-height,
//                                            self.commentView.width,
//                                            self.commentView.height+height);
//
    }
}

#pragma private method


- (void)commentTieZi {
    
    NSDictionary *paramaters = @{@"post_reply_id":@(self.comment_id),
                                 @"content":self.commentView.messageTextView.text
                                 };
    
    [self.viewModel postCommentWithUrl:TIEZI_COMMENT_URL
                            paramaters:paramaters
                               success:^(StatusEntity *status) {
        
                                   if (status.status == YES) {
                                       [self hiddenKeyboard];
                                       [self addCommentOnReplyTieZi];
                                   }
    } failure:^(NSString *error) {
        
    }];

}

/**
 *  页面上添加评论
 */
- (void)addCommentOnReplyTieZi {
    
    YWDetailReplyCell *cell = (YWDetailReplyCell *)self.commentListView.superview.superview;
    NSIndexPath *indexPath  = [self.detailTableView indexPathForCell:cell];
    
    TieZiReply *replyEntity = [self.tieZiReplyArr objectAtIndex:indexPath.row];
    
    NSDictionary *paramaters = @{@"post_reply_id":@(replyEntity.reply_id)};
    
    [self.viewModel requestForCommentWithUrl:TIEZI_COMMENT_LIST_URL
                                  paramaters:paramaters
                                     success:^(NSArray *commentArr) {
        
                                         [SVProgressHUD showSuccessStatus:@"评论成功"];
                                         
                                         replyEntity.commentArr = [commentArr mutableCopy];
                                         //替换新的评论
                                         [self.tieZiReplyArr replaceObjectAtIndex:indexPath.row
                                                                       withObject:replyEntity];
                                         //更新cell，更新评论
                                         [self.detailTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil]
                                                                     withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSString *error) {
        
    }];

    
}

#pragma mark 收起键盘
- (void)hiddenKeyboard {
    self.commentView.messageTextView.text = @"";
    [self.commentView.messageTextView resignFirstResponder];
    [self.popTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  网路监测
 */
- (void)judgeNetworkStatus {
    [YWNetworkTools networkStauts];
}


@end
