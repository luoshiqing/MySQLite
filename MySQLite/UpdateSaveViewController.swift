//
//  UpdateSaveViewController.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

class UpdateSaveViewController: BaseViewController {

    fileprivate var personInfo: Person!
    fileprivate var indexPath: IndexPath!
    fileprivate var handler: ((IndexPath,Person)->Void)?
    
    
    var textF: TextFieldView?
    var stateLabel: UILabel?
    var insertBtn: UIButton!
    
    let stateText = "当前状态："
    
    
    var name: String!
    var age: String!
    var money: String!
    
    init(personInfo: Person ,indexPath: IndexPath ,handler: ((IndexPath,Person)->Void)?){
        super.init(nibName: nil, bundle: nil)
        
        self.personInfo = personInfo
        self.indexPath = indexPath
        self.handler = handler
        
  
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    var infoArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.navigationItem.title = "改"
        
        infoArray = ["修改前信息：",
                    "name = \(personInfo.name!)",
                    "id = \(personInfo.id)",
                    "age = \(personInfo.age)",
                    "money = \(personInfo.money)"]
        
        
        let toTop: CGFloat = 15 + 64
        
        let specing: CGFloat = 4
        
        let x: CGFloat = 15
        
        let w = self.view.frame.width - x * 2
        
        let h: CGFloat = 18
        
        for index in 0..<infoArray.count {

            let y = toTop + CGFloat(index) * (specing + h)
            
            let label = UILabel(frame: CGRect(x: x, y: y, width: w, height: h))
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = infoArray[index]
            self.view.addSubview(label)
        }
        
        
        
        
        
        let textFY = toTop + CGFloat(infoArray.count) * (specing + h)
        
        
        
        
        let items = ["Name","Age","Money"]
        textF = TextFieldView(items: items, handler: { (handlerModel) in
            
            self.modelToMember(with: handlerModel)
            
        })
        //更新坐标
        textF?.frame.origin.y = textFY
        //更新值
        let valueArray = [personInfo.name!,"\(personInfo.age)","\(personInfo.money)"]
        self.name = personInfo.name!
        self.age = "\(personInfo.age)"
        self.money = "\(personInfo.money)"
        textF?.setTextFieldValue(valueArray)
        
        self.view.addSubview(textF!)
        
        
        let y = textF!.frame.origin.y + textF!.frame.height + 20
        
        insertBtn = UIButton(frame: CGRect(x: (self.view.frame.width - 100) / 2, y: y, width: 100, height: 35))
        insertBtn.setTitle("更新数据", for: UIControlState())
        insertBtn.setTitleColor(UIColor.white, for: UIControlState())
        insertBtn.backgroundColor = UIColor.orange
        
        insertBtn.addTarget(self, action: #selector(self.updateAct(send:)), for: .touchUpInside)
        
        self.view.addSubview(insertBtn)
        
        let sy = insertBtn.frame.origin.y + insertBtn.frame.height + 20
        stateLabel = UILabel(frame: CGRect(x: 15, y: sy, width: self.view.frame.width - 15 * 2, height: 30))
        
        stateLabel?.text = stateText
        
        stateLabel?.textColor = UIColor.red
        
        self.view.addSubview(stateLabel!)
    }

    //点击更新
    func updateAct(send: UIButton){
        
        self.textF?.packUpTheKeyboard()
        
        if self.name!.isEmpty{
            stateLabel?.text = stateText + "name为空"
        }else{
            personInfo.name = self.name!
        }
        
        if self.age!.isEmpty{
            stateLabel?.text = stateText + "age为空"
        }else{
            personInfo.age = self.age!.intValue()
        }
        
        if self.name!.isEmpty{
            stateLabel?.text = stateText + "姓名为空"
        }else{
            personInfo.money = self.money!.doubleValue()
        }
        
        let str = personInfo.updateSQL() ? "更新成功" : "更新失败"
        
        
        stateLabel?.text = stateText + str
    
        
        self.handler?(self.indexPath,self.personInfo)
        
    }
    
    func modelToMember(with model: HandlerModel){
        
        let type = model.type
        
        let value = model.value
        
        switch type {
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
