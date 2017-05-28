//
//  NavigationBarBackgroudView.swift
//  NavigationBarTransitionDemo
//
//  Created by 杨晴贺 on 2017/5/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class NavigationBarBackgroudView: UIView {

    override var frame: CGRect {
        didSet {
            let screenSize = UIScreen.main.bounds.size
            super.frame.size = CGSize(width: screenSize.width, height: 64.0)
        }
    }

}
