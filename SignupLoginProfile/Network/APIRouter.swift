//
//  APIRouter.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import Foundation
import Alamofire
    
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
        case .profile: return [ "Authorization": "Bearer \(UserDefaults.token)",
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
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        return request
    }
}
