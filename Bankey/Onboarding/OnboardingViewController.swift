//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Paweł Łąk on 02/06/2025.
//

import Foundation
import UIKit

class OnboardingViewController : UIViewController {
    
    let stackView = UIStackView()
    let imageVIew = UIImageView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension OnboardingViewController{
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        //Image
        imageVIew.translatesAutoresizingMaskIntoConstraints = false
        imageVIew.contentMode = .scaleToFill
        imageVIew.image = UIImage(named: "delorean")
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = "Lorem Ipsum 123 Lorem Ipsum 123 Lorem Ipsum 123 Lorem Ipsum 123 Lorem Ipsum 123 Lorem Ipsum 123"

    }
    
    func layout() {
        stackView.addArrangedSubview(imageVIew)
        stackView.addArrangedSubview(label)
      
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
}
