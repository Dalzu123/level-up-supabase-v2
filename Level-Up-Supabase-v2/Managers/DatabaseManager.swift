//
//  DatabaseManager.swift
//  Level-Up-Supabase-v2
//
//  Created by Diego Alzugaray on 8/18/24.
//

import Foundation
import Supabase

/*struct Muscle: Decodable, Hashable {
    let id: Int
    let name: String
}

struct Workout: Decodable, Hashable {
    let workoutid: Int
    let name: String
    let muscleid: Int
}*/

class DatabaseManager {
    
    
    
    let supabase = SupabaseClient(supabaseURL: URL(string: String("https://wqhizsnuzwwyfsvifqrx.supabase.co"))!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndxaGl6c251end3eWZzdmlmcXJ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjMzNzQ4NzMsImV4cCI6MjAzODk1MDg3M30.AGxFi_2VoMGZzBInq6O2wL-Ky96r8i6bHsrQAG1bJNY")
    
    
    func fetchMuscles() async  -> [Muscle]   {
        do{
            let muscles: [Muscle] = try await supabase.from("muscle").select().execute().value
            return muscles
        }
        // catch {print("You suck")}
        catch {print(error)}
        
        /*let response = try await supabase.from("muscle").select()
         print(response)
         */
        return []
    }
    
    func fetchWorkouts() async  -> [Any]   {
        do{
            let workouts: [Workout] = try await supabase.from("workout").select().execute().value
            return workouts
        }
        catch {print("You suck")}
        
        /*let response = try await supabase.from("muscle").select()
         print(response)
         */
        return []
    }
    
    func insertWorkoutRecords(weightMeasurementType: String, muscle: String, workout: String, sets: Int, reps: Int, weight: Double) {
        Task{
            do {
                let response3 = try await supabase
                    .from("workoutRecords")
                    /*.insert("weightMeasurementType": weightMeasurementType, "muscle": muscle, "workout": workout, "sets": sets, "reps": reps, "weight": weight)
                     */.insert(WorkoutRecord(weightMeasurementType: weightMeasurementType, muscle: muscle, workout: workout, sets: sets, reps: reps, weight: weight))
                    .execute()
                print("Insert Successful", response3)
            }
            catch {
                print("You kinda suck", error)
            }
        }
    }
}
