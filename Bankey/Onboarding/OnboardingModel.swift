//
//  OnboardingModel.swift
//  Bankey
//
//  Created by Paweł Łąk on 02/06/2025.
//

import UIKit

class OnboardingModel
{
    init(title: String, imagePath: String, backgroundColor: UIColor) {
        self.title = title
        self.imagePath = imagePath
        self.backgroundColor = backgroundColor
    }
    
    let title: String
    let imagePath :String
    let backgroundColor :UIColor
}
