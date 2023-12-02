//
//  AuthenicationManager.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 27.11.2023.
//

import Foundation
import FirebaseAuth

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
        AppUserDefaults.name_surname = user.nameSurname
        return AuthDataResultModel(user: user)
    }
    
}
