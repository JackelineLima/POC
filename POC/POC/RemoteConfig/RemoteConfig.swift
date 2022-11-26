//
//  RemoteConfig.swift
//  POC
//
//  Created by Jackeline Pires De Lima on 26/11/22.
//

import Foundation

public enum RemoteConfigKeys: String {
    case enableCampaign = "enable_campaign"
}

public class FeatureToggleImplementation {
    
    public static let shared = FeatureToggleImplementation()
    
    private init () {}
    
    @FeatureToggle(key: .enableCampaign)
    public var enableCampaign
}
