//
//  ExerciseTableViewController.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-07.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import UIKit

class ExerciseViewController: UITableViewController {
    
    var exercises: [Exercise]?

    override func viewDidLoad() {

    }

    @IBAction func markCompletedPressed(_ sender: UIButton) {
        print("Workout completed!")

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let exercise = exercises?[indexPath.row] {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as? ExerciseCell {
                cell.exerciseNameLabel.text = exercise.name
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
