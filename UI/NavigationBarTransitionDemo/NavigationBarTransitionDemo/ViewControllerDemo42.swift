//
//  ViewControllerDemo13.swift
//  NavigationBarTransitionDemo
//
//  Created by 杨晴贺 on 2017/5/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewControllerDemo42: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(color:UIColor.kcGreen), for: .default)
        self.transitionCoordinator?.animateAlongsideTransition(in: view, animation: { (context) in
            self.navigationController?.navigationBar.alpha = 0.0
        }, completion: { (context) in
            debugPrint("complete")
        })
    }
    
}