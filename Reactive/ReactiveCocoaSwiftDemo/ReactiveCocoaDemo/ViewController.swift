//
//  ViewController.swift
//  ReactiveCocoaDemo
//
//  Created by 杨晴贺 on 2017/5/2.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

enum MyError: Error {
    case TestError
}

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operators()
        mapDemo()
    }
    
    func empty() {
        let emptySignal = Signal<Int,NoError>.empty ;
        let observer = Observer<Int,NoError>(
            value: { (num) in
                print(num)
        })
        emptySignal.observe(observer)
    }
    
    func operators() {
        let (signal,observer) = Signal<Int,NoError>.pipe()
        let subscriber = Observer<Int, NoError>(value: { print("Subscriber received \($0)") } )
        let uniqueSignal = signal.uniqueValues()
        uniqueSignal.observe(subscriber)
        observer.send(value: 1)
        observer.send(value: 2)
        observer.send(value: 3)
        observer.send(value: 4)
        observer.send(value: 3)
        observer.send(value: 3)
        observer.send(value: 5)
    }
    
    func mapDemo() {
        let (signal,observer) = Signal<Int,NoError>.pipe()
        let subscriber = Observer<Int, NoError>(value: { print("Subscriber received \($0)") } )
        let mapsignal = signal.map { $0 * 2 }
        mapsignal.observe(subscriber)
        observer.send(value: 10)
    }


}

