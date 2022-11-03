//
//  Profile.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/3/22.
//

import Foundation

struct Profile: Codable {
    let user: UserDTO
}

struct UserDTO: Codable {
    let photo: String
    let email: String
    let username: String
}
