//
//  MiSnapResourceLocator+CorrectBundle.h
//
//  Created by David McRae jr on 5/24/18.
//

#import <Foundation/Foundation.h>
#import <MiSnapSDK/MiSnapSDK.h>

@interface MiSnapSDKResourceLocator (CorrectBundle)

- (UIImage*)d3GetLocalizedImage:(NSString *)imageName;
- (UIImage*)d3GetLocalizedImage:(NSString *)imageName withOrientation:(UIInterfaceOrientation)orientation withOrientationMode:(MiSnapOrientationMode)orientationMode;
- (UIImage*)d3GetLocalizedTutorialImage:(NSString *)imageName withOrientation:(UIInterfaceOrientation)orientation withOrientationMode:(MiSnapOrientationMode)orientationMode;
- (NSString*)d3GetLocalizedString:(NSString*)key;

@end
