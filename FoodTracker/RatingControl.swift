//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Hari Govind on 2020-10-28.
//  Copyright © 2020 Hari Govind. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK: Properties
    private var ratingButtons = [UIButton] ()
    var rating = 0{
        didSet{
            updateSelectedButtonState()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            createButtons()
        }
    }
    @IBInspectable var starCount: Int = 5{
        didSet{
            createButtons()
        }
    }

    // MARK: Initilization
    override init(frame: CGRect) {
        super.init(frame: frame)
        createButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        createButtons()
    }
    
    // MARK: Private methods
    private func createButtons(){
        // Clear existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for:type(of:self))
        let filledStar = UIImage(named: "FilledStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "HighlightedStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "EmptyStar", in:  bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount{
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted,.selected])
            
            // Add Constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //Set the accessibility label
            button.accessibilityLabel = "set \(index + 1) start rating"
            
            
            // Button Action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonPressed(button:)), for: .touchUpInside)
            
            // Add button to stack
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
        
        updateSelectedButtonState()
       
    }
    
    //MARK: Button Action
    @objc func ratingButtonPressed(button: UIButton){
        guard let index = ratingButtons.firstIndex(of: button) else{
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        
        rating = selectedRating == rating ? 0: selectedRating
    }
        
       
        
        private func updateSelectedButtonState() {
            for(index, button) in ratingButtons.enumerated(){
                button.isSelected = index < rating
                
                // Set the hint string for the currently selected star
                let hintString: String?
                if rating == index + 1 {
                    hintString = "Tap to reset the rating to zero."
                } else {
                    hintString = nil
                }
                 
                // Calculate the value string
                let valueString: String
                switch (rating) {
                case 0:
                    valueString = "No rating set."
                case 1:
                    valueString = "1 star set."
                default:
                    valueString = "\(rating) stars set."
                }
                 
                // Assign the hint string and value string
                button.accessibilityHint = hintString
                button.accessibilityValue = valueString
            }
        }
}
