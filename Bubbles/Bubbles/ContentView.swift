import SwiftUI
import UserNotifications

struct ContentView: View {
    // State to track the timer
    @State private var elapsedTime: Int = 0
    @State private var timer: Timer? = nil
    @State private var showAlert: Bool = false

    // State to track the current image
    @State private var currentImageIndex: Int = 0
    @State private var images = ["1st", "2nd", "3rd", "4th"]  // Replace with your image names

    // Animation-related states
    @State private var pictureOffset: CGFloat = UIScreen.main.bounds.height // Controls the position of the bubbles
    @State private var isPictureHidden: Bool = false // Controls the visibility of the bubbles

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

                // Dog image
                Image(images[currentImageIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .id(currentImageIndex) // Force SwiftUI to redraw the image when the index changes

                Spacer()

                // "I have showered!" button
                Button(action: {
                    resetTimer()
                    startTimer()
                    resetImage() // Reset the image to the first one
                    triggerPictureAnimation() // Trigger the bubbles animation
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
                    dismissButton: .default(Text("Ok!")) {
                        showAlert = false
                    }
                )
            }

            // Bubbles animation
            if !isPictureHidden {
                Image("Image") // Ensure this matches the name of the bubbles image in the asset folder
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .offset(y: pictureOffset)
                    .animation(.easeInOut(duration: 4.0), value: pictureOffset)
            }
        }
        .onDisappear {
            timer?.invalidate() // Stop timer when leaving view
        }
        .onAppear {
            requestNotificationPermission() // Request notification permission when the view appears
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1

            // Trigger alert and change image every 5 seconds
            if elapsedTime % 5 == 0 {
                showAlert = true
                changeImage() // Change the image when the notification is triggered
            }
        }
    }

    private func resetTimer() {
        timer?.invalidate()
        elapsedTime = 0
    }

    // Change the image to the next one in the list
    private func changeImage() {
        withAnimation {
            currentImageIndex = (currentImageIndex + 1) % images.count // Cycle through the images
        }
    }

    // Reset the image to the default (first image)
    private func resetImage() {
        withAnimation {
            currentImageIndex = 0 // Reset to the first image
        }
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

    // Trigger the bubbles animation
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
