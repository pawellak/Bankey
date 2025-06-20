//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Paweł Łąk on 04/06/2025.
//

import Foundation
import UIKit

enum AccountType: String,Codable {
    case Banking
    case CreditCard
    case Investment
}

class AccountSummaryCell : UITableViewCell {
    
    struct ViewModel {
        let accountType: AccountType
        let accountName:String
        let balance:Decimal
        
        var balanceAttributeString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    let viewModel : ViewModel? = nil
    
    let typeLabel = UILabel()
    let divider = UIView()
    let nameLabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right")!.withTintColor(appColor,renderingMode: .alwaysOriginal))
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryCell {
    private func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account Type"
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .red
 
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Account Name"
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.text = "Balance Label"
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
            
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        balanceStackView.axis = .vertical
        balanceStackView.alignment = .firstBaseline
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(divider)
        contentView.addSubview(nameLabel)
        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            divider.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            divider.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            divider.widthAnchor.constraint(equalToConstant: 60),
            divider.heightAnchor.constraint(equalToConstant: 8),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: divider.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 3),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow:divider.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
    }
}

extension AccountSummaryCell {
    
    func configure(with vm: ViewModel) {
        
        nameLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAttributeString
        
        switch vm.accountType {

        case .Banking:
            divider.backgroundColor = appColor
            balanceLabel.text = "Balance"
        case .CreditCard:
            divider.backgroundColor = .systemOrange
            balanceLabel.text = "Balance"
        case .Investment:
            divider.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
       
    }
}
