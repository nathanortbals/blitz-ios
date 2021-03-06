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
    var lineupPosition: Int?
    var apiManager: ApiManager?
    var stats: Stats?
    
    var parentView: PositionViewController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var statsTableView: UITableView!
    @IBOutlet weak var chooseButton: UIBarButtonItem!
    @IBOutlet weak var gamesPlayedLabel: UILabel!
    
    var currencyFormatter: NumberFormatter = NumberFormatter()
    
    override func viewWillAppear(_ animated: Bool) {
        view.showBlurLoader()
        setLabelsFromDfsEntry()
        if let apiManager = apiManager, let dfsEntry = dfsEntry {
            apiManager.getStats(dfsEntry: dfsEntry){ (result) in
                switch(result) {
                case .success(let stats):
                    self.view.removeBlurLoader()
                    self.stats = stats
                    print(stats)
                    self.statsTableView.reloadData()
                    self.setGamesPlayedLabel()
                case .error(let error):
                    self.view.removeBlurLoader()
                    let alert = UIAlertController(title: "Error", message: "Could not fetch data from server.", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    print(error)
                }
            }
        }
        else {
            print("Could not obtain ApiManager")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statsTableView.dataSource = self
        statsTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let stats = stats, let sections = stats.sections, let statsSubSection = sections[section].stats {
            return statsSubSection.count
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let stats = stats, let sections = stats.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let stats = stats, let sections = stats.sections {
            return sections[section].getFormattedName()
        }
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statsTableViewCell", for: indexPath) as! StatsTableViewCell
        
        let stat = stats?.sections?[indexPath.section].stats?[indexPath.row]
        if let stat = stat {
            cell.setLabelsFromStat(stat: stat)
        }
        
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
        
        currencyFormatter.numberStyle = .currency
        if let salary = dfsEntry?.salary {
            salaryLabel.text = currencyFormatter.string(from: salary as NSNumber)
        }
    }
    
    func setGamesPlayedLabel() {
        if let gamesPlayed = stats?.gamesPlayed {
            gamesPlayedLabel.text = String(gamesPlayed) + " Games Played This Season"
        }
        else {
            gamesPlayedLabel.text = nil
        }
    }
    
    @IBAction func selectPlayer(sender: UIBarButtonItem!) {
        var playerId: String?
        if dfsEntry?.position == .D {
            if let id = dfsEntry?.team?.id {
                playerId = String(id)
            }
        }
        else {
            if let id = dfsEntry?.player?.id {
                playerId = String(id)
            }
        }
        
        do {
            try apiManager?.setLineupPosition(lineupPosition: lineupPosition, playerId: playerId)
            self.navigationController?.popViewController(animated: true)
            parentView?.navigationController?.popViewController(animated: true)
        }
        catch {
            print("Could not save selection")
        }
    }
}
