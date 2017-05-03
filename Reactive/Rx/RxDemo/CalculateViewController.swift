//
//  CalculateViewController.swift
//  RxDemo
//
//  Created by 杨晴贺 on 2017/5/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CalculateViewController: UIViewController {
    
    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    @IBOutlet weak var number3: UITextField!
    
    @IBOutlet weak var result: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { (text1, text2,text3) -> Int in
            return (Int(text1) ?? 0) + (Int(text2) ?? 0) + (Int(text3) ?? 0)
            }.map { $0.description }
            .bind(to: result.rx.text)
    }
}
