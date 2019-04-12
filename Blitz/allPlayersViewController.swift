//
//  allPlayersViewController.swift
//  Blitz
//
//  Created by Aaron Henry on 4/11/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class allPlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var apiManager: ApiManager?
    var position: Position?
   // var players: Player?
    var dfsEntry: [DfsEntry?] = []
    
    @IBOutlet weak var allPlayerTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this needs to apiManager get the number of players based on the number of players in the request.
       
        return dfsEntry.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! allPlayersTableViewCell
        
        let row = indexPath.row
        cell.playerName.text = "\(dfsEntry[row]?.player?.firstName ?? "") \(dfsEntry[row]?.player?.lastName ?? "")"
        cell.playerSalary.text = "\(dfsEntry[row]?.salary ?? 0)"
        cell.matchup.text = "\(dfsEntry[row]?.game?.awayTeamAbbreviation ?? "") at \(dfsEntry[row]?.game?.homeTeamAbbreviation ?? "")"
        cell.playerSalary.text = "\(dfsEntry[row]?.salary ?? 0)"
        cell.pos.text = dfsEntry[row]?.position?.getPositionName()
        
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        apiManager = ApiManager()
        if let apiManager = apiManager{
            if (position != nil){
                apiManager.getDfsEntries(position: position!){ (result) in
                switch(result) {
                case .success(let players):
                    self.dfsEntry = players
                    self.allPlayerTableView.reloadData()
                case .error(let error):
                    print(error)
                }
            }
            }
            else{
                print("There was a nil in position")
            }
        }
        
    }
    
    @IBAction func addPlayerToLineup(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allPlayerTableView.delegate = self
        allPlayerTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
