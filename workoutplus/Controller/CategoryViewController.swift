//
//  CategoryViewController.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-05.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import UIKit

struct Category {
    var categoryName: String
    var duration: String
    var calories: String
    var imageName: String
    var exercises: [JSON]
    
    init(data: JSON)
    {
        self.categoryName = "\(data["category_name"].stringValue)"
        self.duration = "\(data["duration"].stringValue)"
        self.calories = "\(data["calories"].stringValue)"
        self.imageName = "\(data["image"].stringValue)"
        self.exercises = data["exercises"].arrayValue
    }
}

class CategoryViewController: UITableViewController {
    
    var categories: [Category]?

    override func viewDidLoad() {
        loadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let category = categories?[indexPath.row] {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell {
                cell.workoutTypeLabel.text = category.categoryName
                cell.categoryImage.image = UIImage(named: category.imageName)
                return cell
            }
        }
        
        return UITableViewCell()
    }


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ExerciseViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            
            var exercises = [Exercise]()
            for exercise in categories![indexPath.row].exercises {
                exercises.append(Exercise(data: exercise))
            }
            destination.exercises = exercises
            destination.categoryName = categories![indexPath.row].categoryName
            destination.imageName = categories![indexPath.row].imageName
            destination.duration = categories![indexPath.row].duration
            
        }
    }
    
    
    // MARK: - Helper functions
    func loadData()
    {
        var categoryData: JSON?
        self.categories = [Category]()
        categoryData = readJSONFromFile(fileName: "workout_data")
            
            if let category = categoryData {
                for (_, json) in category {
                    self.categories?.append(Category(data: json))
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
    

}
