//
//  DeviceInfo.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 15.09.2023.
//

import UIKit

struct DeviceInfo {
    static let deviceID = UIDevice.current.identifierForVendor?.uuidString
    static let systemVersion = UIDevice.current.systemVersion
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let osType = "IOS"
    static let language = Locale.current.languageCode
}
