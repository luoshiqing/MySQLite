//
//  MyFunc.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit


//类名 字符串转类
public func getClassType(_ name: String) -> UIViewController? {
    
    guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
        print("命名空间不存在")
        return nil
    }
    let cls: AnyClass? = NSClassFromString((clsName as! String) + "." + name)
    guard let clsType = cls as? UIViewController.Type else {
        print("无法转换成UIViewController")
        return nil
    }
    let viewCtr = clsType.init()
    return viewCtr
}


/**
 自定义返回按钮
 - parameter target:  响应者
 - parameter selector:  响应方法
 - parameter controlEvents:  触摸手势
 - returns:  返回一个数组->[UIBarButtonItem]
 */
public func creatBackBtn(target: Any?,selector: Selector,for controlEvents: UIControlEvents) -> [UIBarButtonItem]{
    
    let leftBtn = UIButton(frame: CGRect(x: 0,y: 0,width: 13,height: 26))
    leftBtn.setImage(UIImage(named: "tmBack"), for: UIControlState())
    leftBtn.addTarget(target, action: selector, for: controlEvents)
    let backItem = UIBarButtonItem(customView: leftBtn)
    let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
    spacer.width = -5
    
    let items = [spacer,backItem]
    return items
}


/**
 自定义右边按钮
 - parameter title:  标题
 - parameter target:  响应者
 - parameter selector:  响应方法
 - parameter controlEvents:  触摸手势
 - returns:  返回一个数组->[UIBarButtonItem]
 */
public func creatRightHelpBtn(title: String,target: Any? ,selector: Selector ,for controlEvents: UIControlEvents) ->[UIBarButtonItem]{
    
    let rightBtn = UIButton(frame: CGRect(x: 0,y: 0,width: 40,height: 20))
    rightBtn.setTitle(title, for: UIControlState())
    rightBtn.setTitleColor(UIColor.white, for: UIControlState())
    rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    rightBtn.addTarget(target, action: selector, for: controlEvents)
    let rightItem = UIBarButtonItem(customView: rightBtn)
    let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
    spacer.width = 5
    
    let items = [spacer,rightItem]
    return items
}










