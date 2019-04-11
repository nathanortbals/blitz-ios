//
//  allPlayersViewController.swift
//  Blitz
//
//  Created by Aaron Henry on 4/11/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class allPlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var positon:String?
    
    @IBOutlet weak var allPlayerTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! allPlayersTableViewCell
        
        cell.playerName.text = "Tom Brady"
        cell.playerSalary.text = "14000000000"
        cell.pos.text = "QB"
        cell.matchup.text = "ATL"
        
        return cell
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
