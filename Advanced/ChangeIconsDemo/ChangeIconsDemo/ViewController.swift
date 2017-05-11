//
//  ViewController.swift
//  ChangeIconsDemo
//
//  Created by 杨晴贺 on 2017/5/11.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changeAction(_ sender: UIButton) {
        if UIApplication.shared.supportsAlternateIcons {
            print("支持更换图标")
        }else {
            print("不支持更换图标")
            return
        }
        
        let iconName = UIApplication.shared.alternateIconName
        if let icon = iconName {
            //  更换为系统默认图标
            UIApplication.shared.setAlternateIconName(nil, completionHandler: { (error) in
                if let e = error {
                    print("更换失败\(e)")
                }
                print("改变了\(icon)")
                print("更换成功")
            })
        } else {
            // 更换图标
            UIApplication.shared.setAlternateIconName("newIcon", completionHandler: { (error) in
                if let err = error {
                    print("更换失败\(err)")
                }
                print("更换成功")
            })
        }
    }
    


}

