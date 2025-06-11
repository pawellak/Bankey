//
//  AccountSummaryViewController+Networking.swift
//  Bankey
//
//  Created by jrasmusson on 2021-11-28.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

extension AccountSummaryViewController {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile,NetworkError>) -> Void) {
        let url = URL(string: "https://www.google.com/")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                completion(.success(Profile(id: "1", firstName: "firstNamePawel", lastName: "lastNameLak")))
//                guard let data = data, error == nil else {
//                    completion(.failure(.serverError))
//                    return
//                }
//                
//                do {
//                  
//                    completion(.success(Profile(id: "1", firstName: "firstNamePawel", lastName: "lastNameLak")))
//                } catch {
//                    completion(.failure(.decodingError))
//                }
            }
        }.resume()
    }
}

struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    
    static func makeSkeleton() -> Account {
        return Account(id: "", type: .Banking, name: "Account name", amount: 0, createdDateTime: Date())
    }
}

extension AccountSummaryViewController {
    func fetchAccounts(forUserId userId: String, completion: @escaping (Result<[Account],NetworkError>) -> Void) {
        let url = URL(string: "https://www.google.com/")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                
                let accountList = [
                    Account(id: "1", type: AccountType.Banking, name: "Banking", amount: 12.14, createdDateTime: Date()),
                    Account(id: "2", type: AccountType.CreditCard, name: "CreditCard", amount: 12.11, createdDateTime: Date()),
                    Account(id: "3", type: AccountType.Investment, name: "Investment", amount: 11232.44, createdDateTime: Date())] as [Account]
                
                completion(.success(accountList))
                
//                guard let data = data, error == nil else {
//                    completion(.failure(.serverError))
//                    return
//                }
//                
//                do {
//                    let decoder = JSONDecoder()
////                    decoder.dateDecodingStrategy = .iso8601
////                    
////                    let accounts = try decoder.decode([Account].self, from: data)
//                    
//                    let accountList = [
//                        Account(id: "1", type: AccountType.Banking, name: "Banking", amount: 12.14, createdDateTime: Date()),
//                        Account(id: "2", type: AccountType.CreditCard, name: "CreditCard", amount: 12.11, createdDateTime: Date()),
//                        Account(id: "3", type: AccountType.Investment, name: "Investment", amount: 11232.44, createdDateTime: Date())] as [Account]
//                    
//                    completion(.success(accountList))
//                } catch {
//                    completion(.failure(.decodingError))
//                }
            }
        }.resume()
    }
}
