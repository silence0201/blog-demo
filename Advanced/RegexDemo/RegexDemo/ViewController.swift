//
//  ViewController.swift
//  RegexDemo
//
//  Created by 杨晴贺 on 2017/4/5.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        isEmail(email: "guang@gmail.com")
        regularExpressionDemo(email: "guang@gmail.com")
    }
    
    
    private func isEmail(email: String) {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if predicate.evaluate(with: email) {
            print("格式正确")
        }else {
            print("格式错误")
        }
    }
    
    private func regularExpressionDemo(email: String) {
        let emailRegex = "([A-Za-z0-9._%+-]+)@([A-Za-z0-9.-]+\\.[A-Za-z]{2,4})"
        let regex = try? NSRegularExpression(pattern: emailRegex, options: .caseInsensitive)
        guard let rgx = regex else {
            print("正则表达式有误")
            return
        }
        let range = NSRange(location: 0, length: email.characters.count)
        let result = rgx.firstMatch(in: email, options: .withoutAnchoringBounds, range: range)
        guard let rul = result else {
            print("不匹配")
            return
        }
        print("匹配")
        
        let range0 = rul.rangeAt(0)
        let range1 = rul.rangeAt(1)
        let range2 = rul.rangeAt(2)
        
        let nStr = email as NSString
        
        print("$0:\(nStr.substring(with: range0))")
        print("$1:\(nStr.substring(with: range1))")
        print("$2:\(nStr.substring(with: range2))")
        
        let newStr = rgx.stringByReplacingMatches(in: email, options: .withoutAnchoringBounds, range: range, withTemplate: "Name:$1 Web:$2")
        print(newStr)
        
    }



}

