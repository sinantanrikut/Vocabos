//
//  UserViewModel.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 23.09.2023.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

final class UserViewModel: BaseViewModel {
        
    @Published var isLogin = false

    func signInGoogle() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResulModel(idToken: idToken, accessToken: accessToken)
        
        // Google ile giriş başarılı olduğunda isLogin değerini true olarak ayarla
        try await AuthenticationManager.shared.signInWithGoogle(token: tokens)
        isLogin = true
    }
}
