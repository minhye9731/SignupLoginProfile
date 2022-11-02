//
//  APIRouter.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import Foundation
import Alamofire
//
//class APIPath {
//    static let signUp = "/signup"
//    static let login = "/login"
//    static let profile = "/me"
//}
//
//class APIRouter: URLRequestConvertible {
//
//    enum SeSACAPI {
//        case signup(userName: String, email: String, password: String)
//        case login(email: String, password: String)
//        case profile
//    }
//
//    let baseURL = "http://api.memolease.com/api/v1/users"
//
//    var path: String
//    var httpMethod: HTTPMethod
//    var parameters: [String:String]?
//    var apiType: SeSACAPI
//
//    init(path: String, httpMethod: HTTPMethod? = .get, parameters: [String:String]? = nil, apiType: SeSACAPI = .profile) {
//        self.path = path
//        self.httpMethod = httpMethod ?? .get
//        self.parameters = parameters
//        self.apiType = apiType
//    }
//
//    func asURLRequest() throws -> URLRequest {
//        let fullURL = baseURL + path
//        let encodedURL = fullURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        var urlComponent = URLComponents(string: encodedURL)!
//
//        if httpMethod == .get, let params = parameters {
//            if let dictionary = try? JSONSerialization.jsonObject(with: params, options: []) as? [String:Any] {
//                var queries = [URLQueryItem]()
//                for (name, value) in dictionary {
//                    let encodedValue = "\(value)".addingPercentEncodingForRFC3986()
//                    let queryItem = URLQueryItem(name: name, value: encodedValue)
//                    queries.append(queryItem)
//                }
//                urlCompoenet.percentEncodedQueryItems = queries
//            }
//        }
//
//    }
//
//}
    
enum APIRouter: URLRequestConvertible {

    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile

    var baseURL: URL {
        return URL(string: "http://api.memolease.com/api/v1/users/")!
    }

    var method: HTTPMethod {
        switch self {
        case .profile:
            return .get
        case .signup:
            return .post
        case .login:
            return .post
        }
    }

    var path: String {
        switch self {
        case .signup:
            return "signup"
        case .login:
            return "login"
        case .profile:
            return "me"
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .signup, .login: return ["Content-Type": "application/x-www-form-urlencoded"]
            //form-urlencoded 이걸 보고 아래에서 encoder를 선택함
        case .profile: return [ "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)",
                                "Content-Type": "application/x-www-form-urlencoded" ]
        }
    }
    
    var parameters: [String:String] {
        switch self {
        case .signup(let userName, let email, let password):
            return [
                "userName": userName,
                "email": email,
                "password": password
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        default: return ["":""]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url) // url 적용

        request.method = method // 메서드 적용

        request.headers = headers // 헤더 적용

        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request) // 파라미터

        return request
    }


}
