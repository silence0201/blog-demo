//
//  ViewControllerDemo1.swift
//  NavigationBarTransitionDemo
//
//  Created by 杨晴贺 on 2017/5/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewControllerDemo5: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    
    @IBAction func dismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
