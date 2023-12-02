//
//  model.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 2.12.2023.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String
    let nameSurname: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoUrl
        self.nameSurname = user.nameSurname
    }
}
