//
//  GreetinView.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 27.11.2023.
//

import SwiftUI

struct GreetingView: View {
    @State private var goLogin = false

    var body: some View {
        ZStack{
            Image("greeting_bg")
                .resizable()
                .scaledToFill()
            VStack{
                
                Text("Tüm Dillerin Kelimelerini Tek Bir uygulamadan öğren")
                    .font(.setCustom(fontStyle: .title2, fontWeight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.top,380)
                    .foregroundStyle(Color.black)

                Text("Dilediğiniz dildeki kelimelere seviyeye uygun bir şekilde öğrenebilirsiniz.")
                    .font(.setCustom(fontStyle: .subheadline, fontWeight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.top,20)
                    .foregroundStyle(Color.black)
                
                
                PrimaryButton(buttonText: "Öğrenmeye Başla",action: {
                    goLogin.toggle()
                })
                
                   
                    .padding(.top,20)
            }
            .padding()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .workaroundLink(to: LoginView(showSignInView: .constant(true)), isActive: $goLogin)
    }
}

#Preview {
    GreetingView()
}
