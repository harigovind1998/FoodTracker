//
//  Meal.swift
//  FoodTracker
//
//  Created by Hari Govind on 2020-11-06.
//  Copyright © 2020 Hari Govind. All rights reserved.
//

import UIKit

class Meal{
    //MARK: Properties
    
    var name: String
    var image: UIImage?
    var rating: Int
    
    //MARK: Initilizer
    init?(name: String, image: UIImage?, rating:Int) {
        
        // Name cannot be an empty string
        guard !name.isEmpty else{
            return nil
        }
        
        //Rating must be between 0 and 5, inclusive
        guard (rating >= 0 && rating <= 5) else{
            return nil
        }
        
    
        self.name = name
        self.image = image
        self.rating = rating
    }
    
     
}
