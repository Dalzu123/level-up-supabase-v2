//
//  Level-Up-Supplements.swift
//  Level-Up-Supabase-v2
//
//  Created by Diego Alzugaray on 11/10/24.
//

import SwiftUI
import Combine
import Foundation
import Supabase

struct Level_Up_Supplements: View {
    var body: some View {
        NavigationView {
        ZStack {
                        Color("AccentColor")
                            .ignoresSafeArea()
            VStack{
                
                Text("If you're looking for vitamins and/or supplements to help you with your goals, click the image below to check out the Level-Up store! It is actually a real store")
                    .padding()
                Link( destination:  URL(string: "http://www.amway.com/myshop/level-up")!) {
                    Image("Level-UpStoreImage")
                        .resizable()
                        .frame(width:150,height: 125)
                    
                    
                    
                    //Link(destination:  URL("www.amway.com/myshop/level-up"), Label: Text("Level-Up Store"))
                }
                
                    NavigationLink(destination:Feedback())
                    {
                        Text("Thoughts?")
                    }
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 1)
                    ).accentColor(.blue)
                        .padding(.top, 20)
                }
          }
        }
        
    }
}

#Preview {
    Level_Up_Supplements()
}
