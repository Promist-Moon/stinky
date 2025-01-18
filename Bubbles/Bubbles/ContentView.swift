//
//  ContentView.swift
//  Bubbles
//
//  Created by Bing Hang on 18/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // Add a button
            Button(action: {
                // Action to perform when the button is clicked
                print("Button Clicked!")
            }) {
                // Button appearance
                Text("I have showered!")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
