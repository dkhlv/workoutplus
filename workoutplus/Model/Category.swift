//
//  Category.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-21.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import Foundation

struct Category {
    
    var categoryName: String
    var categoryId: String
    var duration: String
    var calories: String
    var imageName: String
    var exercises: [JSON]
    
    init(data: JSON)
    {
        self.categoryName = "\(data["category_name"].stringValue)"
        self.categoryId = "\(data["category_id"].stringValue)"
        self.duration = "\(data["duration"].stringValue)"
        self.calories = "\(data["calories"].stringValue)"
        self.imageName = "\(data["image"].stringValue)"
        self.exercises = data["exercises"].arrayValue
    }
}
