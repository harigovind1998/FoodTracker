//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Hari Govind on 2019-08-15.
//  Copyright © 2019 Hari Govind. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {

 	//MARK: Test Meal Class
    
    // Testing successful initilization method calls
    func testMealInitilizationSuccess(){
        let zeroRatingMeal = Meal.init(name: "Zero", image: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        let highRatingMeal = Meal.init(name:"Five", image: nil, rating: 5)
        XCTAssertNotNil(highRatingMeal)

    }
    
    //Testing faliure initilization metho calls
    func testMealInitlizationFailure(){
        let noNameMeal = Meal.init(name: "", image: nil, rating: 3)
        XCTAssertNil(noNameMeal)
        
        let negativeRatingMeal = Meal.init(name: "failure", image: nil, rating: -4)
        XCTAssertNil(negativeRatingMeal)
        
        let tooHighRatingMeal = Meal.init(name: "Too hight", image: nil, rating: 10)
        XCTAssertNil(tooHighRatingMeal)
    }

}
