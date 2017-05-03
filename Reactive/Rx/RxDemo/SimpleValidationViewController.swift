//
//  SimpleValidationViewController.swift
//  RxDemo
//
//  Created by 杨晴贺 on 2017/5/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let minimalUsernameLength = 5
let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var userNameTip: UILabel!
    @IBOutlet weak var passwordTip: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var disposeBag = DisposeBag()
        
        userNameTip.text = "用户名必须大于 \(minimalUsernameLength) 字符"
        passwordTip.text = "密码必须大于 \(minimalPasswordLength) 字符"
        
        let usernameValid = userName.rx.text.orEmpty
            .map { $0.characters.count >= minimalUsernameLength }
        .shareReplay(1)
        
        let passwordValid = password.rx.text.orEmpty
            .map { $0.characters.count >= minimalPasswordLength }
            .shareReplay(1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .shareReplay(1)
        
        usernameValid
            .bind(to: password.rx.isEnabled)
        
        usernameValid
            .bind(to: userNameTip.rx.isHidden)
        
        passwordValid
            .bind(to: passwordTip.rx.isHidden)
            
        everythingValid
            .bind(to: loginBtn.rx.isEnabled)
        
        loginBtn.rx.controlEvent(.touchUpInside)
                .subscribe(onNext: { [weak self] in self?.showAlert() })
    }
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
}
