//
//  BatchViewController.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

class BatchViewController: BaseViewController {

    //插入数量
    let insertCount = 10000
    //是否开启快速,true为开启
    let isSwift = true
    
    
    var batchBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "批量存储"
        
        batchBtn = UIButton(frame: CGRect(x: (self.view.frame.width - 80) / 2, y: (self.view.frame.height - 35) / 2, width: 80, height: 35))
        
        batchBtn.setTitle("批量插入", for: UIControlState())
        
        batchBtn.backgroundColor = UIColor.red
        
        batchBtn.setTitleColor(UIColor.white, for: UIControlState())
        
        batchBtn.layer.cornerRadius = 4
        batchBtn.layer.masksToBounds = true

        batchBtn.addTarget(self, action: #selector(self.batchAct(send:)), for: .touchUpInside)
        
        self.view.addSubview(batchBtn)
        
        
    }
    
    var isSerting = false
    
    func batchAct(send: UIButton){
        
        
        if !isSerting { //开始插入
            
            self.isSerting = true
            self.batchBtn.setTitle("正在插入", for: UIControlState())
            self.batchBtn.isEnabled = false
            
        }
        
        
        if isSwift{
            SQLManager.shareInstance().execQueueSQL(action: { (manager: SQLManager) in
                //开启预编译
                manager.beginTransaction()
                
                self.insertDatas(self.isSwift)
                //提交事物
                manager.commitTransaction()
            })
        }else{
            //直接存
            self.insertDatas(self.isSwift)
        }
    }
    
    //插入数据
    fileprivate func insertDatas(_ prepare : Bool) {
        //得到开始时间
        let start = CFAbsoluteTimeGetCurrent()
        print("开始时间：\(start)")
        
        print(#function,"\(prepare ? "预编译" : "未开启预编译" )")
        
        //开始插入
        
        for index in 0..<insertCount {
            let name = "rand\(index)"
            let age = Int(arc4random() % 100 + 1)
            let money = Double(arc4random() % 10000) + Double(arc4random() % 100) * 0.01
            let id = index
            if prepare {
                //预编译
                let sql = "INSERT INTO T_Person (name,age,money,id) VALUES(?,?,?,?);"
                SQLManager.shareInstance().batchExecsql(sql, args: name,age,money,id)
            }
            else{
                //直接插入
                let sql = "INSERT INTO T_Person (name,age,money,id) VALUES('\(name)',\(age),\(money),\(id));"
                SQLManager.shareInstance().execSQL(sql: sql)
            }
            
        }
        
        
        //得到结束时间
        let end = CFAbsoluteTimeGetCurrent()
        print("结束时间：\(end)")
        
        //得出耗时
        print("耗时：\(end - start)")
        
        self.isSerting = true
        self.batchBtn.setTitle("插入数据", for: UIControlState())
        self.batchBtn.isEnabled = true
    }
    
 
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
