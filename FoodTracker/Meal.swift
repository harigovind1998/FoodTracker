//
//  Meal.swift
//  FoodTracker
//
//  Created by Hari Govind on 2020-11-06.
//  Copyright © 2020 Hari Govind. All rights reserved.
//

import UIKit
import OSLog

class Meal: NSObject, NSCoding{
    
    //Mark: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    
    //MARK: Types
    struct PropertyKey{
        // Static propery values for use
        static let name = "name"
        static let image = "image"
        static let rating = "rating"
    }
    
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
        
        super.init()
    }
    
    //MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(image, forKey: PropertyKey.image)
        coder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder: NSCoder) {
        // Decode name of the meal from NSCoder. Required property hence fails if casting fails
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String
        else{
             os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
             return nil
        }
        
        // Decode image of the meal from NSCoder
        let image = coder.decodeObject(forKey: PropertyKey.image) as? UIImage
        
        // Decode rating of the meal from NSCoder
        let rating = coder.decodeInteger(forKey: PropertyKey.rating)
        
        // Call Meal initilizer
        self.init(name: name, image: image, rating: rating)
    }
    
     
}
