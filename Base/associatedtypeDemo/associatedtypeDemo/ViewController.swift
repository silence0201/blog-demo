//
//  ViewController.swift
//  associatedtypeDemo
//
//  Created by 杨晴贺 on 2017/4/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arr = [1,2,3,55,44]
        
        // 对 Sequence 可以使用 for...in 来循环访问
        for (index,value) in ReverseSequence(array: arr).enumerated() {
            print("Index \(index) is \(value)")
        }
    }

}

class ReverseIterator<T>: IteratorProtocol {
    typealias Element = T
    
    var array: [Element]
    var currentIndex = 0
    
    init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    
    func next() -> Element? {
        if currentIndex < 0 {
            return nil
        }else {
            let element = array[currentIndex];
            currentIndex -= 1
            return element
        }
    }
}

struct ReverseSequence<T>: Sequence {
    typealias Iterator = ReverseIterator<T>
    var array: [T]
    
    init(array: [T]) {
        self.array = array
    }
    
    func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: self.array)
    }
    
    
}

