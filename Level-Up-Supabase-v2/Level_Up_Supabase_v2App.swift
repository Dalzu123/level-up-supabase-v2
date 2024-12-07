//
//  Level_Up_Supabase_v2App.swift
//  Level-Up-Supabase-v2
//
//  Created by Diego Alzugaray on 8/11/24.
//

import SwiftUI
import Foundation

@main
struct Level_Up_Supabase_v2App: App {
    @StateObject private var authManager = AuthManager()
    
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemGray6
    }
    @State var isAuthenticated = false; 
    var body: some Scene {
       

            WindowGroup {
                if authManager.isLoggedIn {
                TabView {
                    /*LoginScreen()
                        .tabItem {
                            Label("Login", systemImage: "key")
                        }*/
                    
                    New_ST_Workout()
                        .tabItem {
                            Label("Track Workout", systemImage: "plus")
                        }
                    
                    View_Workout_History()
                        .tabItem {
                            Label("View Progress", systemImage: "eye.fill")
                        }
                    Level_Up_Supplements()
                        .tabItem {
                            Label("Vitamins", systemImage: "pills")
                        }
                }
                //ProfileView()
            }
                else {
                    LoginScreen()
                        .environmentObject(authManager)
        }

            
        }
        
    }

}
