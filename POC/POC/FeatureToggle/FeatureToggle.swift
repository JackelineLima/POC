//
//  FeatureToggle.swift
//  POC
//
//  Created by Jackeline Pires De Lima on 26/11/22.
//

import Foundation

@propertyWrapper
final class FeatureToggle {
    
    var clientContainer: ConfigurableRemoteConfigClient
    private let key: RemoteConfigKeys

    var wrappedValue: Bool {
        FeatureFlag(clientContainer: clientContainer)
            .isEnabled(
                type: DefaultFeatureFlag.self,
                key: key)
    }

    init(key: RemoteConfigKeys, clientContainer: ConfigurableRemoteConfigClient = RemoteConfigClient.shared ) {
        self.key = key
        self.clientContainer = clientContainer
    }
}
