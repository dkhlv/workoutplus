//
//  ProgressCell.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-19.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import UIKit

class ProgressCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var workoutTypeLabel: UILabel!
    @IBOutlet weak var workoutCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
