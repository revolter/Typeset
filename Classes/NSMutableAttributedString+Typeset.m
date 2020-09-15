//
//  NSMutableAttributedString+Typeset.m
//  Typeset
//
//  Created by apple on 15/5/26.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "NSMutableAttributedString+Typeset.h"
#import "TypesetKit.h"
#import <objc/runtime.h>

@implementation NSMutableAttributedString (Typeset)

- (TypesetKit *)typeset {
    TypesetKit *typeset = objc_getAssociatedObject(self, @selector(typeset));
    if (!typeset) {
        typeset = [[TypesetKit alloc] init];
        typeset.string = [[NSMutableAttributedString alloc] initWithAttributedString:self];
        objc_setAssociatedObject(self, @selector(typeset), typeset, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return typeset;
}

- (NSMutableAttributedString *(^)(id))append {
    return ^(id string) {
        if (!string) return self;
        NSAssert([string isKindOfClass:[NSString class]] ||
                 [string isKindOfClass:[NSAttributedString class]] ||
                 [string isKindOfClass:[NSMutableAttributedString class]], @"String passed into this method should be NSString，NSAttributedString or NSMutableAttributedString.");

        NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] init];
        if ([string isKindOfClass:[NSString class]]) {
            mas = [[NSMutableAttributedString alloc] initWithString:string];
        } else if ([string isKindOfClass:[NSAttributedString class]]) {
            mas = [[NSMutableAttributedString alloc] initWithAttributedString:string];
        } else {
            mas = (NSMutableAttributedString *)string;
        }
        [self appendAttributedString:mas];
        return self;
    };
}

- (NSMutableAttributedString *)bold {
    return self.typeset.bold.string;
}

- (NSMutableAttributedString *(^)(UIColor *))color {
    return ^(UIColor *color) {
        return self.typeset.color(color).string;
    };
}

- (NSMutableAttributedString *(^)(NSUInteger))hexColor {
    return ^(NSUInteger hexColor) {
        return self.typeset.hexColor(hexColor).string;
    };
}

- (NSMutableAttributedString *(^)(NSUInteger))fontSize {
    return ^(NSUInteger fontSize) {
        return self.typeset.fontSize(fontSize).string;
    };
}

- (NSMutableAttributedString *(^)(NSString *))fontName {
    return ^(NSString *fontName) {
        return self.typeset.fontName(fontName).string;
    };
}

- (NSMutableAttributedString *(^)(NSString *, CGFloat))font {
    return ^(NSString *fontName, CGFloat fontSize) {
        return self.typeset.font(fontName, fontSize).string;
    };
}

- (NSMutableAttributedString *(^)(UIFont *))exactFont {
    return ^(UIFont *font) {
        return self.typeset.exactFont(font).string;
    };
}

- (NSMutableAttributedString *(^)(BOOL))accessibilitySpeechPunctuation {
    return ^(BOOL active) {
        return self.typeset.accessibilitySpeechPunctuation(active).string;
    };
}

- (NSMutableAttributedString *(^)(NSString *))accessibilitySpeechLanguage {
    return ^(NSString *language) {
        return self.typeset.accessibilitySpeechLanguage(language).string;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))accessibilitySpeechPicth {
    return ^(CGFloat pitch) {
        return self.typeset.accessibilitySpeechPicth(pitch).string;
    };
}

- (NSMutableAttributedString *(^)(BOOL))accessibilitySpeechQueueAnnouncement {
    return ^(BOOL active) {
        return self.typeset.accessibilitySpeechQueueAnnouncement(active).string;
    };
}

- (NSMutableAttributedString *(^)(NSString *))accessibilitySpeechIPANotation {
    return ^(NSString *notation) {
        return self.typeset.accessibilitySpeechIPANotation(notation).string;
    };
}

- (NSMutableAttributedString *(^)(BOOL))accessibilitySpeechSpellOut {
    return ^(BOOL active) {
        return self.typeset.accessibilitySpeechSpellOut(active).string;
    };
}

@end
