//
//  allPlayersViewController.swift
//  Blitz
//
//  Created by Aaron Henry on 4/11/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class PositionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var positionTableView: UITableView!
    
    var apiManager: ApiManager?
    var position: Position?
    var dfsEntries: [DfsEntry] = []
    
    override func viewWillAppear(_ animated: Bool) {
        if let apiManager = apiManager, let position = position {
            apiManager.getDfsEntries(position: position){ (result) in
                switch(result) {
                case .success(let dfsEntries):
                    self.dfsEntries = dfsEntries
                    print(dfsEntries)
                    self.positionTableView.reloadData()
                case .error(let error):
                    print(error)
                }
            }
        }
        else {
            print("Could not obtain ApiManager")
        }
        
        self.title = position?.getPositionName()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionTableView.delegate = self
        positionTableView.dataSource = self
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dfsEntries.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "positionTableViewCell", for: indexPath) as! PositionTableViewCell
        
        let dfsEntry = dfsEntries[indexPath.row]
        cell.setLabelsFromDfsEntry(dfsEntry: dfsEntry)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlayerViewController,
            let row = positionTableView.indexPathForSelectedRow?.row {
            destination.dfsEntry = dfsEntries[row]
            destination.apiManager = apiManager
        }
    }
}
