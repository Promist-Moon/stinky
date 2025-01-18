//
//  ContentView.swift
//  Bubbles
//
//  Created by Bing Hang on 18/1/25.
//

import SwiftUI

struct ContentView: View {
    // State to track the timer
    @State private var elapsedTime: Int = 0
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            // Background color
            Color.blue
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Timer display with "Last Showered" label
                HStack {
                    Text("Last Showered:")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text(formatTime(elapsedTime))
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding()

                Spacer()

                // Button to reset and start the timer
                Button(action: {
                    resetTimer()
                    startTimer()
                }) {
                    Text("I have showered!")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }

                Spacer()
                
                // Button to friends
                NavigationLink(destination: FriendsPage()) {
                    Text("Friends")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.pink)
                        .cornerRadius(10)
                }
                
            }
            
        }
    }

    // Start the timer
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
        }
    }

    // Reset the timer
    private func resetTimer() {
        timer?.invalidate()
        elapsedTime = 0
    }

    // Format elapsed time into days, hours, minutes, and seconds
    private func formatTime(_ seconds: Int) -> String {
        let days = seconds / (24 * 3600)
        let hours = (seconds % (24 * 3600)) / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60

        return String(format: "%02d:%02d:%02d:%02d", days, hours, minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
