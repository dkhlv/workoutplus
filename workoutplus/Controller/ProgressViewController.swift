//
//  ProgressViewController.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-09.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {

    @IBOutlet weak var numberWorkoutsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberWorkoutsLabel.text = "0"
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
