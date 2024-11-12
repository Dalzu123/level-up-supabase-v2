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


        
        /* Image("LevelUpBanner")
         .resizable() // Allows the image to be resized
         .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
         //.frame(width: 800, height: 200) // Sets the frame size of the image
         .clipped()
         .padding(.top, 80)*/
        
        NavigationView{
            /* Image("LevelUpBanner")
             .resizable() // Allows the image to be resized
             .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
             //.frame(width: 800, height: 200) // Sets the frame size of the image
             //.clipped()
             //.padding(.top, 80)*/
            VStack {
                
                Image("ProgressLogo1")
                    .resizable() // Allows the image to be resized
                    .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
                    .frame(width: 400, height: 200) // Sets the frame size of the image
                    .clipped()
                Text("Notes: I will add an authentication page to connect your Apple Account to the app. This is a prototype but don't be shy about tearing it up on what's missing! Be the idea that makes this app gets better")
                     .padding()
               /* Text("Notes: I will add an authentication page, a 'Cardio' type of workout, and a profile page that after login will let you select between tracking a workout and viewing your progress of workouts over time. This is a prototype but don't be shy about tearing it up on what's missing! Be the idea that makes this app gets better")
                    .padding()
                */
              /*  Text("What are we doing today?")
                    .bold()
                    .padding()
                NavigationLink(destination: New_ST_Workout()) {
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
                .cornerRadius(10)*/
            }
            
        }
        
    }
    
}
