//
//  Objects.swift
//  Level-Up-Supabase-v2
//
//  Created by Diego Alzugaray on 10/10/24.
//

import Foundation
import Supabase

struct Muscle: Decodable, Hashable {
    var id: Int//= UUID()
    var name: String
}

struct Workout: Decodable, Hashable {
    var workoutid: Int
    var name: String
    var muscleid: Int
}

struct WorkoutHistory: Identifiable, Decodable, Hashable {
    var id: Int
    var weightMeasurementType: String
    var muscle: String
    var workout: String
    var sets: Int
    var reps: Int
    var weight: Double
    var username: String
    var created_at: Date
}

struct WorkoutRecord: Encodable {
    var exerciseType: String
    var weightMeasurementType: String
    var muscle: String
    var workout: String
    var sets: Int
    var reps: Int
    var weight: Double
    var username: String
}

struct CardioRecord: Encodable {
    var exerciseType: String
    var workout: String
    var distance: Double
    var timeTaken: Decimal
    var distanceMeasurement: String
    var username: String
}

struct feedback: Encodable, Hashable {
    var Feedback: String
    var Commenter: String
}

struct UserProfile: Encodable, Hashable {
    var userId: UUID
    var email: String?
    var username: String
  //  var password: String
    var firstName: String?
    var lastName: String?
    
}



