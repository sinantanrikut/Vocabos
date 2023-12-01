//
//  AuthenicationManager.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 27.11.2023.
//

import Foundation
import FirebaseAuth

struct User {
    let uid: String
    let email: String?
    let photoUrl: String // Assuming this property exists in your User type
    
    init(fromFirebaseUser firebaseUser: FirebaseAuth.User) {
        self.uid = firebaseUser.uid
        self.email = firebaseUser.email
        // Adjust this line based on the actual property in your FirebaseAuth.User
        self.photoUrl = firebaseUser.photoURL?.absoluteString ?? ""
    }
}

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoUrl
    }
}





final class AuthenticationManager{
    static let shared = AuthenticationManager()
    private init(){}
    

    
}

//MARK: SIGN IN SSO
extension AuthenticationManager{
    @discardableResult
    func signInWithGoogle(token: GoogleSignInResulModel) async throws -> AuthDataResultModel{
        let credential = GoogleAuthProvider.credential(withIDToken: token.idToken,
                                                       accessToken:token.accessToken)
        
        return try await signIn(credential: credential)
    }
    
    func signIn(credential : AuthCredential) async throws -> AuthDataResultModel{
        let authDataModel = try await Auth.auth().signIn(with: credential)
        let user = User(fromFirebaseUser: authDataModel.user)
        // Verileri kullan
        AppUserDefaults.uid = user.uid
        AppUserDefaults.email = user.email ?? ""
        AppUserDefaults.photo_url = user.photoUrl
        return AuthDataResultModel(user: user)
    }
    
}
