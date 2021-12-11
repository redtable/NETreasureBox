//
//  NEWebViewController.m
//  WallGrass
//
//  Created by WangSen on 2020/12/10.
//

#import "NEWebViewController.h"
#import <WebKit/WebKit.h>
#import "UIViewController+NEParam.h"
#import "UIViewController+NENavigationBar.h"
#import "UIViewController+NELoading.h"
#import <UINavigationController+FDFullscreenPopGesture.h>

@interface NEWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation NEWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeInitialiseConfig];
    [self createViewHierarchy];
    [self layoutContentViews];
    [self loadData];
}

- (void)makeInitialiseConfig {
    self.titleLabel.text = [self.params objectForKey:@"title"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
}

- (void)createViewHierarchy {
    [self.view addSubview:self.ne_navigationBar];
    [self.ne_navigationBar addSubview:self.backButton];
    [self.ne_navigationBar addSubview:self.titleLabel];
    [self.view addSubview:self.webView];
}

- (void)layoutContentViews {
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44.f, 44.f));
        make.left.mas_equalTo(3.f);
        make.bottom.equalTo(self.ne_navigationBar);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.bottom.equalTo(self.backButton);
        make.left.mas_equalTo(50.f);
        make.right.mas_equalTo(-50.f);
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.ne_navigationBar.mas_bottom);
    }];
}

#pragma mark - Load Data -

- (void)loadData {
    [self ne_startLoading];
    NSString * url = [self.params objectForKey:@"url"];
    if (url.length) {
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:30];
        [self.webView loadRequest:request];
        return;
    }
    NSString * localName = [self.params objectForKey:@"localName"];
    if (localName.length) {
        NSURL * URL = [[NSBundle mainBundle] URLForResource:localName withExtension:@"html"];
        [self.webView loadFileURL:URL allowingReadAccessToURL:URL];
    }
}

#pragma mark - Actions -

- (void)tapBackButtonAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - WKNavigationDelegate -

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self ne_stopLoading];
}

#pragma mark - Getters -

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = NEFontBold(16);
        _titleLabel.textColor = RGBColor(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.bounds = CGRectMake(0, 0, 44.f, 44.f);
        [_backButton setImageEdgeInsets:UIEdgeInsetsMake(12.5f, 18.f, 12.5f, 14.f)];
        [_backButton setImage:NETImageFile(@"t_navigationbar_back") forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(tapBackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.preferences.minimumFontSize = 0.0f;
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end
