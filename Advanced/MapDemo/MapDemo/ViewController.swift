//
//  ViewController.swift
//  MapDemo
//
//  Created by 杨晴贺 on 2017/4/24.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let testArray = ["小明A","小红BB","","小白CCC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapTest()
        flatmapTest()
    }
    
    func mapTest() {
        let another = testArray.map { (str) -> Int? in
            let length = str.characters.count
            if length > 0 {
                return length
            }
            return nil
        }
        
        print("Map转换后的数组为:\(another)")
    }
    
    func flatmapTest() {
        let another = testArray.flatMap { (str) -> Int? in
            let length = str.characters.count
            if length > 0 {
                return length
            }
            return nil
        }
        
        print("FlatMap转换后的数组为:\(another)")
    }


}

