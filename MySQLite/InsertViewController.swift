//
//  InsertViewController.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

class InsertViewController: BaseViewController {

    
    fileprivate var textF: TextFieldView?
    fileprivate var stateLabel: UILabel?
    fileprivate var insertBtn: UIButton!
    
    
    
    fileprivate var id: String!
    fileprivate var name: String!
    fileprivate var age: String!
    fileprivate var money: String!
    
    fileprivate let stateText = "当前状态："
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "插入"
        
        let items = ["Name","ID","Age","Money"]
        textF = TextFieldView(items: items, handler: { (handlerModel) in

            self.modelToMember(with: handlerModel)
            
        })
        self.view.addSubview(textF!)
        
        
        let y = textF!.frame.origin.y + textF!.frame.height + 20
        
        insertBtn = UIButton(frame: CGRect(x: (self.view.frame.width - 100) / 2, y: y, width: 100, height: 35))
        insertBtn.setTitle("插入数据", for: UIControlState())
        insertBtn.setTitleColor(UIColor.white, for: UIControlState())
        insertBtn.backgroundColor = UIColor.orange
        
        insertBtn.addTarget(self, action: #selector(self.insertAct(send:)), for: .touchUpInside)
        
        self.view.addSubview(insertBtn)
    
        let sy = insertBtn.frame.origin.y + insertBtn.frame.height + 20
        stateLabel = UILabel(frame: CGRect(x: 15, y: sy, width: self.view.frame.width - 15 * 2, height: 30))
        
        stateLabel?.text = stateText
        
        stateLabel?.textColor = UIColor.red
        
        self.view.addSubview(stateLabel!)
        
    }
    
    fileprivate func modelToMember(with model: HandlerModel){
        
        let type = model.type
        
        let value = model.value
        
        switch type {
        case "ID":
            self.id = value
        case "Name":
            self.name = value
        case "Age":
            self.age = value
        case "Money":
            self.money = value
        default:
            break
        }
 
    }
    
    
    
    
    func insertAct(send: UIButton){
        
        self.textF?.packUpTheKeyboard()
        
        var dict = [String : Any]()
        
        //name
        if self.name == nil {
            self.stateLabel?.text = self.stateText + "name不能为空"
            return
        }

        dict["name"] = self.name!
        
        //id
        if self.id == nil || self.id.isEmpty{
            self.stateLabel?.text = self.stateText + "id不能为空"
            return
        }else{
            if self.id.isAllNum() {
                dict["id"] = Int(self.id!)!
            }else{
                self.stateLabel?.text = self.stateText + "id必须为数字"
                return
            }
        }
        
        
        //age
        if self.age == nil || self.age.isEmpty{
            self.stateLabel?.text = self.stateText + "age不能为空"
            return
        }else{
            if self.age.isAllNum() {
                dict["age"] = Int(self.age!)!
            }else{
                self.stateLabel?.text = self.stateText + "age必须为数字"
                return
            }
        }
   
        //money
        if self.money == nil || self.money.isEmpty{
            self.stateLabel?.text = self.stateText + "money不能为空"
            return
        }else{
            if self.money.isFloatValue(){
                
                let mm = Double(self.money!)!
                
                if mm > 0 {
                    dict["money"] = mm
                }else{
                    self.stateLabel?.text = self.stateText + "money必须大于0"
                    return
                }
            }else{
                self.stateLabel?.text = self.stateText + "money必须为数字"
                return
            }
        }
        
        
        
        print(dict)
        
        let p = Person(dict: dict)
        p.insertSQL { (isSuccess) in
            
            if isSuccess{
                stateLabel?.text = stateText + "插入成功"
            }else{
                stateLabel?.text = stateText + "插入失败"
            }
        }
        
    }
    
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
