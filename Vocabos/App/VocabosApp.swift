//
//  VocabosApp.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 14.09.2023.
//

import SwiftUI

@main
struct VocabosApp: App {
    @State private var showSplash = true
    @StateObject private var userViewModel = UserViewModel()
    @State private var isDarkMode = false // true for dark mode, false for light mode

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation() {
                                self.showSplash = false
                            }
                        }
                    }
            } else {
                ContentView()
                //                   .preferredColorScheme(.light)
                  .environmentObject(userViewModel)
                  .preferredColorScheme(isDarkMode ? .dark : .light)

                //                    .environmentObject(loginViewModel)
                //                    .environmentObject(appTheme)
                //                    .environmentObject(userViewModel)
                //                    .onAppear(perform: appTheme.updateNavigationBarColor)
            }
        }
    }
    
}
