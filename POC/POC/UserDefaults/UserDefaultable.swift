//
//  UserDefaultable.swift
//  POC
//
//  Created by Jackeline Pires De Lima on 26/11/22.
//

import Foundation

public protocol UserDefaultable {
    var userName: String? { get set }
}

public enum UserDefaultsKeys: String {
    case userName = "USER_NAME"
}

public class UserDefaultableImplementation: UserDefaultable {
    
    public static let shared = UserDefaultableImplementation()
    
    private init () {}
    
    @UserDefaultsWrapper(key: UserDefaultsKeys.userName, defaultValue: "")
    public var userName: String
}

