//
//  ViewController.swift
//  GifEncode
//
//  Created by 杨晴贺 on 2017/5/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit
import ImageIO
import MobileCoreServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Part1:读取67张png图片
        let images:NSMutableArray = NSMutableArray()
        for i in 0...66 {// 遍历本地67张图片
            let imagePath = "\(i).png" // 构建图片名称
            let image:UIImage = UIImage(named: imagePath)!//构建UIImage
            images.add(image)// 将图片添加到数组中
        }
        // Part2:在Document目录创建gif文件
        var docs=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = docs[0] as String
        let gifPath = documentsDirectory+"/plane.gif"// 构建Doc目录下gif文件路径
        print("\(gifPath)")
        let url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, gifPath as CFString!, CFURLPathStyle.cfurlposixPathStyle, false)// string->CFURL
        let destion = CGImageDestinationCreateWithURL(url!, kUTTypeGIF, images.count, nil)
        
        // Part3:设置gif图片属性，利用67张png图片构建gif
        let cgimagePropertiesDic = [kCGImagePropertyGIFDelayTime as String:0.1]//设置每帧之间播放时间
        let cgimagePropertiesDestDic = [kCGImagePropertyGIFDictionary as String:cgimagePropertiesDic];
        for cgimage in images{
            CGImageDestinationAddImage(destion!, (cgimage as AnyObject).cgImage!!,cgimagePropertiesDestDic as CFDictionary?);
        }// 依次为gif图像对象添加每一帧元素
        
        let gifPropertiesDic:NSMutableDictionary = NSMutableDictionary()
        gifPropertiesDic.setValue(kCGImagePropertyColorModelRGB, forKey: kCGImagePropertyColorModel as String)// 设置图像的彩色空间格式
        gifPropertiesDic.setValue(16, forKey: kCGImagePropertyDepth as String)// 设置图像的颜色深度
        gifPropertiesDic.setValue(1, forKey: kCGImagePropertyGIFLoopCount as String)// 设置Gif执行次数
        let gifDictionaryDestDic = [kCGImagePropertyGIFDictionary as String:gifPropertiesDic]
        CGImageDestinationSetProperties(destion!,gifDictionaryDestDic as CFDictionary?);//为gif图像设置属性
        CGImageDestinationFinalize(destion!);
    }


}

