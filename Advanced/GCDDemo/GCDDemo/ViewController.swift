//
//  ViewController.swift
//  GCDDemo
//
//  Created by 杨晴贺 on 2017/6/11.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        useWorkItem()
    }
    
    func simpleQueues() {
        let queue = DispatchQueue(label: "com.silence.myqueue")
        
        queue.async {
            for i in 0..<10 {
                print("🔴", i)
            }
        }
        
        for i in 100 ..< 110 {
            print("Ⓜ️", i)
        }
    }
    
    func queuesWithQoS() {
        let queue1 = DispatchQueue(label: "com.silence.queue1", qos: DispatchQoS.userInitiated)
        // let queue1 = DispatchQueue(label: "com.appcoda.queue1", qos: DispatchQoS.background)
        // let queue2 = DispatchQueue(label: "com.appcoda.queue2", qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "com.silence.queue2", qos: DispatchQoS.utility)
        
        queue1.async {
            for i in 0..<10 {
                print("🔴", i)
            }
        }
        
        queue2.async {
            for i in 100..<110 {
                print("🔵", i)
            }
        }
        
        for i in 1000..<1010 {
            print("Ⓜ️", i)
        }
    }
    
    var inactiveQueue: DispatchQueue!
    func concurrentQueues() {
        // let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility)
        // let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility, attributes: .concurrent)
        // let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility, attributes: .initiallyInactive)
        let anotherQueue = DispatchQueue(label: "com.silence.anotherQueue", qos: .userInitiated, attributes: [.concurrent, .initiallyInactive])
        inactiveQueue = anotherQueue
        
        anotherQueue.async {
            for i in 0..<10 {
                print("🔴", i)
            }
        }
        
        
        anotherQueue.async {
            for i in 100..<110 {
                print("🔵", i)
            }
        }
        
        
        anotherQueue.async {
            for i in 1000..<1010 {
                print("⚫️", i)
            }
        }
    }
    
    
    func queueWithDelay() {
        let delayQueue = DispatchQueue(label: "com.silence.delayqueue", qos: .userInitiated)
        
        print(Date())
        let additionalTime: DispatchTimeInterval = .seconds(2)
        
        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            print(Date())
        }
    }
    
    
    func fetchImage() {
        let imageURL: URL = URL(string: "http://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png")!
        
        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
            
            if let data = imageData {
                print("Did download image data")
                
                DispatchQueue.main.async {
                    print(data)
                    // self.imageView.image = UIImage(data: data)
                }
            }
        }).resume()
    }
    
    
    func useWorkItem() {
        var value = 10
        
        let workItem = DispatchWorkItem {
            value += 5
        }
        
        workItem.perform()
        
        let queue = DispatchQueue.global(qos: .utility)
        /*
         queue.async {
         workItem.perform()
         }
         */
        
        queue.async(execute: workItem)
        
        
        workItem.notify(queue: DispatchQueue.main) {
            print("value = ", value)
        }
    }


}

