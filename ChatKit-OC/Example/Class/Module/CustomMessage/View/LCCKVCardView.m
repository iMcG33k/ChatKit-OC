//
//  LCCKVCardView.m
//  ChatKit-OC
//
//  v0.5.4 Created by 陈宜龙 on 16/8/15.
//  Copyright © 2016年 ElonChan. All rights reserved.
//

#import "LCCKVCardView.h"
#if __has_include(<SDWebImage/UIImageView+WebCache.h>)
#import <SDWebImage/UIImageView+WebCache.h>
#else
#import "UIImageView+WebCache.h"
#endif

#if __has_include(<ChatKit/LCChatKit.h>)
#import <ChatKit/LCChatKit.h>
#else
#import "LCChatKit.h"
#endif

@interface LCCKVCardView()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, copy) NSString *clientId;

@end

@implementation LCCKVCardView

+ (id)vCardView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
}

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    self.backgroundColor = LCCK_CONVERSATIONVIEWCONTROLLER_BACKGROUNDCOLOR;
    self.contentView.backgroundColor = LCCK_CONVERSATIONVIEWCONTROLLER_BACKGROUNDCOLOR;
    [self.nameLabel sizeToFit];
    LCCKAvatarImageViewCornerRadiusBlock avatarImageViewCornerRadiusBlock = [LCChatKit sharedInstance].avatarImageViewCornerRadiusBlock;
    if (avatarImageViewCornerRadiusBlock) {
        CGFloat avatarImageViewCornerRadius = avatarImageViewCornerRadiusBlock(self.avatarView.frame.size);
        [self.avatarView lcck_cornerRadiusAdvance:avatarImageViewCornerRadius rectCornerType:UIRectCornerAllCorners];
    }
    UITapGestureRecognizer *tapGestureRecognizer =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vCardClicked)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)vCardClicked {
    !self.vCardDidClickedHandler ?: self.vCardDidClickedHandler(self.clientId);
}

- (void)configureWithAvatarURL:(NSURL *)avatarURL title:(NSString *)title clientId:(NSString *)clientId {
    NSString *imageName = @"Placeholder_Avatar";
    UIImage *image = [UIImage lcck_imageNamed:imageName bundleName:@"Placeholder" bundleForClass:[LCChatKit class]];
    UIImage *avatarImage = image;
    [self.avatarView sd_setImageWithURL:avatarURL placeholderImage:avatarImage];
    self.nameLabel.text = title;
    self.clientId = clientId;
}

@end
