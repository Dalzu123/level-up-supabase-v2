//
//  Comments.swift
//  Level-Up-Supabase-v2
//
//  Created by Diego Alzugaray on 11/3/24.
//

import SwiftUI
import Combine
import Foundation
import Supabase

struct Feedback: View {
    //@StateObject var apiService = PostWorkoutAPI()
    @State  var id: UUID
    @State  var text: String = "Thoughts?"
    @State  var name: String = ""
    @State var isButtonTapped = false
    @State var database = DatabaseManager()
    

    
    var body: some View {
        ZStack {
            Color("AccentColor")
                .ignoresSafeArea()
            VStack {
                Image("LevelUpBanner")
                    .resizable() // Allows the image to be resized
                    .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
                   // .frame(width: 600, height: 200) // Sets the frame size of the image
                    .clipped()
                 
                Text("Feedback:")
                    .font(.headline)
                
                TextEditor(text: $text)
                    .padding()
                    .background(Color(UIColor.systemGray6)) // For a light background color
                    .cornerRadius(8)
                    .frame(height: 200) // Set a desired height for the TextEditor
                
                    .navigationBarBackButtonHidden(true)
                    .padding()
                Text("Say it with yout chest! Give me a name to cite as the person who made this app better")
                TextField("Name: ", text: $name)
                    .padding(10)
                    .border(Color.black, width: 1)
                    .foregroundColor(.black)
                    
                
                Button("Let me know") {
                    // let feedbackRecord = Feedback(Feedback: text, Commenter: name)
                    
                    
                    database.insertFeedback(Feedback: text, Commenter: name)
                    isButtonTapped = true
                    
                    
                    
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.black, lineWidth: 1)
                )
                .accentColor(Color.black)
                .shadow(color: .black, radius: 3, x: 0, y: 2)
                //border(Color.blue, width: 1)
                
                if isButtonTapped{
                   Text("Successfully logged your feedback")
                }

                
                NavigationLink(destination: New_ST_Workout()) {
                    Text("New Workout")
                }
                .accentColor(.blue)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
                
                //.border(Color.blue, width: 1)
                
            }
            
        }
    }
    
}

    
/*#Preview {
    New_ST_Workout()
}*/
        
        
        


