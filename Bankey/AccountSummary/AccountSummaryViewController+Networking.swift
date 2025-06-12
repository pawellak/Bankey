//
//  AccountSummaryViewController+Networking.swift
//  Bankey
//
//  Created by jrasmusson on 2021-11-28.
//

import Foundation
import UIKit



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
                
//                if error == nil {
//                    completion(.failure(.serverError))
//                } else {
                    let accountList = [
                        Account(id: "1", type: AccountType.Banking, name: "Banking", amount: 12.14, createdDateTime: Date()),
                        Account(id: "2", type: AccountType.CreditCard, name: "CreditCard", amount: 12.11, createdDateTime: Date()),
                        Account(id: "3", type: AccountType.Investment, name: "Investment", amount: 11232.44, createdDateTime: Date())] as [Account]
                    
                    completion(.success(accountList))
//                }
            }
        }.resume()
    }
}

func jsonStringToModel<T: Decodable>(_ jsonString: String, as type: T.Type) -> T? {
    // Convert the string to Data
    guard let data = jsonString.data(using: .utf8) else {
        print("Error: Cannot convert string to Data")
        return nil
    }
    
    // Decode the data to the specified model type
    do {
        let decoder = JSONDecoder()
        let model = try decoder.decode(T.self, from: data)
        return model
    } catch {
        print("Decoding error: \(error.localizedDescription)")
        return nil
    }
}
