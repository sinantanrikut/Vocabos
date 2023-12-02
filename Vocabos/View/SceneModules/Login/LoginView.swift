//
//  LoginView.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 23.09.2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth


struct LoginView: View {
    
    @ObservedObject private var viewModel  = UserViewModel()
    @State private var username = ""
    @State private var password = ""
    @Binding var showSignInView : Bool
    var body: some View {
        VStack(alignment: .center,spacing: 10){
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .padding(.top)
                .padding(.bottom)
            
            HStack{
                Text("Login")
                    .font(.setCustom(fontStyle: .headline, fontWeight: .bold))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("to your account")
                    .font(.setCustom(fontStyle: .headline, fontWeight: .regular))
                    .foregroundColor(.black)
                    .padding(.leading,-2)
                
                Spacer()
                
            }
            .padding(.bottom,30)
            
          StandartTextField(value: $username, fieldName: "phone-number", contentType: .telephoneNumber, keyboardType: .numberPad, pattern: .phoneNumber)
            
            PrimaryButton(buttonText: "Login")
                .padding(.top)
            HStack{
                Text("Don't have an account?")
                    .font(.setCustom(fontStyle: .callout, fontWeight: .regular))
                Text("Signup")
                    .font(.setCustom(fontStyle: .callout, fontWeight: .regular))
                    .foregroundStyle(Color.mainColor)
            }
            .padding(.top)
            
            Text("- Or Sign in with -")
                .font(.setCustom(fontStyle: .callout, fontWeight: .regular))
                .padding(.top,30)
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark,style: .wide, state: .normal)){
                Task{
                    do{
                        try await viewModel.signInGoogle()
                        showSignInView = false
                    }catch{
                     print(error)
                    }
                }
            }
                .padding(.top)
            
        }
        .frame(maxWidth: .infinity)
        .padding([.leading,.trailing],20)
        .workaroundLink(to: HomeView().navigationBarBackButtonHidden(), isActive: $viewModel.isLogin)
        
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(showSignInView: false)
//    }
//}

