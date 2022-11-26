//
//  UserDefaultsWrapper.swift
//  POC
//
//  Created by Jackeline Pires De Lima on 26/11/22.
//

import Foundation

@propertyWrapper
public struct UserDefaultsWrapper<Value> {
    let key: UserDefaultsKeys
    let defaultValue: Value
    
    public init(key: UserDefaultsKeys, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: Value {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? Value ?? defaultValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key.rawValue)
        }
    }
}
