//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Paweł Łąk on 02/06/2025.
//

import Foundation
import UIKit

class OnboardingViewController : UIViewController {
    
    init(_ model: OnboardingModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    let model : OnboardingModel
    
    let stackView = UIStackView()
    let imageVIew = UIImageView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
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
        imageVIew.image = UIImage(named: model.imagePath)
        imageVIew.backgroundColor = model.backgroundColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = model.title

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
