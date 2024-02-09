import SwiftUI

struct DayDreamerView: View {
    @State private var selectedDate: Date = Date() // Default to current date and time
    @State private var timeMessage: String = "" // To display the countdown or time since

    var body: some View {
        NavigationView {
            VStack {
                // Date Picker to select date and time
                DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    .padding()

                // Button to trigger countdown or count since functionality
                Button("Calculate Difference") {
                    calculateDifference()
                }
                .padding()

                // Display the countdown or count since
                Text(timeMessage)
                    .padding()
            }
            .navigationTitle("Day Dreamer")
        }
    }

    func calculateDifference() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let difference = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentDate, to: selectedDate)
        
        if selectedDate > currentDate {
            // Future date
            timeMessage = "Time until selected date: \(difference.year ?? 0) years, \(difference.month ?? 0) months, \(difference.day ?? 0) days, \(difference.hour ?? 0) hours, \(difference.minute ?? 0) minutes, \(difference.second ?? 0) seconds."
        } else {
            // Past date
            timeMessage = "Time since selected date: \(abs(difference.year ?? 0)) years, \(abs(difference.month ?? 0)) months, \(abs(difference.day ?? 0)) days, \(abs(difference.hour ?? 0)) hours, \(abs(difference.minute ?? 0)) minutes, \(abs(difference.second ?? 0)) seconds."
        }
    }
}

struct DayDreamerView_Previews: PreviewProvider {
    static var previews: some View {
        DayDreamerView()
    }
}
