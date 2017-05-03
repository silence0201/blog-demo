//
//  ViewController.swift
//  RxCocoaDemo
//
//  Created by 杨晴贺 on 2017/5/2.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        justDemo()
        ofDemo()
        fromDemo()
        repeatElementDemo()
    }
    
    // MARK: - Create
    func neverDemo() {
        let disposeBag = DisposeBag()
        let neverSequence = Observable<String>.never()
        
        let neverSequenceSubscription = neverSequence
            .subscribe { _ in
                print("This will never be printed")
        }
        
        neverSequenceSubscription.disposed(by: disposeBag)
    }
    
    func emptyDemo() {
        let disposeBag = DisposeBag()
        
        Observable<Int>.empty()
            .subscribe { event in
                print(event)
            }
            .disposed(by: disposeBag)
    }
    
    func justDemo() {
        let disposeBag = DisposeBag()
        
        Observable.just("🔴")
            .subscribe { event in
                print(event)
            }
            .disposed(by: disposeBag)
    }
    
    func ofDemo() {
        let disposeBag = DisposeBag()
        
        Observable.of("🐶", "🐱", "🐭", "🐹")
            .subscribe(onNext: { element in
                print(element)
            })
            .disposed(by: disposeBag)
    }
    
    func fromDemo() {
        let disposeBag = DisposeBag()
        
        Observable.from(["🐶", "🐱", "🐭", "🐹"])
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func createDemo() {
        let disposeBag = DisposeBag()
        
        let myJust = { (element: String) -> Observable<String> in
            return Observable.create { observer in
                observer.on(.next(element))
                observer.on(.completed)
                return Disposables.create()
            }
        }
        
        myJust("🔴")
            .subscribe { print($0) }
            .disposed(by: disposeBag)
    }
    
    func rangeDemo() {
        let disposeBag = DisposeBag()
        
        Observable.range(start: 1, count: 10)
            .subscribe { print($0) }
            .disposed(by: disposeBag)
    }
    
    func repeatElementDemo() {
        let disposeBag = DisposeBag()
        
        Observable.repeatElement("🔴")
            .take(3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func generateDemno() {
        let disposeBag = DisposeBag()
        
        Observable.generate(
            initialState: 0,
            condition: { $0 < 3 },
            iterate: { $0 + 1 }
            )
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func deferredDemo() {
        let disposeBag = DisposeBag()
        var count = 1
        
        let deferredSequence = Observable<String>.deferred {
            print("Creating \(count)")
            count += 1
            
            return Observable.create { observer in
                print("Emitting...")
                observer.onNext("🐶")
                observer.onNext("🐱")
                observer.onNext("🐵")
                return Disposables.create()
            }
        }
        
        deferredSequence
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        deferredSequence
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func doOnDemo() {
        let disposeBag = DisposeBag()
        
        Observable.of("🍎", "🍐", "🍊", "🍋")
            .do(onNext: { print("Intercepted:", $0) }, onError: { print("Intercepted error:", $0) }, onCompleted: { print("Completed")  })
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
}

