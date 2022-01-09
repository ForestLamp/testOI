//
//  Network.swift
//  testOI
//
//  Created by Alex Ch. on 07.01.2022.
//

import Foundation

class Network {
    
    enum Constants {
        static let apiKey = "5865d759e4b5ae9cce6ce38db27d56fa650ba50c9275fbdb12bc5eaedebf80df"
    }
    
    func  request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        let parametrs = self.prepareParametrs(searchTerm: searchTerm)
        let url = self.url(params: parametrs)
        var request = URLRequest(url: url)
        //request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers ["api_key"] = Constants.apiKey
        return headers
    }
    
    private func prepareParametrs (searchTerm: String?) -> [String:String] {
        var parametrs = [String:String]()
        parametrs["q"] = searchTerm
        parametrs["tbm"] = "isch"
        parametrs["api_key"] = Constants.apiKey
        return parametrs
    }
    
    private func url(params: [String:String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "serpapi.com"
        components.path = "/search.json"
        components.queryItems = params.map {URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?)-> Void) -> URLSessionTask {
        return URLSession.shared.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async {
                completion (data, error)
            }
        }
    }
}
