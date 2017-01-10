//
//  TextFieldView.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit


struct HandlerModel {
    var type: String
    var value: String
}



class TextFieldView: UIView ,UITextFieldDelegate{
    
    
    
    typealias Handler = (HandlerModel)->Void
    

    fileprivate var items = [String]()
    
    fileprivate var textArray = [UITextField]()
    
    fileprivate var handler: Handler?
    
    init(items: [String], handler: ((HandlerModel)->Void)?) {
        
        
        super.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        self.handler = handler
        
        
        
        self.items = items
        
        self.creatTextFields(items: items)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    fileprivate func creatTextFields(items: [String]){
        
        //起始y
        let startY: CGFloat = 20
        //间距
        let spacing: CGFloat = 15
        //x
        let startX: CGFloat = 15
        //每个的宽度
        let width: CGFloat = UIScreen.main.bounds.width - startX * 2
        //每个的高度
        let height: CGFloat = 30
        
        if items.isEmpty {
            return
        }else{
            //计算整体高度
            let allHeight: CGFloat = startY + CGFloat(items.count) * (spacing + height)
            //设置高度
            self.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: allHeight)
            
        }
        
        
        for index in 0..<items.count {
            
            let name = items[index]
            
            
            let y = startY + CGFloat(index) * (height + spacing)
            
            let textField = UITextField(frame: CGRect(x: startX, y: y, width: width, height: height))
            
            textField.borderStyle = .roundedRect
            textField.textAlignment = .left
            
            textField.placeholder = name
            
            textField.delegate = self
            
            textField.tag = index
            
            textArray.append(textField)
            
            self.addSubview(textField)
        }
   
        
    }
    
    
    
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        let tag = textField.tag
        
        let type = self.items[tag]
        let value = textField.text!
        let handlerModel = HandlerModel(type: type, value: value)
        
        self.handler?(handlerModel)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    //点击空白，收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for textf in self.textArray {
            textf.resignFirstResponder()
        }
    }
    
    //MARK:外部接口
    
    //外部收起键盘
    public func packUpTheKeyboard(){
        
        for textf in self.textArray {
            textf.resignFirstResponder()
        }
        
        
    }
    //设置值
    public func setTextFieldValue(_ valueArray: [String]){
        
        if valueArray.count == self.textArray.count {
            
            for index in 0..<self.textArray.count {
                
                let textf = self.textArray[index]
                let value = valueArray[index]
                
                textf.text = value
            }
        }else{
            print("传入的值数组跟TextField个数不一致")
        }
        
    }
    
    
}
