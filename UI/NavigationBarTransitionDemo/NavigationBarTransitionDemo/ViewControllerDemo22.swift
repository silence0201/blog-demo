//
//  ViewControllerDemo12.swift
//  NavigationBarTransitionDemo
//
//  Created by 杨晴贺 on 2017/5/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

// transparent
class ViewControllerDemo22_1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


// change color
class ViewControllerDemo22_2: UIViewController {
    
    var navigationBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonClick))
        let nextIem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonClick))
        let navigationItem = UINavigationItem(title: "Demo 2-2")
        navigationItem.leftBarButtonItem = backItem
        navigationItem.rightBarButtonItem = nextIem
        
        navigationBar.items = [navigationItem]
        navigationBar.setBackgroundImage(UIImage(color:UIColor.kcGreen), for: .default)
        navigationBar.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 64.0)
        self.view.addSubview(navigationBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Event response
    func backButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func nextButtonClick() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Demo23")
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
