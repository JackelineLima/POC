//
//  RemoteConfigClient.swift
//  POC
//
//  Created by Jackeline Pires De Lima on 26/11/22.
//

import Foundation

extension Notification.Name {
    static let fetchRemoteConfigSucceed = Notification.Name("fetchRemoteConfigSucceed")
    static let fetchRemoteConfigFailed = Notification.Name("fetchRemoteConfigFailed")
}

public protocol ConfigurableRemoteConfigClient {
    func fetchData(_ key: RemoteConfigKeys) -> String?
    func fetchData<T: Codable>(_ key: RemoteConfigKeys, type: T.Type) -> T?
}

protocol BaseRemoteConfigModel {
    var enabled: Bool { get }
}

struct RemoteConfigKey: Codable {
    let enabled: Bool
}

public struct RemoteConfigClient: ConfigurableRemoteConfigClient {

    static let shared = RemoteConfigClient()

    private init() { }
    
    public func fetchData<T: Codable>(_ key: RemoteConfigKeys, type: T.Type) -> T? {
        let remoteConfig = FirebaseUtil.shared.remoteConfig
        
        guard let remoteConfigData = remoteConfig?.configValue(forKey: key.rawValue).stringValue else {
            return nil
            
        }
        let decodedObject = try? JSONDecoder().decode(type.self, from: Data(remoteConfigData.utf8))
        return decodedObject
    }
    
    public func fetchData(_ key: RemoteConfigKeys) -> String? {
        let remoteConfig = FirebaseUtil.shared.remoteConfig
        guard let remoteConfigValue = remoteConfig?.configValue(forKey: key.rawValue).stringValue else { return nil }
        return remoteConfigValue
    }
}
