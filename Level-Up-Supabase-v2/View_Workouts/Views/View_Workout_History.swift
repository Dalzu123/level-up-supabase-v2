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
    @State private var username = ""
    @State private var workoutHistory:[WorkoutHistory] = []
    @State private var cardioWorkoutHistory:[CardioWorkoutHistory] = []
    @State private var showTable = false
    @State private var isActive = false
    @EnvironmentObject var authManager: AuthManager
    @State private var typeOfWorkoutSelected = ""
    @State private var cardioWorkoutsSelection = "Run"
    @State private var cardioTypeSelected = ""
    @State private var typeOfWorkout = ["--Select--","Strength Training","Cardio"]
    let cardioWorkout = ["Run", "Walk", "Ride","Swim", "Stair Stepper"]
    

    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("AccentColor")
                    .ignoresSafeArea()
                VStack{
                    // Color("AccentColor")
                    Image("LevelUpBanner")
                        .resizable() // Allows the image to be resized
                        .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
                    //.frame(width: 800, height: 200) // Sets the frame size of the image
                        .clipped()
                    
                    Text("What kind of workout?")
                    Picker("", selection: $typeOfWorkoutSelected) {
                        ForEach(typeOfWorkout, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .imageScale(.large)
                    .accentColor(.black)
                    .foregroundColor(.accentColor)
                    Divider()
                    //Picklist for muscles
                    if (typeOfWorkoutSelected == "Strength Training") {
                        
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
                    }
                    
                    else if(typeOfWorkoutSelected == "Cardio") {
                        Divider()
                        Text("Workout:")
                            .bold()
                        Picker("Select Exercise", selection: $cardioWorkoutsSelection)
                        {
                            ForEach(cardioWorkout, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                        .imageScale(.large)
                        .accentColor(.black)
                        .foregroundColor(.accentColor)
                    }
                    Divider()
                    //          HStack {
                    VStack{
                       /* TextField("username",text: $username)
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.blue, lineWidth: 1)
                            )*/
                        /*
                         // From and To dates for history
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
                         */}
                    
                    //           }
                    Button("Get Workout History") {
                        if(typeOfWorkoutSelected == "Strength Training") {
                            Task{
                                
                                await    workoutHistory = database.fetchWorkoutHistory(muscle: musclesSelection, workout: workoutsSelection, username: authManager.authenticatedUsername/*, beginDate: beginDate, endDate: endDate*/)
                                print(workoutHistory)
                                showTable = true
                                
                            }
                        } else if (typeOfWorkoutSelected == "Cardio") {
                            Task{
                                await    cardioWorkoutHistory = database.fetcCardioHistory(workout: cardioWorkoutsSelection, username: authManager.authenticatedUsername/*, beginDate: beginDate, endDate: endDate*/)
                                print(cardioWorkoutHistory)
                                showTable = true
                            }
                        }
                    }
                    .padding()
                    .background(Color.black)
                    .shadow(color: .gray, radius: 3, x: 0, y: 2)
                    .border(Color.blue, width: 2)
                    if (showTable == true && typeOfWorkoutSelected == "Strength Training") {
                        List {
                            HStack {
                                //Text("Workout").bold().frame(maxWidth: .infinity, alignment: .leading)
                                Text("Sets").bold().frame(maxWidth: .infinity, alignment: .leading)
                                Text("Reps").bold().frame(maxWidth: .infinity, alignment: .leading)
                                Text("Weight").bold().frame(maxWidth: .infinity, alignment: .leading)
                                Text("Date").bold().frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            
                            ForEach($workoutHistory) { row in
                                HStack {
                                   // Text("\(row.workout.wrappedValue)").frame(maxWidth: .infinity, alignment: .leading)
                                    Text(String(row.sets.wrappedValue)).frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(row.reps.wrappedValue)").frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(row.weight.wrappedValue)").frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(row.created_at.wrappedValue.formatted(.dateTime.year().month().day()))").frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding()
                            }
                            
                        }
                    }
                    else if(showTable == true && typeOfWorkoutSelected == "Cardio") {
                        List {
                            HStack {
                                //Text("Workout").bold().frame(maxWidth: .infinity, alignment: .leading)
                                Text("Distance").bold().frame(maxWidth: .infinity, alignment: .leading)
                                Text("Mi/Km").bold().frame(maxWidth: .infinity, alignment: .leading)
                                Text("Time").bold().frame(maxWidth: .infinity, alignment: .leading)
                                Text("Date added").bold().frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            
                            ForEach($cardioWorkoutHistory) { row in
                                HStack {
                                   //Gives me minutes Integer
                                    let intValue = extractIntegerPart(row.timeTaken.wrappedValue)
                                    
                                    if intValue >= 60 {
                                        //Gives me hours and decimal
                                        // let minValue = Decimal(intValue / 60)
                                        let minValue = Double(intValue) / Double(60)
                                       
                                        //Gives me hours
                                        let hoursValue = Int(floor(Double(intValue) / Double(60)))
                                        //Gives me minutes decimal to multipy by 60 to get minutes
                                        let minDecimalValue = (minValue - (Double(hoursValue)))
                                        //To get minutes
                                        let extraMinutesValue = Int(round((minDecimalValue * 60.0)))
                                        //Give me seconds
                                        let decimalValue = (row.timeTaken.wrappedValue - Decimal(intValue)) * 100
                                        let intDecimalValue = extractIntegerPart(decimalValue)
                                        
                                        //let decimalValue = row.timeTaken.wrappedValue - (Decimal(intValue) as Decimal)
                                        //let floorNumber = floor(Double(intValue)/60)
                                        //Text(String(intValue))
                                        // Text("\(row.workout.wrappedValue)").frame(maxWidth: .infinity, alignment: .leading)
                                        Text(String(row.distance.wrappedValue)).frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(row.distanceMeasurement.wrappedValue)").frame(maxWidth: .infinity, alignment: .leading)
                                        // Text("\(formatDecimal(row.timeTaken.wrappedValue)) (Min.Seconds)").frame(maxWidth: .infinity, alignment: .leading)
                                        //Text("\(floorNumber)").frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(hoursValue)h " + "\(extraMinutesValue)m \(intDecimalValue)s").frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(row.created_at.wrappedValue.formatted(.dateTime.year().month().day()))").frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    else {

                                        let decimalValue = (row.timeTaken.wrappedValue - Decimal(intValue)) * 100
                                        let intDecimalValue = extractIntegerPart(decimalValue)
                                        
                                        //let decimalValue = row.timeTaken.wrappedValue - (Decimal(intValue) as Decimal)
                                        //let floorNumber = floor(Double(intValue)/60)
                                        //Text(String(intValue))
                                        // Text("\(row.workout.wrappedValue)").frame(maxWidth: .infinity, alignment: .leading)
                                        Text(String(row.distance.wrappedValue)).frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(row.distanceMeasurement.wrappedValue)").frame(maxWidth: .infinity, alignment: .leading)
                                        // Text("\(formatDecimal(row.timeTaken.wrappedValue)) (Min.Seconds)").frame(maxWidth: .infinity, alignment: .leading)
                                        //Text("\(floorNumber)").frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(intValue)m \(intDecimalValue)s").frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(row.created_at.wrappedValue.formatted(.dateTime.year().month().day()))").frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .padding()
                            }
                            
                        }
                    }
                    
                   
                    
                    
                    
                    
                    NavigationLink(destination:Feedback())
                    {
                        Text("Thoughts?")
                    }
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.blue, lineWidth: 1)
                    ).accentColor(.blue)
                        .padding(.top, 20)
                }
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
    
}
func formatDecimal(_ value: Decimal) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2 // Limit to 2 decimal places
    return formatter.string(for: value) ?? "N/A"
}
func extractIntegerPart(_ value: Decimal) -> Int {
    // Convert Decimal to NSDecimalNumber and extract the integer value
    return NSDecimalNumber(decimal: value).intValue
}
#Preview {
    View_Workout_History()
}
