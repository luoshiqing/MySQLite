//
//  RootViewController.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit


struct CellModel {
    var showName: String
    var className: String
}





class RootViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{

 
    
    fileprivate var myTabView: UITableView!
    
    
    fileprivate let dataArray = [CellModel(showName: "增", className: "InsertViewController"),
                                 CellModel(showName: "删", className: "DeleteViewController"),
                                 CellModel(showName: "改", className: "UpDateViewController"),
                                 CellModel(showName: "查", className: "SelectViewController"),
                                 CellModel(showName: "批量存", className: "BatchViewController"),
                                 CellModel(showName: "分段查", className: "LimitSelectViewController"),
                                 CellModel(showName: "数据查看", className: "LookViewController")]
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "ROOT-SQL"
        
        self.view.backgroundColor = UIColor.white
        
        myTabView = UITableView(frame: self.view.bounds, style: .plain)
   
        myTabView.tableFooterView = UIView()
        
        myTabView.delegate = self
        myTabView.dataSource = self
        
        self.view.addSubview(myTabView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: tableViewCellIdentifier)
        }
        
        
        let model = self.dataArray[indexPath.row]
        
        cell?.textLabel?.text = model.showName
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let clsName = self.dataArray[indexPath.row].className
        
        if let ctr = getClassType(clsName){
            self.navigationController?.pushViewController(ctr, animated: true)
        }
        
  
    }


}
