//
//  MyLinupTableViewCell.swift
//  Blitz
//
//  Created by Aaron Henry on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class MyLinupTableViewCell: UITableViewCell {

    @IBOutlet weak var pos: UILabel!
    @IBOutlet weak var playerName: UILabel!
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
