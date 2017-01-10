//
//  LookViewController.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

class LookViewController: BaseViewController ,UITableViewDelegate ,UITableViewDataSource{

    var dataArray: [Person]!{
        didSet{
            self.myTabView?.reloadData()
        }
    }
    
    
    
    
    var myTabView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "数据列表"
        
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        myTabView = UITableView(frame: rect, style: .plain)
        
        myTabView?.tableFooterView = UIView()
        
        myTabView?.delegate = self
        myTabView?.dataSource = self
        
        self.view.addSubview(myTabView!)
        
        
        let items = creatRightHelpBtn(title: "倒序", target: self, selector: #selector(self.reverseDataArray(send:)), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItems = items
        
        
    }
    
    
    func reverseDataArray(send: UIButton){
        
        if self.dataArray != nil {
            self.dataArray = self.dataArray!.reversed()
        }
        
        
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dataArray = Person.loadPersons()

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

    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
