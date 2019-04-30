//
//  PlayerViewController.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/15/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dfsEntry: DfsEntry?
    var apiManager: ApiManager?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var positionImage: UIImageView!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var statsTableView: UITableView!
    @IBOutlet weak var chooseButton: UIBarButtonItem!
    
    
    var currencyFormatter: NumberFormatter = NumberFormatter()
    
    override func viewWillAppear(_ animated: Bool) {
        if let apiManager = apiManager, let dfsEntry = dfsEntry {
        
        }
        else {
            print("Could not obtain ApiManager")
        }
        
        setLabelsFromDfsEntry()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statsTableView.dataSource = self
        statsTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "positionTableViewCell", for: indexPath) as! StatsTableViewCell
        
        return cell
    }
    
    func setLabelsFromDfsEntry() {
        if dfsEntry?.position == .D {
            self.title = dfsEntry?.team?.abbreviation
        }
        else {
            self.title = dfsEntry?.player?.getFullName()
        }

        if let position = dfsEntry?.position?.rawValue {
            chooseButton.title = "Choose " + position
        }
        
        gameLabel.text = dfsEntry?.game?.getGameText()
        //positionImage.image = UIImage(named: dfsEntry?.position?.getPositionName() ?? "")
        
        currencyFormatter.numberStyle = .currency
        if let salary = dfsEntry?.salary {
            salaryLabel.text = currencyFormatter.string(from: salary as NSNumber)
        }
    }
}
