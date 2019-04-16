//
//  StatsTableViewCell.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/15/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabelsFromStat(stat: Stat) {
        nameLabel.text = stat.getFormattedName()
        valueLabel.text = stat.value
    }
}
