//
//  MyLineupViewController.swift
//  Blitz
//
//  Created by Aaron Henry on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class LineupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lineupTableView: UITableView!
    
    var apiManager: ApiManager?
    var lineup: Lineup?
    
    override func viewWillAppear(_ animated: Bool) {
        view.showBlurLoader()
        apiManager = ApiManager()
        if let apiManager = apiManager {
            apiManager.getLineup(){ (result) in
                switch(result) {
                case .success(let lineup):
                    self.view.removeBlurLoader()
                    self.lineup = lineup
                    print(lineup)
                    self.lineupTableView.reloadData()
                case .error(let error):
                    self.view.removeBlurLoader()
                    let alert = UIAlertController(title: "Error", message: "Could not fetch data from server.", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
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
            cell.setLabelsFromDfsEntry(lineupPosition: indexPath.row, dfsEntry: dfsEntry)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PositionViewController,
            let row = lineupTableView.indexPathForSelectedRow?.row {
            destination.lineupPosition = row
            destination.apiManager = apiManager
        }
    }
}
