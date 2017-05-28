//
//  ViewControllerDemo13.swift
//  NavigationBarTransitionDemo
//
//  Created by 杨晴贺 on 2017/5/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewControllerDemo33: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundView = NavigationBarBackgroudView()
        backgroundView.backgroundColor = UIColor.kcBlue
        self.view.addSubview(backgroundView)
    }

}
