//
//  OptionCell.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var optionLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(option: String) {
        optionView.layer.masksToBounds = true
        optionView.layer.cornerRadius = optionView.frame.size.height / 2
        optionLB.text = option
    }

}
