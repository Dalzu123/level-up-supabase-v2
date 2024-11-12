//
//  View_Workout_History.swift
//  Level-Up-Supabase-v2
//
//  Created by Diego Alzugaray on 11/7/24.
//

import SwiftUI
import Combine
import Foundation
import Supabase

struct View_Workout_History: View {
    @State private var musclesSelection: String = "Chest"
    @State private var workoutsSelection: String = "Bench Press"
    private var database = DatabaseManager()
    @State private var muscles:[Muscle] = []
    @State private var workouts:[Workout] = []
    @State private var beginDate = Date.now
    @State private var endDate = Date.now

    
    
    
    var body: some View {
        VStack{
            Image("LevelUpBanner")
                .resizable() // Allows the image to be resized
                .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
            //.frame(width: 800, height: 200) // Sets the frame size of the image
                .clipped()
            
            Text("Which muscle do you want to see")
            Picker("Select Muscle", selection: $musclesSelection) {
                // ForEach(muscles, id: \.self) { item in Text(item.name)
                ForEach(muscles, id: \.self) { item in Text(item.name).tag(item.name)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: musclesSelection) {
                print("successful change in muscle Selection")
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .imageScale(.large)
            .accentColor(.black)
            .foregroundColor(.accentColor)
            
            if musclesSelection == "Chest" {
                Text("Which workout?")
                let chestWorkouts = workouts.filter {workout in workout.muscleid == 1 }
                //print(chestWorkouts)
                Picker("Select Workout", selection: $workoutsSelection) {
                    ForEach(chestWorkouts, id: \.self) {
                        item in Text(item.name).tag(item.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.black)
                .onChange(of: workoutsSelection) {
                    print("successful change in workouts Selection")
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
                .imageScale(.large)
                .foregroundColor(.accentColor)
            }
            else if musclesSelection == "Back" {
                Text("Which workout?")
                let backWorkouts = workouts.filter {workout in workout.muscleid == 2 }
                //print(chestWorkouts)
                Picker("Select Workout", selection: $workoutsSelection) {
                    ForEach(backWorkouts, id: \.self) {
                        item in Text(item.name).tag(item.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.black)
                .onChange(of: workoutsSelection) {
                    print("successful change in workouts Selection")
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
                .imageScale(.large)
                .foregroundColor(.accentColor)
            }
            else if musclesSelection == "Legs" {
                Text("Which workout?")
                let legsWorkouts = workouts.filter {workout in workout.muscleid == 3 }
                //print(chestWorkouts)
                Picker("Select Workout", selection: $workoutsSelection) {
                    ForEach(legsWorkouts, id: \.self) {
                        item in Text(item.name).tag(item.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.black)
                .onChange(of: workoutsSelection) {
                    print("successful change in workouts Selection")
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
                .imageScale(.large)
                .foregroundColor(.accentColor)
            }
            else if musclesSelection == "Shoulders" {
                Text("Which workout?")
                let shouldersWorkouts = workouts.filter {workout in workout.muscleid == 4 }
                //print(chestWorkouts)
                Picker("Select Workout", selection: $workoutsSelection) {
                    ForEach(shouldersWorkouts, id: \.self) {
                        item in Text(item.name).tag(item.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.black)
                .onChange(of: workoutsSelection) {
                    print("successful change in workouts Selection")
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
                .imageScale(.large)
                .foregroundColor(.accentColor)
            }
            else if musclesSelection == "Triceps" {
                Text("Which workout?")
                let tricepsWorkouts = workouts.filter {workout in workout.muscleid == 5 }
                //print(chestWorkouts)
                Picker("Select Workout", selection: $workoutsSelection) {
                    ForEach(tricepsWorkouts, id: \.self) {
                        item in Text(item.name).tag(item.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.black)
                .onChange(of: workoutsSelection) {
                    print("successful change in workouts Selection")
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
                .imageScale(.large)
                .foregroundColor(.accentColor)
            }
            else if musclesSelection == "Biceps" {
                Text("Which workout?")
                let bicepsWorkouts = workouts.filter {workout in workout.muscleid == 6 }
                //print(chestWorkouts)
                Picker("Select Workout", selection: $workoutsSelection) {
                    ForEach(bicepsWorkouts, id: \.self) {
                        item in Text(item.name).tag(item.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.black)
                .onChange(of: workoutsSelection) {
                    print("successful change in workouts Selection")
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
                .imageScale(.large)
                .foregroundColor(.accentColor)
            }
            else if musclesSelection == "Abs" {
                Text("Which workout?")
                let absWorkouts = workouts.filter {workout in workout.muscleid == 7 }
                //print(chestWorkouts)
                Picker("Select Workout", selection: $workoutsSelection) {
                    ForEach(absWorkouts, id: \.self) {
                        item in Text(item.name).tag(item.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.black)
                .onChange(of: workoutsSelection) {
                    print("successful change in workouts Selection")
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
                .imageScale(.large)
                .foregroundColor(.accentColor)
            }
            
  //          HStack {
            VStack{
            Text("From:")
                    DatePicker("", selection: $beginDate, displayedComponents: .date)
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 5)
                Text("To:")
                DatePicker("", selection: $endDate,  displayedComponents: .date)
                    .labelsHidden()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 5)
            }

 //           }
            Button("Get Workout History") {
                print(beginDate)
            }
            .padding()
            .background(Color.black)
            .shadow(color: .gray, radius: 3, x: 0, y: 2)
            .border(Color.blue, width: 2)
            
            
            NavigationLink(destination:Feedback())
            {
                Text("Thoughts?")
            }
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 1)
            ).accentColor(.blue)
                .padding(.top, 20)
            
            
        }
        .onAppear{
            Task{
                let response = await database.fetchMuscles()
                muscles = response
                let response2 = await database.fetchWorkouts()
                workouts = response2.compactMap {$0 as? Workout}
                print(muscles)
                print(workouts)
            }

        }
    }
    
}

#Preview {
    View_Workout_History()
}
