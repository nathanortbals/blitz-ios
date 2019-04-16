//
//  MyLinupTableViewCell.swift
//  Blitz
//
//  Created by Aaron Henry on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class LinupTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    var currencyFormatter: NumberFormatter = NumberFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabelsFromDfsEntry(lineupPosition: Int, dfsEntry: DfsEntry) {
        if dfsEntry.position == .D {
            nameLabel.text = dfsEntry.team?.abbreviation
        }
        else {
            nameLabel.text = dfsEntry.player?.getFullName()
        }
        
        positionLabel.text = Lineup.getPositionNameFromIndex(index: lineupPosition)
        teamLabel.text = dfsEntry.team?.abbreviation
        gameLabel.text = dfsEntry.game?.getGameText()
        
        currencyFormatter.numberStyle = .currency
        if let salary = dfsEntry.salary {
            salaryLabel.text = currencyFormatter.string(from: salary as NSNumber)
        }
    }
}
