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
        filterDemo()
        takeDemo()
        signalProducerDemo()
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
    
    func filterDemo() {
        let (signal,observer) = Signal<Int,NoError>.pipe()
        let subscriber = Observer<Int, NoError>(value: { print("Subscriber received \($0)") } )
        let filterSignal = signal.filter{$0 > 12 ? true : false}
        filterSignal.observe(subscriber)
        
        observer.send(value: 10)
        observer.send(value: 11)
        observer.send(value: 12)
        observer.send(value: 13)
        observer.send(value: 14)
    }
    
    func takeDemo() {
        let (signal,observer) = Signal<Int,NoError>.pipe()
        let subscriber = Observer<Int, NoError>(value: { print("Subscriber received \($0)") } )
        let takeSignal = signal.take(first: 2)
        takeSignal.observe(subscriber)
        
        observer.send(value: 10)
        observer.send(value: 11)
        observer.send(value: 12)
        observer.send(value: 13)
        observer.send(value: 14)
    }
    
    func collectDemo() {
        let (signal, observer) = Signal<Int,NoError>.pipe()

        let subscriber = Observer<[Int], NoError>(value: { print("Subscriber received \($0)") } )
        let collectSignal = signal.collect()
        collectSignal.observe(subscriber)
        observer.send(value: 1)
        observer.send(value: 2)
        observer.send(value: 3)
        observer.send(value: 4)
        observer.sendCompleted()
    }

    func signalProducerDemo() {
        let product = SignalProducer<Int,NoError> { (observer, _) in
            print("New subscription, starting operation")
            observer.send(value: 1)
            observer.send(value: 2)
        }
        
        let subscriber1 = Observer<Int, NoError>(value: { print("Subscriber1 received \($0)") } )
        let subscriber2 = Observer<Int, NoError>(value: { print("Subscriber2 received \($0)") } )
        print("--subscriber1--")
        product.start(subscriber1)
        print("--subscriber2--")
        product.start(subscriber2)
        
        SignalProducer<Int,NoError> { (observer, _) in
            observer.send(value: 1)
            observer.send(value: 2)
            observer.send(value: 3)
            observer.send(value: 4)
            observer.sendCompleted()
        }
        .collect()
        .startWithResult { (result) in
            var v:[Int] = [Int]()
            do {
                v = try result.dematerialize()
            }catch(let error) {
                print(error)
            }
            
            print(v)
        }
        
    }

}

