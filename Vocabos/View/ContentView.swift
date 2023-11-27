//
//  ContentView.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 14.09.2023.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject private var userViewModel : UserViewModel
    
    var body: some View {
        NavigationView{
            if userViewModel.isLogin{
                GreetingView()
            }else{
                GreetingView()
               // LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
