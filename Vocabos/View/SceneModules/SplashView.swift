//
//  SplashView.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 23.09.2023.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.mainColor
                .opacity(0.2)
            
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 190)
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
