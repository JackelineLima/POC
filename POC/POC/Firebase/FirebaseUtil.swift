//
//  FirebaseUtil.swift
//  POC
//
//  Created by Jackeline Pires De Lima on 26/11/22.
//

import Foundation
import FirebaseRemoteConfig

public class FirebaseUtil {
    
    static let shared = FirebaseUtil()

    var remoteConfig: RemoteConfig?
    var fetchIntervalInSeconds: TimeInterval = 0

    private init() {}

    func configure() {
        initFirebaseRemoteConfig()
    }


    private func fetchRemoteConfigValues() {
        remoteConfig?.fetch(withExpirationDuration: fetchIntervalInSeconds, completionHandler: { (status, error) in
            if status == .success {
                print("Firebase Config fetched success!")
                self.remoteConfig?.activate { (changed, error) in
                    if changed {
                        print("Firebase Config changed: \(String(describing: changed))")
                    }
                    
                    if error != nil {
                        NotificationCenter.default.post(name: .fetchRemoteConfigFailed, object: nil)
                        print("Firebase Config error: \(String(describing: error))")
                    } else {
                        NotificationCenter.default.post(name: .fetchRemoteConfigSucceed, object: nil)
                    }
                }
            } else if status == .failure {
                NotificationCenter.default.post(name: .fetchRemoteConfigFailed, object: nil)
                print("Firebase Config fetched error!")
            }
            
            if error != nil {
                print("Firebase Config error: \(String(describing: error))")
            }
        })
    }
    
    private func loadSettings() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = fetchIntervalInSeconds
        remoteConfig?.configSettings = settings
    }

    private func initFirebaseRemoteConfig() {
        loadSettings()
        fetchRemoteConfigValues()
    }
}

