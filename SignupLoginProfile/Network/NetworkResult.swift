//
//  NetworkResult.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}















