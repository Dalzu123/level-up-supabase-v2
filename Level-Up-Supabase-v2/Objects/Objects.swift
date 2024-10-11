//
//  Objects.swift
//  Level-Up-Supabase-v2
//
//  Created by Diego Alzugaray on 10/10/24.
//

import Foundation
import Supabase

struct Muscle: Decodable, Hashable {
    let id: Int
    let name: String
}

struct Workout: Decodable, Hashable {
    let workoutid: Int
    let name: String
    let muscleid: Int
}
