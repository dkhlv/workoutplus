//
//  CategoriesTableViewController.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-05.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var categories: [String]?

    override func viewDidLoad() {
        self.categories = ["Upper Body Strength", "Core & Legs", "Full Body Workout"]
//        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let category = categories?[indexPath.row] {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryTableViewCell {
                cell.workoutTypeLabel.text = category
                cell.categoryImage.image = UIImage(named: "category" + String(indexPath.row+1))
                return cell
            }
        }
        
        return UITableViewCell()
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ExerciseTableViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            
            destination.dataSource = categories?[indexPath.row]
        }
    }
    

}
