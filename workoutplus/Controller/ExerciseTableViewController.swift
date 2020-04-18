//
//  ExerciseTableViewController.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-07.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import UIKit

class ExerciseTableViewController: UITableViewController {
    
    var exercises: [Exercise]?
    var dataSource: String?

    override func viewDidLoad() {
        loadData()

    }

    @IBAction func markCompletedPressed(_ sender: UIButton) {
        print("Workout completed!")

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.exercises?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let exercise = exercises?[indexPath.row] {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as? ExerciseTableViewCell {
                cell.exerciseNameLabel.text = exercise.name
                return cell
            }
        }
        return UITableViewCell()
    }
    
    // Code snippet source: https://www.knowband.com/blog/tutorials/read-data-local-json-file-swift/
    func readJSONFromFile(fileName: String) -> JSON?
    {
        var jsonData: JSON = nil
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                jsonData = JSON(data)
            } catch {
                // Handle error here
                print("Unable to read JSON from file")
            }
        }
        return jsonData
    }
    
    func loadData()
    {
        var exerciseData: JSON?
        self.exercises = [Exercise]()
        if let data = dataSource {
            if data == "Upper Body" {
                exerciseData = readJSONFromFile(fileName: "upperBodyData")
            } else if data == "Lower Body" {
                exerciseData = readJSONFromFile(fileName: "legsData")
            } else if data == "Full Body" {
                exerciseData = readJSONFromFile(fileName: "fullBodyData")
            }
            
            if let exercise = exerciseData {
                for (_, json) in exercise {
                    self.exercises?.append(Exercise(data: json))
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
