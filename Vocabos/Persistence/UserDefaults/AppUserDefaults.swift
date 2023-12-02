//
//  AppUserDefaults.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 1.12.2023.
//

import Foundation

struct AppUserDefaults {
    @UserDefault(key: UserDefaultsKey.uid.rawValue, default: "")
    static var uid: String
    @UserDefault(key: UserDefaultsKey.email.rawValue, default: "")
    static var email: String
    @UserDefault(key: UserDefaultsKey.photo_url.rawValue, default: "")
    static var photo_url: String
    @UserDefault(key: UserDefaultsKey.name_surname.rawValue, default: "")
    static var name_surname: String
}
