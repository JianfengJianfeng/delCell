//
//  TableViewCell.swift
//  delCell
//
//  Created by 徐建峰 on 2018/6/23.
//  Copyright © 2018年 Jianfeng Xu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override var canBecomeFirstResponder: Bool {
        
        return true
    }
}
