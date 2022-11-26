//
//  FeatureFlag.swift
//  POC
//
//  Created by Jackeline Pires De Lima on 26/11/22.
//

import Foundation

public protocol FeatureFlagModel {
    var enabled: Bool { get }
}

public typealias FeatureFlagable = Codable & FeatureFlagModel

protocol FeatureFlagProtocol {
    var clientContainer: ConfigurableRemoteConfigClient { get set }
    func capture<T: FeatureFlagable>(type: T.Type, key: RemoteConfigKeys) -> T?
    func isEnabled<T: FeatureFlagable>(type: T.Type, key: RemoteConfigKeys) -> Bool
}

/// Pass throw a element from type FeatureFlagable to use your
public struct FeatureFlag: FeatureFlagProtocol {
    var clientContainer: ConfigurableRemoteConfigClient
    
    init(clientContainer: ConfigurableRemoteConfigClient = RemoteConfigClient.shared) {
        self.clientContainer = clientContainer
    }
    

    func capture<T: FeatureFlagable>(type: T.Type, key: RemoteConfigKeys) -> T? {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        guard let content = clientContainer.fetchData(key, type: type.self) else { return nil }
        dispatchGroup.leave()
        return content
    }
    

    func isEnabled<T: FeatureFlagable>(type: T.Type, key: RemoteConfigKeys) -> Bool {
        capture(type: type, key: key)?.enabled ?? false
    }
}

struct DefaultFeatureFlag: FeatureFlagable {
    var enabled: Bool
}
