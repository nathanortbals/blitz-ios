//
//  detailViewController.swift
//  Blitz
//
//  Created by Akrum Mahmud on 4/11/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    @IBOutlet var playerName: UIView!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerSalary: UILabel!
    @IBOutlet weak var playerMatchup: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
