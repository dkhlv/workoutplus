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
    var categoryName: String?
    var imageName: String?
    var duration:String?

    override func viewDidLoad() {
//        self.navigationItem.title = categoryName
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises!.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseDescriptionCell") as? ExerciseCell {
                cell.categoryImageView.image = UIImage(named: imageName!)
                cell.durationLabel.text = duration!
                cell.intensityLabel.text = "Moderate"
                cell.levelLabel.text = "Beginner"
                cell.equipmentLabel.text = getEquipmentList()
                cell.workoutCategoryLabel.text = categoryName
                cell.markCompletedButton.layer.cornerRadius = 20
                return cell
            }
            
        } else {
            if let exercise = exercises?[indexPath.row-1] {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as? ExerciseCell {
                    cell.exerciseNameLabel.text = exercise.name
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    // MARK: - Helper functions
    
    func getEquipmentList() -> String {
        var equipmentList = [String]()
        if let exercise_list = exercises {
            for exercise in exercise_list {
                if exercise.category != "No Equipment" && !equipmentList.contains(exercise.category){
                    equipmentList.append(exercise.category)
                }
            }
        }
        
        return equipmentList.joined(separator: "•")
    }
    
}


