//
//  LookTableViewCell.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

class LookTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    
    var p: Person?{
        didSet{
            nameLabel.text  = "姓名：\(p!.name!)"
            idLabel.text    = "I D：\(p!.id)"
            ageLabel.text   = "年龄：\(p!.age)"
            moneyLabel.text = "资产：\(p!.money)"
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
