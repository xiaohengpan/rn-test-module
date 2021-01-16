//
//  MiSnapResourceLocator+CorrectBundle.m
//
//  Created by David McRae jr on 5/24/18.
//
#import <objc/runtime.h>
#import "MiSnapSDKResourceLocator+CorrectBundle.h"
#import <MiSnapSDK/MiSnapSDK.h>
#import "MiSnapSDKViewControllerUX2.h"

@implementation MiSnapSDKResourceLocator (CorrectBundle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelectors[] = {@selector(getLocalizedImage:),
            @selector(getLocalizedString:),
            @selector(getLocalizedImage:withOrientation:withOrientationMode:),
            @selector(getLocalizedTutorialImage:withOrientation:withOrientationMode:)
        };
        
        SEL swizzledSelectors[] = {@selector(d3GetLocalizedImage:),
            @selector(d3GetLocalizedString:),
            @selector(d3GetLocalizedImage:withOrientation:withOrientationMode:),
            @selector(d3GetLocalizedTutorialImage:withOrientation:withOrientationMode:)
        };
        
        for (int i = 0; i < sizeof(originalSelectors)/sizeof(originalSelectors[0]); i++) {
            SEL originalSelector = originalSelectors[i];
            SEL swizzledSelector = swizzledSelectors[i];
        
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL didAddMethod =
            class_addMethod(class,
                            originalSelector,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(class,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    });
}
    
# pragma mark - Swizzled Methods
    
- (UIImage*)d3GetLocalizedImage:(NSString *)imageName withOrientation:(UIInterfaceOrientation)orientation {
    NSBundle* miSnapBundle = [NSBundle bundleForClass:MiSnapSDKViewControllerUX2.class];
    
    UIImage *image = nil;
    
    switch (orientation)
    {
        case UIInterfaceOrientationLandscapeRight:
        case UIInterfaceOrientationLandscapeLeft:
            image = [UIImage imageNamed:imageName inBundle:miSnapBundle compatibleWithTraitCollection:nil];
            break;
            
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        case UIInterfaceOrientationUnknown:
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_portrait", imageName] inBundle:miSnapBundle compatibleWithTraitCollection:nil];
            break;
    }
    
    return image;
}

- (UIImage*)d3GetLocalizedImage:(NSString *)imageName withOrientation:(UIInterfaceOrientation)orientation withOrientationMode:(MiSnapOrientationMode)orientationMode {
    NSBundle* miSnapBundle = [NSBundle bundleForClass:MiSnapSDKViewControllerUX2.class];
    
    UIImage *image = nil;
    
    switch (orientation)
    {
        case UIInterfaceOrientationLandscapeRight:
        case UIInterfaceOrientationLandscapeLeft:
        image = [UIImage imageNamed:imageName inBundle:miSnapBundle compatibleWithTraitCollection:nil];
        break;
        
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        case UIInterfaceOrientationUnknown:
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_portrait", imageName] inBundle:miSnapBundle compatibleWithTraitCollection:nil];
        break;
    }
    
    return image;
}

- (UIImage*)d3GetLocalizedTutorialImage:(NSString *)imageName withOrientation:(UIInterfaceOrientation)orientation withOrientationMode:(MiSnapOrientationMode)orientationMode {
    return [self getLocalizedImage:imageName withOrientation:orientation withOrientationMode:orientationMode];
}
    
- (NSString*)d3GetLocalizedString:(NSString*)key {
    NSBundle* miSnapBundle = [NSBundle bundleForClass:MiSnapSDKViewControllerUX2.class];
    NSString *text = [miSnapBundle localizedStringForKey:key value:nil table:@"MiSnapSDKLocalizable"];
    
    return text;
}
    
@end
