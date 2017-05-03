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
        
        publishSubjectDemo()
        replaySubjectDemo()
        behaviorSubjectDemo()
        variableDemo()
        startWithDemo()
        mergeDemo()
        zipDemo()
        combineLatestDemo()
        switchLatestDemo()
        mapDemo()
        flatMapDemo()
        scanDemo()
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
    
    // MARK: - PublishSubject
    func publishSubjectDemo() {
        let disposeBag = DisposeBag()
        let subject = PublishSubject<String>()
        
        subject.subscribe { (even) in
            print("subscribe1:\(even)")
        }.disposed(by: disposeBag)
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject.subscribe { (even) in
            print("subscribe2:\(even)")
        }.disposed(by: disposeBag)
        subject.onNext("🅰️")
        subject.onNext("🅱️")
    }
    
    func replaySubjectDemo() {
        let disposeBag = DisposeBag()
        let subject = ReplaySubject<String>.create(bufferSize: 1)
        
        print("-----ReplaySubject-----")
        
        subject.subscribe { (even) in
            print("subscribe1:\(even)")
        }.disposed(by: disposeBag)
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject.subscribe { (even) in
            print("subscribe2:\(even)")
        }.disposed(by: disposeBag)
        subject.onNext("🅰️")
        subject.onNext("🅱️")
    }
    
    func behaviorSubjectDemo() {
        print("-----ReplaySubject-----")
        let disposeBag = DisposeBag()
        let subject = BehaviorSubject(value: "🔴")
        
        subject.subscribe { (even) in
            print("subscribe1:\(even)")
        }.disposed(by: disposeBag)
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject.subscribe { (even) in
            print("subscribe2:\(even)")
        }.disposed(by: disposeBag)
        subject.onNext("🅰️")
        subject.onNext("🅱️")
        
        subject.subscribe { (even) in
            print("subscribe3:\(even)")
        }.disposed(by: disposeBag)
        subject.onNext("🍐")
        subject.onNext("🍊")
    }
    
    func variableDemo() {
        print("-----Variable-----")
        let disposeBag = DisposeBag()
        let variable = Variable("🔴")
        
        variable.asObservable().subscribe { (even) in
            print("subscribe1:\(even)")
        }.disposed(by: disposeBag)
        variable.value = "🐶"
        variable.value = "🐱"
        
        variable.asObservable().subscribe { (even) in
            print("subscribe2:\(even)")
        }.disposed(by: disposeBag)
        variable.value = "🅰️"
        variable.value = "🅱️"
    }
    // MARK: - Combining
    func startWithDemo() {
        print(#function)
        let disposeBag = DisposeBag()
        Observable.of("🐶", "🐱", "🐭", "🐹")
            .startWith("1️⃣")
            .startWith("2️⃣")
            .startWith("3️⃣", "🅰️", "🅱️")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func mergeDemo() {
        print(#function)
        let disposeBag = DisposeBag()
        
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        
        Observable.of(subject1, subject2)
            .merge()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        subject1.onNext("🅰️")
        subject1.onNext("🅱️")
        subject2.onNext("①")
        subject2.onNext("②")
        subject1.onNext("🆎")
        subject2.onNext("③")
    }
    
    func zipDemo() {
        print(#function)
        let disposeBag = DisposeBag()
        
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        
        Observable.zip(stringSubject, intSubject) { stringElement, intElement in
            "\(stringElement) \(intElement)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        stringSubject.onNext("🅰️")
        stringSubject.onNext("🅱️")
        
        intSubject.onNext(1)
        
        intSubject.onNext(2)
        
        stringSubject.onNext("🆎")
        intSubject.onNext(3)
    }
    
    func combineLatestDemo() {
        print(#function)
        let disposeBag = DisposeBag()
        
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        
        Observable.combineLatest(stringSubject, intSubject) { stringElement, intElement in
            "\(stringElement) \(intElement)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        stringSubject.onNext("🅰️")
        
        stringSubject.onNext("🅱️")
        intSubject.onNext(1)
        
        intSubject.onNext(2)
        
        stringSubject.onNext("🆎")
        
        let disposeBag2 = DisposeBag()
        
        let stringObservable = Observable.just("❤️")
        let fruitObservable = Observable.from(["🍎", "🍐", "🍊"])
        let animalObservable = Observable.of("🐶", "🐱", "🐭", "🐹")
        
        Observable.combineLatest([stringObservable, fruitObservable, animalObservable]) {
            "\($0[0]) \($0[1]) \($0[2])"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag2)
    }
    
    func switchLatestDemo() {
        print(#function)
        let disposeBag = DisposeBag()
        
        let subject1 = BehaviorSubject(value: "⚽️")
        let subject2 = BehaviorSubject(value: "🍎")
        
        let variable = Variable(subject1)
        
        variable.asObservable()
            .switchLatest()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("🏈")
        subject1.onNext("🏀")
        
        variable.value = subject2
        
        subject1.onNext("⚾️")
        
        subject2.onNext("🍐")
    }
    
    // MARK: - Transforming
    func mapDemo() {
        print(#function)
        let disposeBag = DisposeBag()
        Observable.of(1, 2, 3)
            .map { $0 * $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func flatMapDemo() {
        print(#function)
        let disposeBag = DisposeBag()
        
        struct Player {
            var score: Variable<Int>
        }
        
        let 👦🏻 = Player(score: Variable(80))
        let 👧🏼 = Player(score: Variable(90))
        
        let player = Variable(👦🏻)
        
        player.asObservable()
            .flatMap { $0.score.asObservable() } // Change flatMap to flatMapLatest and observe change in printed output
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        👦🏻.score.value = 85
        
        player.value = 👧🏼
        
        👦🏻.score.value = 95 // Will be printed when using flatMap, but will not be printed when using flatMapLatest
        
        👧🏼.score.value = 100
    }
    
    func scanDemo() {
        print(#function)
        let disposeBag = DisposeBag()
        
        Observable.of(10, 100, 1000)
            .scan(1) { aggregateValue, newValue in
                aggregateValue + newValue
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
}

