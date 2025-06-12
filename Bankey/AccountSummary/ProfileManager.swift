//
//  ProfileManager.swift
//  Bankey
//
//  Created by Paweł Łąk on 12/06/2025.
//

import Foundation

protocol ProfileManageable : AnyObject {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile,NetworkError>) -> Void)
}


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



class ProfileManager : ProfileManageable {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile,NetworkError>) -> Void) {
        let url = URL(string: "https://www.google.com/")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                
                let jsonString = """
                    {
                        "id": "1",
                        "first_name": "Pawel",
                        "last_name" : "Lak", 
                    }
                    """
                
                if let person = jsonStringToModel(jsonString, as: Profile.self) {
                    completion(.success(person))
                }else
                {
                    completion(.failure(.decodingError))
                }
                
            }
        }.resume()
    }
}
  
