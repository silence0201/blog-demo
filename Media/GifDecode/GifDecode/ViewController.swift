//
//  ViewController.swift
//  GifDecode
//
//  Created by 杨晴贺 on 2017/5/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit
import ImageIO

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let gifPath = Bundle.main.path(forResource: "plane", ofType: "gif")
        let gifData = try! Data(contentsOf: URL(fileURLWithPath: gifPath!))
        let gifDataSource = CGImageSourceCreateWithData(gifData as CFData, nil)!
        let gifImageCount = CGImageSourceGetCount(gifDataSource)
        for i in 0...gifImageCount-1 {
            let imageref: CGImage? = CGImageSourceCreateImageAtIndex(gifDataSource, i, nil)
            let image: UIImage = UIImage(cgImage: imageref!, scale:UIScreen.main.scale, orientation:UIImageOrientation.up )
            let imageData:Data = UIImagePNGRepresentation(image)!
            var docs=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = docs[0] as String
            let imagePath = documentsDirectory+"/\(i)"+".png"
            try? imageData .write(to: URL(fileURLWithPath: imagePath), options: [.atomic])
            print("\(imagePath)")
        }
        
    }


}

