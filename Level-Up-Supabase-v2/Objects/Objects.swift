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

struct WorkoutRecord: Encodable {
    var weightMeasurementType: String
    var muscle: String
    var workout: String
    var sets: Int
    var reps: Int
    var weight: Double
}
