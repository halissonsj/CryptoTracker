//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 04/06/24.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
        }
    }
}
