//
//  StudentDataTableViewCell.swift
//  CloudData
//
//  Created by mike on 2018/3/26.
//  Copyright © 2018年 mike. All rights reserved.
//

import UIKit

//要記得在 identity inspector 中設定 custom class
class StudentDataTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
