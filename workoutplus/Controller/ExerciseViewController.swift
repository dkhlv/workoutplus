//
//  ExerciseTableViewController.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-07.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import UIKit
import CoreData

class ExerciseViewController: UITableViewController {
    
    var exercises: [Exercise]?
    var categoryName: String?
    var imageName: String?
    var duration:String?
    var calories: String?
    
    var numWorkoutsFullBody = 0
    var numWorkoutsLegs = 0
    var numWorkoutsUpper = 0
    var numWorkoutsYoga = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func completedButtonPressed(_ sender: UIButton) {
        
        
        switch categoryName {
            case "Full Body Workout":
                updateStatsData(key: "numWorkoutsFullBody")
            case "Core & Legs":
                updateStatsData(key: "numWorkoutsLegs")
            case "Upper Body Strength":
                updateStatsData(key: "numWorkoutsUpper")
            case "Yoga":
                updateStatsData(key: "numWorkoutsYoga")
            default:
                print("User completed a workout!")
        }
        
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
                cell.markCompletedButton.layer.cornerRadius = 20
                return cell
            }
            
        } else {
            if let exercise = exercises?[indexPath.row-1] {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as? ExerciseCell {
                    cell.textLabel?.text = exercise.name
                    cell.detailTextLabel?.text = "\(exercise.sets) Sets • \(exercise.reps) Reps • \(exercise.weight)"
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
    
    // MARK: - Core Data functions
    
    func saveStatsData(){
        
        self.clearStatsData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let stats = StatsModel(context: managedContext)
        stats.setValue(numWorkoutsFullBody, forKey: "numWorkoutsFullBody")
        stats.setValue(numWorkoutsLegs, forKey: "numWorkoutsLegs")
        stats.setValue(numWorkoutsUpper, forKey: "numWorkoutsUpper")
        stats.setValue(numWorkoutsYoga, forKey: "numWorkoutsYoga")
        
        do {
            try managedContext.save()
        } catch {
           print("Failed to save data")
        }
    }
    
    func clearStatsData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
            
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatsModel")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let resultsArray = results as? [NSManagedObject] {
                for statsData in resultsArray {
                    managedContext.delete(statsData)
                }
            }
            
        } catch {
            print(error)
        }
        
    }
        
    func updateStatsData(key: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatsModel")
        do {
            let test = try managedContext.fetch(fetchRequest)
            if test.capacity == 0 {
                self.saveStatsData()
            } else {
                let objectUpdate = test[0] as! NSManagedObject
                var value = objectUpdate.value(forKey: key) as! Int
                   value += 1
                objectUpdate.setValue(value, forKey: key)
                do{
                    try managedContext.save()
                }
                catch
                {
                    print(error)
                }
            }
        } catch {
            print(error)
        }

    }
    
}


