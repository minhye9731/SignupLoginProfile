//
//  Network.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/3/22.
//

import Foundation
import Alamofire
import RxSwift

final class Network {
    
    static let share = Network()
    
    private init() { }
    
    // signup(post)
    func requestSignup(router: APIRouter, completion: @escaping (Result<String, Error>) -> Void) {
        
        AF.request(router).responseString { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
    
    // login(post), profile(get)
    func requestSeSAC<T: Codable>(type: T.Type = T.self, router: APIRouter, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(router).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
}
