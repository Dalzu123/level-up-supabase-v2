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
let supabase = SupabaseClient(supabaseURL: URL(string: String("https://wqhizsnuzwwyfsvifqrx.supabase.co"))!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndxaGl6c251end3eWZzdmlmcXJ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjMzNzQ4NzMsImV4cCI6MjAzODk1MDg3M30.AGxFi_2VoMGZzBInq6O2wL-Ky96r8i6bHsrQAG1bJNY")

class DatabaseManager {
    
    
    
   
    
    
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
    
    func fetchWorkoutHistory(muscle: String, workout: String, username: String/*, beginDate: Date, endDate: Date*/) async  -> [WorkoutHistory]   {
        do{
            let workoutHistory: [WorkoutHistory] = try await supabase.from("workoutRecords")
                .select("id,workout, sets, reps, muscle, weight, weightMeasurementType, username, created_at")
            //.group("DATE_TRUNC('day', created_at), workout, muscle, username")
                .eq("muscle", value: muscle)
                .eq("workout", value: workout)
                .eq("username", value: username)
                .order("created_at", ascending: false)
                .execute()
                .value
            return workoutHistory
        }
        // catch {print("You suck")}
        catch {print(error)}
        
        /*let response = try await supabase.from("muscle").select()
         print(response)
         */
        return []
    }
        
        /*

         
         
         // The query to look at total weight moved by workout on a daily basis
         
         SELECT

           workout,
           muscle,
           sum(sets * reps * weight) AS Total_Weight,
           username,
           DATE_TRUNC(
         'day'
         , created_at)
         AS
          created_a
         FROM

           "workoutRecords"
           where
          workout = workoutId
          and
           muscle = muscleId
           and username = username
         GROUP
          
         BY

           DATE_TRUNC(
         'day'
         , created_at),
          workout,
           muscle,
           username;
         
         
         // The query to look at total weight moved by muscle on a daily basis
         
         SELECT


           muscle,
           sum(sets * reps * weight) AS Total_Weight,
           username,
           DATE_TRUNC(
         'day'
         , created_at)
         AS
          created_a
         FROM

           "workoutRecords"
           where

           muscle = muscleId
           and username = username
         GROUP
          
         BY

           DATE_TRUNC(
         'day'
         , created_at),
           muscle,
           username;

         */
    
    
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
    
    func insertWorkoutRecords(exerciseType: String, weightMeasurementType: String, muscle: String, workout: String, sets: Int, reps: Int, weight: Double, username: String) {
        Task{
            do {
                let response3 = try await supabase
                    .from("workoutRecords")
                    /*.insert("weightMeasurementType": weightMeasurementType, "muscle": muscle, "workout": workout, "sets": sets, "reps": reps, "weight": weight)
                     */.insert(WorkoutRecord(exerciseType: exerciseType, weightMeasurementType: weightMeasurementType, muscle: muscle, workout: workout, sets: sets, reps: reps, weight: weight, username: username))
                    .execute()
                print("Insert Successful", response3)
            }
            catch {
                print("You kinda suck", error)
            }
        }
    }
    
    func insertCardioWorkout(exerciseType: String, cardioWorkout: String, distanceTraveled: Double, distanceMeasurement: String, timeTraveled: Decimal, username: String) {
        Task{
            do {
                let response4 = try await supabase
                    .from("workoutRecords")
                    /*.insert("weightMeasurementType": weightMeasurementType, "muscle": muscle, "workout": workout, "sets": sets, "reps": reps, "weight": weight)
                     */.insert(CardioRecord(exerciseType: exerciseType, workout: cardioWorkout, distance: distanceTraveled, timeTaken: timeTraveled, distanceMeasurement: distanceMeasurement, username: username))
                    .execute()
                print("Insert Successful", response4)
            }
            catch {
                print("You kinda suck at this shit", error)
            }
        }
    }
    
    func insertFeedback(Feedback: String, Commenter: String) {
        Task{
            do {
                let response4 = try await supabase
                    .from("feedback")
                    /*.insert("weightMeasurementType": weightMeasurementType, "muscle": muscle, "workout": workout, "sets": sets, "reps": reps, "weight": weight)
                     */.insert(feedback(Feedback: Feedback, Commenter: Commenter))
                    .execute()
                print("Insert Successful", response4)
            }
            catch {
                print("You kinda suck at this shit", error)
            }
        }
    }
}
