//
//  allPlayersTableViewCell.swift
//  Blitz
//
//  Created by Aaron Henry on 4/11/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class allPlayersTableViewCell: UITableViewCell {
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var matchup: UILabel!
    @IBOutlet weak var pos: UILabel!
    @IBOutlet weak var playerSalary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
