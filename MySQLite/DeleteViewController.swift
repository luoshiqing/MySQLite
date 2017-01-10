//
//  DeleteViewController.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

class DeleteViewController: BaseViewController {

    var textF: TextFieldView?
    var stateLabel: UILabel?
    var deleteBtn: UIButton!
    
    
    let stateText = "当前状态："
    
    var id: String = ""
    var name: String = ""
    var age: String = "'"
    var money: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "删除"
        
        
        let items = ["Name","ID","Age","Money"]
        textF = TextFieldView(items: items, handler: { (handlerModel) in
            
            self.modelToMember(with: handlerModel)
            
        })
        self.view.addSubview(textF!)
        
        
        let y = textF!.frame.origin.y + textF!.frame.height + 20
        
        deleteBtn = UIButton(frame: CGRect(x: (self.view.frame.width - 100) / 2, y: y, width: 100, height: 35))
        deleteBtn.setTitle("删除数据", for: UIControlState())
        deleteBtn.setTitleColor(UIColor.white, for: UIControlState())
        deleteBtn.backgroundColor = UIColor.orange
        
        deleteBtn.addTarget(self, action: #selector(self.deleteBtn(send:)), for: .touchUpInside)
        
        self.view.addSubview(deleteBtn)
        
        let sy = deleteBtn.frame.origin.y + deleteBtn.frame.height + 20
        stateLabel = UILabel(frame: CGRect(x: 15, y: sy, width: self.view.frame.width - 15 * 2, height: 30))
        
        stateLabel?.text = stateText
        
        stateLabel?.textColor = UIColor.red
        
        self.view.addSubview(stateLabel!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func deleteBtn(send: UIButton){
    
        self.textF?.packUpTheKeyboard()
        
        //什么都不填，默认删除所有数据库
        var dict = [Person_Property:Any?]()
        
        dict[.id] = self.id
        dict[.name] = self.name
        dict[.age] = self.age
        dict[.money] = self.money
        

        let p = Person(myDict: dict)
        

        p.deleteSQL { (isSuccess) in
            if isSuccess{
                stateLabel?.text = stateText + "删除成功"
            }else{
                stateLabel?.text = stateText + "删除失败"
            }
        }
        
    
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
