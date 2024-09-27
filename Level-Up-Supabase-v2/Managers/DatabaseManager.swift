//
//  DatabaseManager.swift
//  Level-Up-Supabase-v2
//
//  Created by Diego Alzugaray on 8/18/24.
//

import Foundation
import Supabase

class DatabaseManager {
    
    struct Muscle: Decodable {
        let id: Int
        let name: String
    }
    
    let supabase = SupabaseClient(supabaseURL: URL(string: String("https://wqhizsnuzwwyfsvifqrx.supabase.co"))!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndxaGl6c251end3eWZzdmlmcXJ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjMzNzQ4NzMsImV4cCI6MjAzODk1MDg3M30.AGxFi_2VoMGZzBInq6O2wL-Ky96r8i6bHsrQAG1bJNY")
    
    
    func fetchMuscles() async  {
        do{
            let muscles: [Muscle] = try await supabase.from("muscle").select().execute().value
        }
        catch {print("You suck")}
        
        /*let response = try await supabase.from("muscle").select()
        print(response)
         */
    }
    
}