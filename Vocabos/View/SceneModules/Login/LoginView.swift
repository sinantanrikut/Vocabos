//
//  LoginView.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 23.09.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
      @State private var password = ""
    
    var body: some View {
        VStack(alignment: .center,spacing: 10){
            ScrollView {
                              
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
                CustomTextField(text: $username, placeholder: "Kullanıcı Adı", imageName: "person")
                              .padding(.bottom, 20)
                CustomSecureField(text: $password, placeholder: "Parola", imageName: "lock")
                
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
                
                PrimaryButton(buttonText: "Apple Login")
                    .padding(.top)
            }
        }
        .frame(maxWidth: .infinity)
        .padding([.leading,.trailing],20)

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CustomSecureField: View {
    @Binding var text: String
    var placeholder: String
    var imageName: String
    
    @State private var isSecure = true
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1))
                .frame(height: 50)
            
            HStack {
                Image(systemName: imageName)
                    .foregroundColor(.mainColor)
                    .padding(.leading, 10)
                
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .padding(.leading, 5)
                }
                
                if isSecure {
                    SecureField("", text: $text)
                        .padding(.leading, text.isEmpty ? -10 : 0)
                } else {
                    TextField("", text: $text)
                        .padding(.leading, text.isEmpty ? -10 : 0)
                }
                
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 10)
            }
        }
    }
}
struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var imageName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1))
                .frame(height: 50)
            
            HStack {
                Image(systemName: imageName)
                    .foregroundColor(.mainColor)
                    .padding(.leading, 10)
                
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .padding(.leading, 5)
                }
                
                TextField("", text: $text)
                    .padding(.leading, text.isEmpty ? -10 : 0)
            }
        }

    }
}
