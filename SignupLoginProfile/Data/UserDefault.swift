//
//  UserDefault.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/4/22.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    private let key: String
    private let defaultValue: T
    private var defaults = UserDefaults.standard

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return defaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            defaults.set(newValue, forKey: key)
        }
    }
}

// token 저징
extension UserDefaults {
    @UserDefault(key: "token", defaultValue: "")
    static var token: String
}


