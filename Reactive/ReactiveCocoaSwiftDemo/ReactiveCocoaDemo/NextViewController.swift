//
//  NextViewController.swift
//  ReactiveCocoaDemo
//
//  Created by 杨晴贺 on 2017/5/2.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result


class NextViewController: UIViewController {

    let signalTuple = Signal<String?,NoError>.pipe()
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickAction(_ sender: Any) {
        signalTuple.input.send(value: textField.text)
    }

}
