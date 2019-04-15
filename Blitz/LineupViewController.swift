//
//  MyLineupViewController.swift
//  Blitz
//
//  Created by Aaron Henry on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class LineupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var apiManager: ApiManager?
    var lineup: Lineup?
    
<<<<<<< HEAD:Blitz/LineupViewController.swift
    @IBOutlet weak var lineupTableView: UITableView!
=======
    @IBOutlet weak var myLineupTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lineup != nil{
            return Lineup.lineupCount
        }
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! MyLinupTableViewCell
        
        if(lineup?.getDfsEntryFromIndex(index: indexPath.row)?.player != nil){
            cell.pos.text = lineup?.getDfsEntryFromIndex(index: indexPath.row)?.position?.getPositionName() ?? " "
            cell.playerName.text = "\(lineup?.getDfsEntryFromIndex(index: indexPath.row)?.player?.firstName ?? " ") \(lineup?.getDfsEntryFromIndex(index: indexPath.row)?.player?.lastName ?? " ")"
        } else {
                cell.pos.text = lineup?.getDfsEntryFromIndex(index: indexPath.row)?.position?.getPositionName() ?? ""
//                cell.playerName.text = lineup?.getDfsEntryFromIndex(index: indexPath.row)?.team?.abbreviation ?? " "
        }
        cell.playerSalary.text = "\(lineup?.getDfsEntryFromIndex(index: indexPath.row)?.salary ?? 0)"
        
        return cell
    }
>>>>>>> master:Blitz/MyLineupViewController.swift
    
    override func viewWillAppear(_ animated: Bool) {
        apiManager = ApiManager()
        if let apiManager = apiManager {
            apiManager.getLineup(){ (result) in
                switch(result) {
                case .success(let lineup):
                    self.lineup = lineup
                    print(lineup)
                    self.lineupTableView.reloadData()
                case .error(let error):
                    print(error)
                }
            }
        }
        else {
            print("Could not initialize apiManager")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineupTableView.dataSource = self
        lineupTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lineup != nil{
            return Lineup.lineupCount
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lineupTableViewCell", for: indexPath) as! LinupTableViewCell
        
        if let dfsEntry = lineup?.getDfsEntryFromIndex(index: indexPath.row) {
            cell.setLabelsFromDfsEntry(dfsEntry: dfsEntry)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PositionViewController,
            let row = lineupTableView.indexPathForSelectedRow?.row {
            destination.position = lineup?.getDfsEntryFromIndex(index: row)?.position
            destination.apiManager = apiManager
        }
    }

}
