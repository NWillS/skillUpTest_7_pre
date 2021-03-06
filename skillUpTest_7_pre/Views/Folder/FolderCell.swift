//
//  FolderCell.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/05.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import UIKit

class FolderCell: UITableViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setNameLabelText(text: String) {
        nameLabel.text = text
    }
    func setCountLabelText(count: Int) {
        nameLabel.text = "\(count)"
    }
}
