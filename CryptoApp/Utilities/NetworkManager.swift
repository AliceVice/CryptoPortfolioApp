//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 07/03/2025.
//

import Foundation
import Combine

final class NetworkManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case uknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url): return "[⚠️] Bad response from URL - \(url)"
            case .uknown: return "[‼️] Uknown error occured"
            }
        }
    }
    
    
    static public func download(url: URL) -> AnyPublisher<Data, Error> {
        let temp = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .receive(on: DispatchQueue.main)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .eraseToAnyPublisher()
        
        return temp
    }

    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        guard let response = output.response as? HTTPURLResponse,
              200..<300 ~= response.statusCode
        else { throw NetworkingError.badURLResponse(url: url) }
        
        return output.data
    }
    
    static public func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

}
