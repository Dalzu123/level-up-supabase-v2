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
    @State private var workoutTypeSelection = ""
    @State private var musclesInput: String = "Chest"
    @State private var musclesid: Int = 1
    @State private var workoutsInput: String = ""
    @State private var setsInput1 = ""
    @State private var repsInput1 = ""
    @State private var repsInput2 = ""
    @State private var repsInput3 = ""
    @State private var setsInput: Int = 0
    @State private var repsInput: Int = 0
    @State private var weightInput: Double = 0.0
    @State private var distanceInput: Double = 0.0
    @State private var timeInput = ""
    @State private var selection = "Back"
    @State private var selection1 = "Deadlift"
    @State private var isButtonTapped: Bool = false
    @State private var apiResponse: String = ""
    @State private var weightMeasurementInput = "LB"
    @State private var name = "Frank Sinatra"
    @State private var dropSet = false
    @State private var darkMode = false
    @State private var cardioTypeSelected = ""
    //@State private var cardioTime = ""
    @State private var typeOfWorkoutSelected = ""
    @State private var username = ""
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
    

    
    
    
    let typeOfWorkout = ["--Select--","Traditional", "Super Set", "Drop Set"]
    
    


    
    //let sets = ["1","2","3","4","5","6"]
    let sets = Array(1...6)
    let reps = Array(1...20)
    
    let backWorkouts = ["Deadlift",
                        "Chin Up",
                        "Lat pull down cable",
                        "Bent over row",
                        "ISO row wide",
                        "T bar row","Wide pull up",
                        "RDL",
                        "Lat pull down machine",
                        "In bent over row",
                        "DB Bench row",
                        "Face pulls",
                        "Cable low row",
                        "Rear delts"]
    
    let legWorkouts = ["Squat",
                       "Lunge",
                       "Hip raise",
                       "Calf","Goblet Squat",
                       "Leg press",
                       "Leg extension",
                       "Quad curl",
                       "Hip abductor out",
                       "Hip abductor in"]
    
    let shoulderWorkouts = ["barbell Shoulder Press",
                            "Upright BB row",
                            "Trap shrug",
                            "Dumbbell lateral raise",
                            "Dumbbell forward raise", "Twist DB Shoulder press",
                            "Cable lateral raise",
                            "Machine Lateral raise",
                            "Plates raise/DB raise",
                            "Iso shoulder press"]
    let bicepWorkouts = ["Bar bicep curl",
                         "Rope Hammer curl",
                         "Incline Curl",
                         "Preacher curls","Dumbbell curl",
                         "Reverse curl",
                         "Bicep machine",
                         "Cable Curl",
                         "Concentration Curl",
                         "Drag Curl"]
    
    let chestWorkouts = ["Bench",
                         "Incline bench",
                         "Decline bench",
                         "Flyes/rear delt machine","DB bench",
                         "Incline iso press",
                         "Decline machine",
                         "Db Flye",
                         "Incline DB Flye",
                         "Cable Crossover"]
    
    let tricepWorkouts = ["Dip",
                          "Close grip bench",
                          "Seated overhead DB extension",
                          "Skullcrushers","Dips machine",
                          "Tricep machine",
                          "Cable push downs",
                          "Cable Overhead extension",
                          "Double DB extension laying down",
                          "Sideways cable extensión"]
    
    let abWorkouts = ["Crunches","Leg raise",
                      "Russian twist",
                      "Mountain climber",
                      "Seated in and outs",
                      "Deadman hang leg up",
                      "Crucifix",
                      "Star crunches",
                      "Plank",
                      "Side plank reach through",
                      "Bicycle"]
    
    let weightMeasurement = ["Lbs","Kg"]
    var body: some View {
        //@State private var typeOfWorkoutSelected = ""
        NavigationView {
            VStack {
                
                //Picklist for muscles
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
                    TextField("Weight", text: Binding(
                        get: { "" },
                        set: {
                            if let newValue = Double($0) {
                                weightInput = newValue
                            }
                        }
                    ))
                    .padding()
                    // }
                    //Weight measurement picklist
                    Text("Lbs or KGs?" )
                        .padding(.top,10)
                    Picker("Select Weight Measurement", selection: $weightMeasurementInput) {
                        ForEach(weightMeasurement, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    //.padding()
                }
                Text("Email (Will become Username)")
                TextField("Email", text: $username)
                //Submit workout via API call
                Button("Submit Workout") {
                    let workoutrecord = WorkoutRecord(weightMeasurementType: weightMeasurementInput, muscle: musclesInput, workout: workoutsInput, sets: setsInput, reps: repsInput, weight: weightInput)
                    isButtonTapped = true
                    print("It tapped b")
                    print(workoutrecord)
                    /*
                     
                     - Figure out how to have the button tap run an async job
                     - Figure out why I cannot pass workoutrecord to my insert function in DatabaseManager
                     - See if I'm overdoing the constructor as inserting the varable removed the error. Could be because the variable is assigned in the same class as the insert call
                     */
                    
                    /*
                     do {
                     let response3 = try await supabase
                     .from("workoutRecords")
                     /*.insert("weightMeasurementType": weightMeasurementType, "muscle": muscle, "workout": workout, "sets": sets, "reps": reps, "weight": weight)
                      OR
                      */.insert(workoutrecord)
                     .execute()
                     print("Insert Successful", response3)
                     }
                     catch {
                     print("You kinda suck", error)
                     }
                     }*/
                }
                .padding()
                .background(Color.black)
                .shadow(color: .gray, radius: 3, x: 0, y: 2)
                .border(Color.blue, width: 2)

                
                /* if let responseData = apiService.responseData {
                 // Display data from the API response
                 }*/
                
                if isButtonTapped{
                    /*let workoutrecord = WorkoutRecord(weightMeasurementType: weightMeasurementInput, muscle: musclesInput, workout: workoutsInput, sets: setsInput, reps: repsInput, weight: weightInput)
                    */
                   /* let workoutrecord = WorkoutRecord(weightMeasurementType: weightMeasurementInput,muscle: musclesInput, workout: workoutsInput,sets: setsInput, reps: repsInput, weight: weightInput)*/
                    //reply4 = DatabaseManager.insertWorkoutRecords(workoutrecord)
                    /*Text("Muscle: \(musclesInput),Workout: \(workoutsInput), Sets: \(setsInput), Reps: \(repsInput), Weight: \(weightInput)")
                     .font(.title)
                     .padding()
                     */
                    if($setsInput.wrappedValue > 0 && $repsInput.wrappedValue > 0 && $weightInput.wrappedValue > 0.0){
                        let results3 = (Double($setsInput.wrappedValue) * Double($repsInput.wrappedValue) * $weightInput.wrappedValue)
                        
                        Text("Weight moved this Workout \(String(format: "%.2f", results3)) \(weightMeasurementInput)")
                    }
                    
                }
                
                
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

    
#Preview {
    New_ST_Workout()
}
        
        
        

