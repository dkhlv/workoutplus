//
//  Exercise.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-07.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import Foundation

class Exercise {
    var name: String
    var category: String
    var sets: String
    var reps: String
    var weight: String
    
    
    init(data: JSON)
    {
        self.name = "\(data["name"].stringValue)"
        self.category = "\(data["category"].stringValue)"
        self.sets = "\(data["sets"].stringValue)"
        self.reps = "\(data["reps"].stringValue)"
        self.weight = "\(data["weight"].stringValue)"

    }
}
