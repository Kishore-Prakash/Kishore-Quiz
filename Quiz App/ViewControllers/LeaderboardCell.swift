//
//  LeaderboardCell.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {

    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var genderIV: UIImageView!
    @IBOutlet weak var scoredOnLB: UILabel!
    @IBOutlet weak var scoreLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(score: Score) {
        nameLB.text = score.name
        if score.gender == "Male" {
            genderIV.image = UIImage(named: "male")
        } else {
            genderIV.image = UIImage(named: "female")
        }
        scoredOnLB.text = score.scoredOn.toString()
        scoreLB.text = String(score.score)
    }

}
