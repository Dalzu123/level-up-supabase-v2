//
//  New_Workout.swift
//  Level-Up
//
//  Created by Diego Alzugaray on 5/12/24.
//SSH Key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF4tAicH9xqeg0iOxoY4Ru9rga0JJFegFD/xDSPl/uSB
//
import SwiftUI
import Combine
import Foundation
import Supabase



struct New_ST_Workout: View {
    //@StateObject var apiService = PostWorkoutAPI()
    //@State private var workoutTypeSelection = "Bench Press"
    @State private var musclesInput: String = "Chest"
    @State private var musclesid: Int = 1
    @State private var workoutsInput: String = "Bench Press"
    @State private var setsInput1 = ""
    @State private var repsInput1 = ""
    @State private var repsInput2 = ""
    @State private var repsInput3 = ""
    @State private var setsInput: Int = 1
    @State private var repsInput: Int = 1
    @State private var weightInput: Double = 0.0
    @State private var distanceInput: Double = 0.0
    @State private var timeInput = ""
    @State private var selection = "Back"
    @State private var selection1 = "Deadlift"
    @State private var isButtonTapped: Bool = false
    @State private var apiResponse: String = ""
    @State private var weightMeasurementInput = "Lbs"
    @State private var name = "Frank Sinatra"
    @State private var dropSet = false
    @State private var darkMode = false
    @State private var cardioTypeSelected = ""
    //@State private var cardioTime = ""
    @State private var typeOfWorkout = ["--Select--","Strength Training","Cardio"]
    @State private var typeOfWorkoutSelected = ""
    @State private var username = ""
    @State private var cardioWorkoutsSelection = ""
    let cardioWorkout = ["Run", "Walk", "Ride","Swim", "Stair Stepper"]
    @State private var cardioTime = Date()
    @State private var currentDate: Date?
    @State var decimalSeconds: Decimal = 0.00
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var miles: Int = 0
    @State var milesDecimal: Double = 0.0
    @State var milesDecimalCount = [".0",".1", ".2", ".3", ".4", ".5", ".6", ".7", ".8",".9"]
    @State var distanceMeasurement = "mi"
    @State var distanceType = ["mi", "km"]
    @State var isActive = false
    //@State private var workouts = []
    private var database = DatabaseManager()
    /*struct Muscle: Decodable, Hashable {
        let id: Int
        let name: String
    }*/
    
    //@State private var muscles = ["Chest","Back"]
    //@State private var workouts = ["Bench Press", "Deadlift"]
    @State private var muscles:[Muscle] = []
    @State private var workouts:[Workout] = []
    // Creating the connection to supabase
    let supabase = SupabaseClient(supabaseURL: URL(string: String("https://wqhizsnuzwwyfsvifqrx.supabase.co"))!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndxaGl6c251end3eWZzdmlmcXJ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjMzNzQ4NzMsImV4cCI6MjAzODk1MDg3M30.AGxFi_2VoMGZzBInq6O2wL-Ky96r8i6bHsrQAG1bJNY")
    

    
    
    


    
    //let sets = ["1","2","3","4","5","6"]
    let sets = Array(1...6)
    let reps = Array(1...20)

    let weightMeasurement = ["Lbs","Kgs"]
    var body: some View {
        //@State private var typeOfWorkoutSelected = ""
        NavigationView {
            ZStack {
                Color("AccentColor")
                    .ignoresSafeArea()
                VStack {
                    Image("LevelUpBanner")
                        .resizable() // Allows the image to be resized
                        .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
                    //.frame(width: 800, height: 200) // Sets the frame size of the image
                        .clipped()
                        .padding()
                    //Picklist for type of Workout?
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
                    //Picklist for muscles
                    if (typeOfWorkoutSelected == "Strength Training") {
                        Divider()
                        Text("Which muscle?")
                        Picker("Select Muscle", selection: $musclesInput) {
                            // ForEach(muscles, id: \.self) { item in Text(item.name)
                            ForEach(muscles, id: \.self) { item in Text(item.name).tag(item.name)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: musclesInput) {
                            print("successful change in muscle input")
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                        .imageScale(.large)
                        .accentColor(.black)
                        .foregroundColor(.accentColor)
                        
                        // Picklist for workouts
                        //  let musclesInput = "Chest"
                        if musclesInput == "Chest" {
                            Text("Which workout?")
                            let chestWorkouts = workouts.filter {workout in workout.muscleid == 1 }
                            //print(chestWorkouts)
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(chestWorkouts, id: \.self) {
                                    item in Text(item.name).tag(item.name)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(.black)
                            .onChange(of: workoutsInput) {
                                print("successful change in workouts input")
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        }
                        else if musclesInput == "Back" {
                            Text("Which workout?")
                            let backWorkouts = workouts.filter {workout in workout.muscleid == 2 }
                            //print(chestWorkouts)
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(backWorkouts, id: \.self) {
                                    item in Text(item.name).tag(item.name)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(.black)
                            .onChange(of: workoutsInput) {
                                print("successful change in workouts input")
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        }
                        else if musclesInput == "Legs" {
                            Text("Which workout?")
                            let legsWorkouts = workouts.filter {workout in workout.muscleid == 3 }
                            //print(chestWorkouts)
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(legsWorkouts, id: \.self) {
                                    item in Text(item.name).tag(item.name)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(.black)
                            .onChange(of: workoutsInput) {
                                print("successful change in workouts input")
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        }
                        else if musclesInput == "Shoulders" {
                            Text("Which workout?")
                            let shouldersWorkouts = workouts.filter {workout in workout.muscleid == 4 }
                            //print(chestWorkouts)
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(shouldersWorkouts, id: \.self) {
                                    item in Text(item.name).tag(item.name)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(.black)
                            .onChange(of: workoutsInput) {
                                print("successful change in workouts input")
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        }
                        else if musclesInput == "Triceps" {
                            Text("Which workout?")
                            let tricepsWorkouts = workouts.filter {workout in workout.muscleid == 5 }
                            //print(chestWorkouts)
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(tricepsWorkouts, id: \.self) {
                                    item in Text(item.name).tag(item.name)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(.black)
                            .onChange(of: workoutsInput) {
                                print("successful change in workouts input")
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        }
                        else if musclesInput == "Biceps" {
                            Text("Which workout?")
                            let bicepsWorkouts = workouts.filter {workout in workout.muscleid == 6 }
                            //print(chestWorkouts)
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(bicepsWorkouts, id: \.self) {
                                    item in Text(item.name).tag(item.name)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(.black)
                            .onChange(of: workoutsInput) {
                                print("successful change in workouts input")
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        }
                        else if musclesInput == "Abs" {
                            Text("Which workout?")
                            let absWorkouts = workouts.filter {workout in workout.muscleid == 7 }
                            //print(chestWorkouts)
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(absWorkouts, id: \.self) {
                                    item in Text(item.name).tag(item.name)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(.black)
                            .onChange(of: workoutsInput) {
                                print("successful change in workouts input")
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        }
                        
                        //Sets textbox
                        // let workoutsInput = "Bench Press"
                        HStack {
                            Text("Sets")
                                .foregroundColor(.blue) // Customize label color if needed
                                .font(.headline)
                            Picker("", selection: $setsInput) {
                                ForEach(sets, id: \.self) {
                                    sets in
                                    Text("\(sets)")
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .padding()
                            // } ( Removing the end of the HStack )
                            
                            //Reps textbox
                            //HStack { ( Removing the beginning of this HStack )
                            Text("Reps")
                                .foregroundColor(.blue) // Customize label color if needed
                                .font(.headline)
                            Picker("", selection: $repsInput) {
                                ForEach(reps, id: \.self) {
                                    reps in
                                    Text("\(reps)")
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .padding()
                        }
                        
                        //Weight checkbox
                        HStack {
                            Text("Weight")
                                .foregroundColor(.blue) // Customize label color if needed
                                .font(.headline)
                            TextField("", text: Binding(
                                get: { String(weightInput) },
                                set: { weightInput = Double($0) ?? 0.0
                                    /*if let newValue = Double($0) {
                                     weightInput = newValue
                                     }*/
                                }
                            ))
                            .frame(width: 50)
                            .padding(3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            
                            // }
                            //Weight measurement picklist
                            Text("Lbs or KGs?" )
                                .padding(.top,10)
                                .padding(.leading, 30)
                            Picker("Select Weight Measurement", selection: $weightMeasurementInput) {
                                ForEach(weightMeasurement, id: \.self) {
                                    Text($0)
                                }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .accentColor(.black)
                            .pickerStyle(.menu)
                            //.padding()
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
                        VStack {
                            VStack {
                            Text("Distance:")
                                .bold()
                            
                                HStack {
                                    Picker("", selection: $miles){
                                        ForEach(0..<27, id: \.self) { i in
                                            Text("\(i)")
                                        }
                                    }.pickerStyle(WheelPickerStyle())
                                    Picker("", selection: $milesDecimal){
                                        ForEach(Array(stride(from: 0.0, to: 1.0, by: 0.05)), id: \.self) { i in
                                            Text("\(String(format: "%.2f",i))").tag(i)
                                        }
                                    }.pickerStyle(WheelPickerStyle())
                                    Picker("", selection: $distanceMeasurement){
                                        ForEach(distanceType, id: \.self) {
                                            Text($0)
                                        }
                                    }.pickerStyle(WheelPickerStyle())
                                }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.black, lineWidth: 1)
                                )//.padding(.horizontal)
                            VStack {
                                //Text("Time:")
                                //    .bold()
                                    //.padding()
                                HStack {
                                    Text("Hours").bold().frame(maxWidth: .infinity, alignment: .leading)
                                    Text("Minutes").bold().frame(maxWidth: .infinity, alignment: .leading)
                                    Text("Seconds").bold().frame(maxWidth: .infinity, alignment: .leading)
                                }
                                HStack {
                                    Picker("Hours", selection: $hours){
                                        ForEach(0..<27, id: \.self) { i in
                                            Text("\(i)").tag(i)
                                        }
                                    }.pickerStyle(WheelPickerStyle())
                                        //.frame(maxWidth: .infinity, alignment: .leading)
                                    Picker("Minutes", selection: $minutes){
                                        ForEach(0..<60, id: \.self) { i in
                                            Text("\(i)").tag(i)
                                        }
                                    }.pickerStyle(WheelPickerStyle())
                                        //.frame(maxWidth: .infinity, alignment: .leading)
                                    Picker("Seconds", selection: $seconds){
                                        ForEach(0..<60, id: \.self) { i in
                                            Text("\(i)").tag(i)
                                        }
                                    }.pickerStyle(WheelPickerStyle())
                                       //.frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.black, lineWidth: 1)
                            )//.padding(.horizontal)
                        }
                    }
                    
                    if(typeOfWorkoutSelected == "--Select--" || typeOfWorkoutSelected == "") {
                        
                    }
                    else{
                        // .border(Color.black, width:1)
                       // Text("Email (Will become Username)")
                        TextField("Email (Will become Username)", text: $username)
                            .padding(5)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                        
                        //Submit workout via API call
                        Button("Submit Workout") {
                            
                            if(typeOfWorkoutSelected == "Strength Training"){
                                
                                let workoutrecord = WorkoutRecord(exerciseType: typeOfWorkoutSelected, weightMeasurementType: weightMeasurementInput, muscle: musclesInput, workout: workoutsInput, sets: setsInput, reps: repsInput, weight: weightInput, username: username)
                                isButtonTapped = true
                                print("It tapped b")
                                print(workoutrecord)
                                
                                database.insertWorkoutRecords(exerciseType: typeOfWorkoutSelected, weightMeasurementType: weightMeasurementInput, muscle: musclesInput,workout: workoutsInput, sets: setsInput, reps: repsInput, weight: weightInput, username: username)
                                
                            }
                            else if (typeOfWorkoutSelected == "Cardio") {
                                let totalDistance = Double(miles) + milesDecimal
                                      decimalSeconds = (Decimal(seconds)/Decimal(100))
                                    print (decimalSeconds)
                                isButtonTapped = true
  
                                print(totalDistance,distanceMeasurement)
                                print(hours,minutes,seconds)
                                let totalTime = ((Decimal(hours) * Decimal(60)) + Decimal(minutes) + decimalSeconds)
                                
                                database.insertCardioWorkout(exerciseType: typeOfWorkoutSelected, cardioWorkout: cardioWorkoutsSelection, distanceTraveled: totalDistance, distanceMeasurement: distanceMeasurement, timeTraveled: totalTime, username: username)

                            }
                            
                        }
                        .padding()
                        .background(Color.black)
                        .shadow(color: .gray, radius: 3, x: 0, y: 2)
                        .border(Color.blue, width: 2)
                        
                        
                    }
                
                /* if let responseData = apiService.responseData {
                 // Display data from the API response
                 }*/
                
                if isButtonTapped{
                   Text("Successfully logged your workout")
                }

                    NavigationLink(destination:Feedback(id: UUID()))
                    {
                        Text("Thoughts?")
                    }
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 1)
                    ).accentColor(.blue)
                        .padding(.top, 20)
                
                
                

                
                
            }.onAppear{
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
    

}

    
/*#Preview {
    New_ST_Workout()
}*/
        
        
        

