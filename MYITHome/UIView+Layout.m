//
//  UIView+Layout.m
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)
- (CGFloat)size_X{
    return self.frame.origin.x;
}
- (CGFloat)size_Y{
    return self.frame.origin.y;
}
- (CGFloat)size_Width{
    return self.frame.size.width;
}
- (CGFloat)size_Height{
    return  self.frame.size.height;
}
- (CGFloat)size_X_Width{
    return self.frame.origin.x+self.frame.size.width;
}
- (CGFloat)size_Y_Height{
    return self.frame.origin.y+self.frame.size.height;
}
@end
