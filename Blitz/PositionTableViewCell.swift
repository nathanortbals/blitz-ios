//
//  allPlayersTableViewCell.swift
//  Blitz
//
//  Created by Aaron Henry on 4/11/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class PositionTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var positionImage: UIImageView!
    
    var currencyFormatter: NumberFormatter = NumberFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLabelsFromDfsEntry(dfsEntry: DfsEntry) {
        if dfsEntry.position == .D {
            nameLabel.text = dfsEntry.team?.abbreviation
        }
        else {
            nameLabel.text = dfsEntry.player?.getFullName()
        }
        
        teamLabel.text = dfsEntry.team?.abbreviation
        gameLabel.text = dfsEntry.game?.getGameText()
        positionImage.image = UIImage(named: dfsEntry.position?.getPositionName() ?? "")
        
        currencyFormatter.numberStyle = .currency
        if let salary = dfsEntry.salary {
            salaryLabel.text = currencyFormatter.string(from: salary as NSNumber)
        }
    }
    
}
