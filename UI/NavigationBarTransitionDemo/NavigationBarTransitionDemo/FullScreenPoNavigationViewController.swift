//
//  FullScreenPoNavigationViewController.swift
//  NavigationBarTransitionDemo
//
//  Created by 杨晴贺 on 2017/5/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class FullScreenPoNavigationViewController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let popGesture = self.interactivePopGestureRecognizer
        let popTarget = popGesture?.delegate
        let popView = popGesture!.view!
        popGesture?.isEnabled = false
        
        let popSelector = NSSelectorFromString("handleNavigationTransition:")
        let fullScreenPoGesture = UIPanGestureRecognizer(target: popTarget, action: popSelector)
        fullScreenPoGesture.delegate = self
        
        popView.addGestureRecognizer(fullScreenPoGesture)
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.childViewControllers.count > 1 {
            return true
        }
        return false
    }

}
