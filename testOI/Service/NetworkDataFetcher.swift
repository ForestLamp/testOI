//
//  NetworkDataFetcher.swift
//  testOI
//
//  Created by Alex Ch. on 08.01.2022.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService = Network()
    
    func fetchImages(searhTerm: String, completion: @escaping (SearchResults?) ->()) {
        networkService.request(searchTerm: searhTerm) {(data, error) in
            if let error = error {
                print("Ошибка запрошенных данных:", error.localizedDescription)
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Ошибка парсинга", jsonError)
            return nil
        }
    }
}
