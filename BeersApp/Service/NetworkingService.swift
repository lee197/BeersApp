//
//  NetworkingServic.swift
//  BeersApp
//
//  Created by 李祺 on 03/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//
import Foundation

enum APIError: Error {
    case clientError(description: String)
    case serverError
    case noData
    case httpError(description: String)
    case dataDecodingError
}

protocol BeerInfoFetchable {
    func fetchBeerInfo(beerTpes: String, complete completionHandler: @escaping (Result<[BeerModel], APIError>) -> Void)
    func fetchBeerTypes(complete completionHandler: @escaping (Result<String, APIError>) -> Void)
}

struct BeerInfoFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension BeerInfoFetcher: BeerInfoFetchable {
    
    func fetchBeerTypes(complete completionHandler: @escaping (Result<String, APIError>) -> Void) {
        guard let url = makeCustomerInterestComponents().url else {
            let error = APIError.httpError(description: "Couldn't create URL")
            completionHandler(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let networkError = error {
                completionHandler(.failure(.clientError(description: networkError.localizedDescription)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completionHandler(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            if let textFromFile = String(data: data, encoding: .utf8) {
                completionHandler(.success(textFromFile))
            } else {
                completionHandler(.failure(.noData))
            }
        }.resume()
    }
    
    func fetchBeerInfo(beerTpes: String, complete completionHandler: @escaping (Result<[BeerModel], APIError>) -> Void) {
        guard let url = makeBeerInfoComponents(withBeerTypes: beerTpes).url else {
            let error = APIError.httpError(description: "Couldn't create URL")
            completionHandler(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let networkError = error {
                completionHandler(.failure(.clientError(description: networkError.localizedDescription)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completionHandler(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do{
                let value = try decoder.decode([BeerModel].self, from: data)
                completionHandler(.success(value))
            }catch{
                completionHandler(.failure(.dataDecodingError))
            }
        }.resume()
    }
}


private extension BeerInfoFetcher {
    
    struct BeerInfoApi {
        static let scheme = "https"
        static let host = "api.punkapi.com"
        static let path = "/v2/beers"
    }
    
    struct CustomerInterestApi {
        static let scheme = "https"
        static let host = "gist.githubusercontent.com"
        static let path = "/LuigiPapinoDrop/d8ed153d5431bbad23e1e1c6b5ba1e3c/raw/4ec1c8064e51838240e941679d3ac063460685c2"
    }
    
    func makeBeerInfoComponents(withBeerTypes list: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = BeerInfoApi.scheme
        components.host = BeerInfoApi.host
        components.path = BeerInfoApi.path
        
        components.queryItems = [
            URLQueryItem(name: "ids", value: list),
        ]
        
        return components
    }
    
    func makeCustomerInterestComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = CustomerInterestApi.scheme
        components.host = CustomerInterestApi.host
        components.path = CustomerInterestApi.path + "/code_challenge_richer.txt"
        
        return components
    }
}
