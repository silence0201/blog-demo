//
//  UIColorExtension.swift
//  NavigationBarTransitionDemo
//
//  Created by 杨晴贺 on 2017/5/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexValue:Int,alpha:Float){
        self.init(red: CGFloat((hexValue & 0xFF0000) >> 16)/255.0, green: CGFloat((hexValue & 0xFF00) >> 8)/255.0, blue: CGFloat(hexValue & 0xFF)/255.0, alpha: CGFloat(alpha))
    }
    
    static let kcRed = UIColor(hexValue: 0xFF6666, alpha: 1.0)
    
    static let kcGreen = UIColor(hexValue: 0x99CC66, alpha: 1.0)

    static let kcBlue = UIColor(hexValue: 0x0099CC, alpha: 1.0)
}
