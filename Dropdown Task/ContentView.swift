//
//  ContentView.swift
//  Dropdown Task
//
//  Created by Astghik Hakopian on 04.12.23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Private Properties
    
    @State private var selectedOption: DropdownMenuOption? = nil
    
    private let rowsBefore = 14
    private let rowsAfter = 14
    
    
    var body: some View {
        
        ScrollView {
            VStack {
                randomColors(rowsBefore)
                
                // usage
                DropdownMenu(
                    selectedOption: $selectedOption,
                    placeholder: "Select your option",
                    options: DropdownMenuOption.allCases
                )
                .padding()
                
                randomColors(rowsAfter)
            }
        }
    }
}


// MARK: - Components

extension ContentView {
    
    private func randomColors(_ number: Int) -> some View {
        if number > 0 {
            return AnyView(VStack {
                ForEach(0 ..< number, id: \.self) { _ in
                    Color(
                        red: .random(in: 0...1),
                        green: .random(in: 0...1),
                        blue: .random(in: 0...1),
                        opacity: 1
                    )
                    .frame(height: 100)
                }
            })
        } else {
            return AnyView(Spacer())
        }
    }
}


#Preview {
    ContentView()
}
