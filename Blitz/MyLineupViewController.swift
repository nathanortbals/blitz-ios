//
//  MyLineupViewController.swift
//  Blitz
//
//  Created by Aaron Henry on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class MyLineupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var position:[String] = ["QB", "RB1", "RB2", "WR1", "WR2", "WR3", "TE", "FLEX", "D"]
    @IBOutlet weak var myLineupTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return position.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! MyLinupTableViewCell
        
        cell.pos.text = position[indexPath.row]
        cell.playerName.text = "Tom Brady"
        cell.playerSalary.text = "14000000000"
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        myLineupTableView.dataSource = self
        myLineupTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? allPlayersViewController,
            let row = tableview.indexPathForSelectedRow?.row {
            destination.positon = position[row]
        }
        
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
