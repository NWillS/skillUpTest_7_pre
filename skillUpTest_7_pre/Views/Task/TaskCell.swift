//
//  TaskCell.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/09.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet weak private var taskTitle: UILabel!
    @IBOutlet weak private var updateDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setTaskTitleText(text: String) {
        taskTitle.text = text
    }
    func setUpdateDateText(date: String) {
        updateDate.text = date
    }

}
