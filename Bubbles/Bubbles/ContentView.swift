import SwiftUI
import UserNotifications

struct ContentView: View {
    // State to track the timer
    @State private var elapsedTime: Int = 0
    @State private var timer: Timer? = nil
    @State private var showAlert: Bool = false

    // Animation-related states
    @State private var pictureOffset: CGFloat = UIScreen.main.bounds.height // Controls the position of the picture
    @State private var isPictureHidden: Bool = false // Controls the visibility of the picture

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack {
                // Timer display
                VStack {
                    Text("Last Showered")
                        .font(.title2)
                        .foregroundColor(.black)

                    Text(formatTime(elapsedTime))
                        .font(.title)
                        .foregroundColor(.black)
                }

                Spacer()

                // Animated picture
                if !isPictureHidden {
                    Image("Image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width)
                        .offset(y: pictureOffset)
                        .animation(.easeInOut(duration: 4.0), value: pictureOffset)
                }

                Spacer()

                // "I have showered!" button
                Button(action: {
                    resetTimer()
                    startTimer()
                    triggerPictureAnimation()
                }) {
                    Text("I have showered!")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // Navigation link
                NavigationLink(destination: FriendsPage()) {
                    Text("Friends")
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Stinky Stinky!"),
                    message: Text("Take a Shower!"),
                    dismissButton: .default(Text("Ok!")){
                        showAlert = false
                    }
                )
            }
        }
        .onAppear {
            // Request notification permission when the view appears
            requestNotificationPermission()
        }
        .onDisappear {
            timer?.invalidate() // Stop timer when leaving view
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
            
            // Trigger notification when elapsed time exceeds 100 seconds
            if elapsedTime % 10 == 0 {
                triggerNotification()
            }
        }
    }

    private func resetTimer() {
        timer?.invalidate()
        elapsedTime = 0
    }

    // Request permission for notifications
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            if success {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    // Trigger the local notification
    private func triggerNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Stinky Stinky!"
        content.body = "Take a shower!"
        content.sound = .default

        // Trigger notification after a delay (this is optional and can be customized)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }

    // Trigger the animation
    private func triggerPictureAnimation() {
        pictureOffset = UIScreen.main.bounds.height
        isPictureHidden = false

        withAnimation(.easeInOut(duration: 4.0)) {
            pictureOffset = -UIScreen.main.bounds.height
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            isPictureHidden = true
        }
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
