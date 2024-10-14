//
//  Objects.swift
//  Level-Up-Supabase-v2
//
//  Created by Diego Alzugaray on 10/10/24.
//

import Foundation
import Supabase

struct Muscle: Decodable, Hashable {
    var muscleid: Int//= UUID()
    var name: String
}

struct Workout: Decodable, Hashable {
    var workoutid: Int
    var name: String
    var muscleid: Int
}
