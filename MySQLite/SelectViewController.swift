//
//  SelectViewController.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

class SelectViewController: BaseViewController ,UITableViewDelegate ,UITableViewDataSource{

    var textF: TextFieldView?
    var insertBtn: UIButton!
    
    var id: String?
    var name: String?
    var age: String?
    var money: String?
    
    
    
    var dataArray: [Person]!{
        didSet{
            myTabView?.reloadData()
        }
    }
    
    var myTabView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "查"
        
        
        
        let items = ["Name","ID","Age","Money"]
        textF = TextFieldView(items: items, handler: { (handlerModel) in
            
            self.modelToMember(with: handlerModel)
            
        })
        self.view.addSubview(textF!)
        
 
        
        let y = textF!.frame.origin.y + textF!.frame.height + 15
        
        insertBtn = UIButton(frame: CGRect(x: (self.view.frame.width - 100) / 2, y: y, width: 100, height: 35))
        insertBtn.setTitle("查找数据", for: UIControlState())
        insertBtn.setTitleColor(UIColor.white, for: UIControlState())
        insertBtn.backgroundColor = UIColor.orange
        
        insertBtn.addTarget(self, action: #selector(self.selectBtn(send:)), for: .touchUpInside)
        
        self.view.addSubview(insertBtn)
        
        
        let my = insertBtn.frame.origin.y + insertBtn.frame.height + 15
        let rect = CGRect(x: 0, y: my, width: self.view.frame.width, height: self.view.frame.height - my)
        myTabView = UITableView(frame: rect, style: .plain)
        
        myTabView?.tableFooterView = UIView()
        
        myTabView?.delegate = self
        myTabView?.dataSource = self
        
        self.view.addSubview(myTabView!)
    }

    func selectBtn(send: UIButton){
    
        self.textF?.packUpTheKeyboard()
        
        var selectText = ""
        
        
        var textArray = [String]()
        
        if let n = self.name {
            
            if !n.isEmpty {
                let v = "name=\(n)"
                textArray.append(v)
            }
 
        }
        if let i = self.id{
            if !i.isEmpty{
                let v = "id=\(i)"
                textArray.append(v)
            }
        }
        if let a = self.age{
            if !a.isEmpty{
                let v = "age=\(a)"
                textArray.append(v)
            }
        }
        if let m = self.money {
            if !m.isEmpty{
                let v = "money=\(m)"
                textArray.append(v)
            }
        }
    
        for index in 0..<textArray.count {
            
            let text = textArray[index]
            if index == 0{
                selectText = text
            }else{
                
                selectText += " and " + text
    
            }
  
        }
        
        print(selectText)
        
        let p = Person.queryPersons(condition: selectText)
        
        if p.count == 0{
            showErrorText()
        }
        self.dataArray = p
        
    }
    
    
    func modelToMember(with model: HandlerModel){
        
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Tab代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray == nil ? 0 : self.dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ddd = "LookCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ddd) as? LookTableViewCell
        if cell == nil
        {
            cell = Bundle.main.loadNibNamed("LookTableViewCell", owner: self, options: nil )?.last as? LookTableViewCell
            
        }
        cell?.accessoryType = .none
        
        
        if(self.dataArray != nil){
            
            cell?.p = self.dataArray[indexPath.row]
            
            
        }
 
        return cell!
    }
    
    
    //选择
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let p = self.dataArray[indexPath.row]
        
        let name = p.name!
        let id = p.id
        let age = p.age
        let money = p.money
        
        
        print("name:\(name)\nid:\(id)\nage:\(age)\nmoney:\(money)")
        
        
    }


}
