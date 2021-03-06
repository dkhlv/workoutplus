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
    var calories: String?
    var dbLookupDictionary = [
        "Full Body Workout": "numWorkoutsFullBody",
        "Core & Legs": "numWorkoutsLegs",
        "Upper Body Strength": "numWorkoutsUpper",
        "Yoga": "numWorkoutsYoga"
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }
    
    @IBAction func completedButtonPressed(_ sender: UIButton) {
        
        if let category = categoryName {
            CoreDataHelper.instance.updateStatsData(key: dbLookupDictionary[category]!)
        }
        CoreDataHelper.instance.updateStatsData(key: "numWorkoutsTotal")
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
                cell.caloriesLabel.text = calories
                cell.equipmentLabel.text = getEquipmentList()
                cell.workoutCategoryLabel.text = categoryName
                cell.markCompletedButton.layer.cornerRadius = 18
                return cell
            }
            
        } else {
            if let exercise = exercises?[indexPath.row-1] {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as? ExerciseCell {
                    cell.textLabel?.text = exercise.name
                    cell.detailTextLabel?.text = "\(exercise.sets) Sets • \(exercise.reps) Reps • \(exercise.weight)"
                    cell.detailTextLabel?.textColor = UIColor.gray
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? VideoViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
            destination.exerciseName = exercises![indexPath.row-1].name
        }
        
    }
    
    // MARK: - Helper functions
    
    func getEquipmentList() -> String {
        var equipmentList = [String]()
        if let exercise_list = exercises {
            for exercise in exercise_list {
                if exercise.category != "No Equipment"  &&  exercise.category != "Gym" && !equipmentList.contains(exercise.category){
                    equipmentList.append(exercise.category)
                }
            }
        }
        
        return equipmentList.joined(separator: "•")
    }
    
}


