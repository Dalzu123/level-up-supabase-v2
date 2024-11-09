//
//  Profile_View.swift
//  Level-Up
//
//  Created by Diego Alzugaray on 5/12/24.
//
import SwiftUI
import Combine
import Foundation

struct ProfileView:View {

    
    var body: some View {
        Image("LevelUpBanner")
             .resizable() // Allows the image to be resized
                         .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
                         //.frame(width: 800, height: 200) // Sets the frame size of the image
                         .clipped()
                         .padding(.top, 80)
        
        NavigationView{

            VStack {
                Text("What are we doing today?")
                    .bold()
                    .padding()
                NavigationLink(destination: Exercise_Prompt()) {
                    Text("Track Workouts")
                    
                }
                
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                NavigationLink(destination: View_Workout_History()) {
                    Text("See Progress")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
             
        }
        
    }
    
}
