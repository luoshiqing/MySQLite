//
//  LimitSelectViewController.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/10.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

class LimitSelectViewController: BaseViewController ,UITableViewDelegate ,UITableViewDataSource{

    
    
    var textField: UITextField!
    var startBtn: UIButton!
    var beforeBtn: UIButton!
    var nextBtn: UIButton!
    
    var myTabView: UITableView?
    
    //左右边距
    let toLeftW: CGFloat = 15
    
    
    
    var dataArray: [Person]!{
        didSet{
            self.myTabView?.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "分段查"
        
        self.initSomeView()
        
    }

    fileprivate func initSomeView(){
     
        //输入框
        let tw = self.view.frame.width / 2 - toLeftW
        textField = UITextField(frame: CGRect(x: toLeftW, y: toLeftW + 64, width: tw, height: 30))
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入每页数"
        textField.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(textField)
        
        let sw = tw - toLeftW * 2
        let sx = self.view.frame.width - sw - toLeftW
        //开始检索
        startBtn = UIButton(frame: CGRect(x: sx, y: toLeftW + 64, width: sw, height: 30))
        startBtn.setTitle("开始检索", for: UIControlState())
        startBtn.setTitleColor(UIColor.white, for: UIControlState())
        startBtn.setTitleColor(UIColor.blue, for: .highlighted)
        startBtn.backgroundColor = UIColor.red
        startBtn.layer.cornerRadius = 4
        startBtn.layer.masksToBounds = true
        startBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        startBtn.addTarget(self, action: #selector(self.someBtnAct(send:)), for: .touchUpInside)
        startBtn.tag = 0
        self.view.addSubview(startBtn)
        
        let spacing: CGFloat = 10 //间距
        let by =  startBtn.frame.origin.y + startBtn.frame.height + spacing
        //上一页
        beforeBtn = UIButton(frame: CGRect(x: toLeftW, y: by, width: tw, height: 30))
        beforeBtn.setTitle("上一页", for: .normal)
        beforeBtn.setTitleColor(UIColor.orange, for: .normal)
        beforeBtn.setTitleColor(UIColor.blue, for: .highlighted)
        beforeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        beforeBtn.addTarget(self, action: #selector(self.someBtnAct(send:)), for: .touchUpInside)
        beforeBtn.tag = 1
        self.view.addSubview(beforeBtn)
        
        
        let nx = self.view.frame.width - tw - toLeftW
        //下一页
        nextBtn = UIButton(frame: CGRect(x: nx, y: by, width: tw, height: 30))
        nextBtn.setTitle("下一页", for: .normal)
        nextBtn.setTitleColor(UIColor.orange, for: .normal)
        nextBtn.setTitleColor(UIColor.blue, for: .highlighted)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        nextBtn.addTarget(self, action: #selector(self.someBtnAct(send:)), for: .touchUpInside)
        nextBtn.tag = 2
        self.view.addSubview(nextBtn)
        
        
        //tabview
        let ty = nextBtn.frame.origin.y + nextBtn.frame.height + spacing
        let th = self.view.frame.height - ty
        myTabView = UITableView(frame: CGRect(x: 0, y: ty, width: self.view.frame.width, height: th), style: .plain)
        
        myTabView?.delegate = self
        myTabView?.dataSource = self
        myTabView?.tableFooterView = UIView()
        
        self.view.addSubview(myTabView!)
        
        
    }
  
  
    var index = 0
    
    func someBtnAct(send: UIButton){
        
        self.textField.resignFirstResponder()
        
        switch send.tag {
        case 0:
            print("开始检索")
            if let value = self.textField.text {
                if value.isAllNum(){
                    self.index = 0
                    let intV = value.intValue()
                    self.limitDatas(start: self.index * intV, length: intV)
                }else{
                    let alert = UIAlertView(title: nil, message: "必须输入大于0的数字", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                }
            }
        case 1:
            print("上一页")
            if let value = self.textField.text {
                if value.isAllNum(){

                    let ind = self.index - 1
                    if ind < 0 {
                        let alert = UIAlertView(title: "", message: "当前已经是第一页", delegate: nil, cancelButtonTitle: "确定")
                        alert.show()
                    }else{
                        self.index -= 1
                        let intV = value.intValue()
                        self.limitDatas(start: self.index * intV, length: intV)
                    }
                    
                }else{
                    let alert = UIAlertView(title: nil, message: "必须输入大于0的数字", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                }
            }
            
        case 2:
            print("下一页")
            if let value = self.textField.text {
                if value.isAllNum(){
                    self.index += 1
                    let intV = value.intValue()
                    self.limitDatas(start: self.index * intV, length: intV)
                }else{
                    let alert = UIAlertView(title: nil, message: "必须输入大于0的数字", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                }
            }
            
        default:
            break
        }
    }
    
    fileprivate func limitDatas(start: Int, length: Int){
        
        let pdatas = Person.queryLimitPerson(m : start , n: length)
        if pdatas.count == 0{
            self.index -= 1
            showErrorText()
            return
        }
        dataArray = pdatas
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
