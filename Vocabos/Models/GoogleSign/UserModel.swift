//
//  UserModel.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 2.12.2023.
//
import Foundation
import FirebaseAuth

struct User {
    let uid: String
    let email: String?
    let photoUrl: String // Assuming this property exists in your User type
    let nameSurname: String // Assuming this property exists in your User type
    
    init(fromFirebaseUser firebaseUser: FirebaseAuth.User) {
        self.uid = firebaseUser.uid
        self.email = firebaseUser.email
        // Adjust this line based on the actual property in your FirebaseAuth.User
        self.photoUrl = firebaseUser.photoURL?.absoluteString ?? ""
        
        // Assuming name and surname are separate properties in FirebaseAuth.User
        if let name = firebaseUser.displayName {
            self.nameSurname = name
        } else {
            self.nameSurname = ""
        }
        
        // If name and surname are combined in a single property
        // self.nameSurname = firebaseUser.displayName ?? ""
    }
}
