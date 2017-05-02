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

class Person: NSObject {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var person: Person = Person(name: "Test")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        operators()
//        mapDemo()
//        filterDemo()
//        takeDemo()
//        signalProducerDemo()
//        replayLazilyDemo()
//        logEvents()
//
//        let (signal,observer) = Signal<String,NoError>.pipe()
//        let uniqueSignal = signal.uniqueValues()
//        observer.send(value: "12")
//        observer.send(value: "14")
//        
//        label.reactive.text <~ uniqueSignal
//        observer.send(value: "414")
        
        createSignalMehods()
        textFieldDemo()
        
    }
    // MARK: - 信号创建
    func createSignalMehods() {
        // 通过信号发生器创建--冷信号
        let producter = SignalProducer<String,NoError>.init { (observe, _) in
            print("新的订阅，启动操作")
            observe.send(value: "Hello")
            observe.send(value: "World")
        }
        
        let subscriber1 = Observer<String,NoError> { (event) in
            switch event {
            case .value(let value):
                    print("观察者1收到了信号\(value)")
            default:break
            }
        }
        
        let subscriber2 = Observer<String,NoError>(value: { print("观察者二收到消息为\($0)")})
        
        
        print("-----1-----")
        producter.start(subscriber1)
        // 发生器会再次工作
        print("-----2-----")
        producter.start(subscriber2)
        
        // 通过管道创建--热信号
        let (signalA,observerA) = Signal<String,NoError>.pipe()
        let (signalB,observerB) = Signal<String,NoError>.pipe()
        
        observerA.send(value: "A订阅之前")
        observerB.send(value: "B订阅之前")
        
        Signal.combineLatest(signalA, signalB).observeValues { (value1,value2) in
            print("收到的值\(value1)-\(value2)")
        }
        
        observerA.send(value: "A订阅之后")
        observerB.send(value: "B订阅之后")
        
        observerA.send(value: "A改变了")
        
        observerA.sendCompleted()
        observerB.sendCompleted()
    }
    
    // MARK: - 文本输入框监听
    func textFieldDemo() {
        // 输入时监听
        textField.reactive.continuousTextValues.observeValues { (text) in
            print(text ?? "")
            self.label.text = text ?? "Default"
            self.label.sizeToFit()
        }
    }
    
    // MARK: - 基本操作
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
    
    func replayLazilyDemo() {
        let baseProducter = SignalProducer<Int,NoError>([1,2,3,4,6,4]).replayLazily(upTo: 2) ;
        
        print("-----1-----")
        baseProducter.startWithValues { (value) in
            print(value)
        }
        
        print("-----2-----")
        baseProducter.startWithValues { (value) in
            print(value)
        }
        
        print("-----3 -----")
        baseProducter.startWithValues { (value) in
            print(value)
        }
    }
    
    func logEvents() {
        let baseProducter = SignalProducer<Int,NoError>([1,2,3,4,6,4])
        baseProducter.logEvents().startWithValues { (vale) in
            print(vale)
        }
    }

}

