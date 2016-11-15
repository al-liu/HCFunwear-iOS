# 仿写有范儿 app
效果图如下：

![](http://ogo5n91bk.bkt.clouddn.com/HCFunwear02.gif)

## 为什么仿写 app
在 iOS 开发中有着大量的技术实现，架构方式。而在我们实际的工作中，因为业务或者设计的需要，很难有机会触及到这些内容。这个时候，我们就可以通过仿写别人 app 的方式，去实践一些自己的想法和在工作中很难接触到的技术。
比如：当你在仿写相机类 app 的时候，可能会接触到很多滤镜方面的技术。当在仿写阅读类 app 的时候，就会涉及 CoreText 排版方面的技术。而我仿写有范儿主要是想实践一下 **MVVM** 和 **ReactiveCocoa** 结合起来的一种架构方式。
对于刚接触 iOS 或者其他技术的人，想要学的更多，最好的方法就是实践，如果在工作中没有更多的实践机会，最好的方法就是仿写，造轮子。在项目中会涉及到很多在看资料中涉及不到的细节问题，想办法解决它们，这对于提高解决问题的能力上很有帮助。

## 为什么是有范儿
在我看过的众多电商应用里，非常喜欢有范儿 app 的设计，再打开应用之后界面给人一种清新简洁的感觉，总之，就是很有 b 格。对于我来说，能去实现下自己喜欢的设计的 app，会让人感到愉悦。

## 仿写目的
仿写的目的是为了实践一些东西，我的目的就是想实践一下 **MVVM** 和 **ReactiveCocoa** 的架构方式。
简单介绍下我是怎么用的。(个人理解可能有误，欢迎拍砖。)
### View
View 层面包括，View 和 ViewController。当要实现一个界面的时候，先简单分析下界面的构成，然后对它进行拆分。看下整体是使用 `UITableView` 还是 `UICollectionView` 或者直接 `UIScrollView` 实现起来更方便更合理，把里面能够重用的部分和看起来较完整的部分抽出一个 View 进行实现。当这些 View 的模块都构成好之后，我们可以拿到 ViewController 中去拼装一下，这样完整的界面就出来了，很像是搭积木。

如下：

```
- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    topView = [[TopCategoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-80, 44)];
    topView.delegate = self;
    
    _scrollView = ({
        UIScrollView *view = [UIScrollView new];
        view.pagingEnabled = YES;
        view.delegate = self;
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        view;
    });
    
    NSNumber *pageWidth = [NSNumber numberWithFloat:CGRectGetWidth(self.view.frame)];
    
    _topHotPageView = ({
        TopHotPageView *view = [TopHotPageView new];
        [view bindViewModel:self.viewModel];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view).offset(64);
            make.left.equalTo(_scrollView);
            make.width.equalTo(pageWidth);
        }];
        
        view;
    });
    
    _topCategoryPageView = ({
        TopCategoryPageView *view = [TopCategoryPageView new];
        [view bindViewModel:self.viewModel];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topHotPageView.mas_right);
            make.top.bottom.width.equalTo(_topHotPageView);
        }];
        
        view;
    });
    
    _topBrandPageView = ({
        TopBrandPageView *view = [TopBrandPageView new];
        [view bindViewModel:self.viewModel];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topCategoryPageView.mas_right);
            make.top.bottom.width.equalTo(_topHotPageView);
            make.right.equalTo(_scrollView);
        }];
        
        view;
    });
    
}

```

### ViewModel
ViewModel 并不是完全的承接在 **MVC** 中 ViewController 的工作，比如将所有页面相关的业务逻辑放到 ViewModel 中，这样 ViewModel 迟早会变得臃肿，不容易维护。它更像是调度室，将 View 中的事件，业务，功能和 ViewModel 绑定起来，当然这其中需要 RAC 的帮助，因为在 ViewModel 中绝不能引用到 View。在我的脑子中就想象 View 上有很多插孔，它们代表很多事件，RAC 就像一根根的线插到这些孔里，另一头插在 ViewModel 上。界面上需要做哪些工作，都会反应到 ViewModel 上，ViewModel 会引用一个实现了一个 service （定义的协议）的 imp 类。具体的工作就在这个 imp 类里，它处理完结果之后返回给 ViewModel ，ViewModel 再把结果通过这些 ‘线’ 传回到 View 中。这样大家角色清晰，分工明确，谁做了哪些工作一目了然。
ViewModel 里也可引用小 ViewModel，它们不做具体的调度处理，只做一些绑定工作，主要对接像 cell 或者其他 View 的事件。这样能让结构更清楚一些。

如下：

```
@interface CategoryPageViewModel : HCBaseViewModel

@property (nonatomic, strong, readonly) RACCommand *layoutRequestCommand;
@property (nonatomic, strong, readonly) RACCommand *categorysRequestCommand;
@property (nonatomic, strong, readonly) RACCommand *brandsRequestCommand;
@property (nonatomic, strong, readonly) RACCommand *pushCommand;

@property (nonatomic, strong, readonly) HCCategoryLayout *hotLayout;
@property (nonatomic, strong, readonly) NSArray *cateList;
@property (nonatomic, strong, readonly) NSMutableArray *brandList;

@property (nonatomic, strong, readonly) NSArray *topTitlesList;
@property (nonatomic, assign) NSInteger brandsPageIndex;

@property (nonatomic, assign) BOOL refreshHotFlag;
@property (nonatomic, assign) BOOL refreshCategoryFlag;
@property (nonatomic, assign) BOOL refreshBrandFlag;

@end
@interface CategoryPageViewModel ()

@property (strong, nonatomic, readonly) id <HCCategoryViewModelServices> services;

@property (nonatomic, strong, readwrite) RACCommand *layoutRequestCommand;
@property (nonatomic, strong, readwrite) RACCommand *categorysRequestCommand;
@property (nonatomic, strong, readwrite) RACCommand *brandsRequestCommand;
@property (nonatomic, strong, readwrite) RACCommand *pushCommand;

@property (nonatomic, strong, readwrite) HCCategoryLayout *hotLayout;
@property (nonatomic, strong, readwrite) NSArray *cateList;
@property (nonatomic, strong, readwrite) NSMutableArray *brandList;

@property (nonatomic, strong, readwrite) NSArray *topTitlesList;

@end

@implementation CategoryPageViewModel
@dynamic services;

- (void)initialize {
    
    _cateList = [NSArray array];
    _brandList = [NSMutableArray array];
    _topTitlesList = @[@"热门",@"品类",@"品牌"];
    _brandsPageIndex = 0;
    _refreshHotFlag = YES;
    _refreshCategoryFlag = YES;
    _refreshBrandFlag = YES;
    
    self.layoutRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeHotSignal];
    }];
    self.categorysRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeCateSignal];
    }];
    self.brandsRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeBrandSignal:(NSInteger)input];
    }];
    self.pushCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self executePushSignal:input];
    }];
}

- (RACSignal *)executeHotSignal {
    @weakify(self);
    return [[[self.services getCategoryApiService] getHotTapData] map:^id(id value) {
        @strongify(self);
        self.hotLayout = [HCCategoryLayout modelWithJSON:value[@"data"]];
        return self.hotLayout;
    }];
}

- (RACSignal *)executeCateSignal {
    return [[[self.services getCategoryApiService] getCateTapData] map:^id(id value) {
        self.cateList = [NSArray modelArrayWithClass:HCCategory.class json:value[@"data"]];
        return self.cateList;
    }];
}

- (RACSignal *)executeBrandSignal:(NSInteger)pageIndex {
    return [[[self.services getCategoryApiService] getBrandDataWithIndexPage:_brandsPageIndex] map:^id(id value) {
        NSArray *data = [NSArray modelArrayWithClass:HCBrand.class json:value[@"data"]];
        NSMutableArray *mutableData = [NSMutableArray arrayWithArray:_brandList];
        [mutableData addObjectsFromArray:data];
        self.brandList = mutableData;
        return self.brandList;
    }];
}

- (RACSignal *)executePushSignal:(id)viewModel {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.services pushViewModel:viewModel animated:YES];
        [subscriber sendCompleted];
        return nil;
    }];
}

@end

```

### Service，IMP 和 Model
Service 是一个协议，它定义整个界面需要的行为，比如，点击一个按钮，跳转到详情页面，这个跳转的逻辑要在 Service 中定义好。进入页面发起一些网络请求获取数据，这些 api 的调用可以放到协议中定义好。一个界面做了哪些工作，看一眼 Service 就一目了然了。

```
//基础服务
@protocol HCBaseService <NSObject, HCNavigationService>

@end
@protocol HCCategoryViewModelServices <HCBaseService>

//主服务
- (id<HCCategoryApiServices>)getCategoryApiService;

@end

//子服务 api
@protocol HCCategoryApiServices <NSObject>

- (RACSignal *)getHotTapData;
- (RACSignal *)getCateTapData;
- (RACSignal *)getBrandDataWithIndexPage:(NSInteger)indexPage;

@end

```
目前 `HCCategoryViewModelServices` 主服务里没有其他相关的业务逻辑，所以就只引用了 api 服务。
IMP，就是对这些服务的具体实现，供 ViewModel 调用。

如下：

```
@interface HCCategoryViewModelServicesImp ()

@property (nonatomic, strong) HCCategoryApiServicesImpl *cateServiceImpl;

@end

@implementation HCCategoryViewModelServicesImp

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cateServiceImpl = [HCCategoryApiServicesImpl new];
    }
    return self;
}

- (id<HCCategoryApiServices>)getCategoryApiService {
    return self.cateServiceImpl;
}

- (void)pushViewModel:(__nullable id)viewModel animated:(BOOL)animated {
    [super pushViewModel:viewModel animated:animated];
}

@end

```
Model，包括网络接口的数据模型和 api 的模型。

示意图：

![mvvm & rac](http://ogo5n91bk.bkt.clouddn.com/MVVMRAC.png)

## 仿写流程 和 注意事项
首先，获取这个程序的 api 接口，从启动开始，到要实现的每个界面，最好按照一定的业务流程。如：商品列表到商品详情，再到购买页。
工具可以使用，**Charles** 。设置好手机无线网的代理，打开 app 就可以抓到接口了。抓到接口之后再使用 **Postman** ，记录下来，方便查看参数和返回的数据。
我们有了接口之后就可以通过它返回的数据，分析怎么更好的布局页面。我刚开始的时候，不是这么做的，而是先截图界面，去构建 UI，待后来开始分析接口的时候，才发现，它的首页都是根据接口返回的数据，动态生成的，而不是我理解的固定的界面模版。比如：它的限时抢购有时有有时没有，它的几个广告栏的个数也是不确定的，等等。
只有这些接口的结构确定了，界面，业务逻辑等才能无缝的嵌进去。

获取程序的 ipa 安装包，在安装包里获取所需要的图片资源。
构建 UI 还可以使用工具 **Reveal** ，能帮助我们查看仿写 app 的界面结构，这主要是在我们对某个界面的写法上没有头绪或者想看下别人的实现方法上很有帮助。

尽量把工作拆分出来，定个完成时间，能帮助自己提高些效率。使用 Git 管理自己的项目。

## 最后
希望大家能多提宝贵意见，我会不断完善。










