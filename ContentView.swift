import SwiftUI

struct DayDreamerView: View {
    @State private var selectedDate: Date = Date() // Default to current date and time
    @State private var timeMessage: String = "" // To display the countdown or time since
    @State private var showTimeDetails: Bool = false // Toggle state for showing or hiding time details
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Timer to update every second

    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $showTimeDetails) {
                    Text("Show Hours and Minutes")
                }
                .padding()
                .onChange(of: showTimeDetails) { newValue in
                    if !newValue {
                        // If toggle is off, reset hours and minutes to midnight
                        resetTimeToMidnight()
                    }
                }

                DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: showTimeDetails ? [.date, .hourAndMinute] : [.date])
                    .padding()

                Button("Calculate Difference") {
                    calculateDifference()
                }
                .padding()

                Text(timeMessage)
                    .padding()
            }
            .navigationTitle("Day Dreamer")
            .onReceive(timer) { input in
                calculateDifference() // Update timeMessage every second
            }
        }
    }

    func calculateDifference() {
        let calendar = Calendar.current

        // Adjust both currentDate and selectedDate to midnight if showTimeDetails is false
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        var currentDateAtMidnight = calendar.date(from: currentDateComponents)!
        
        var selectedDateAtMidnight = selectedDate
        if !showTimeDetails {
            if let midnight = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: selectedDate) {
                selectedDateAtMidnight = midnight
            }
            // Also adjust the current date to midnight for a fair comparison
            currentDateAtMidnight = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        }
        
        let difference = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentDateAtMidnight, to: selectedDateAtMidnight)
        
        if selectedDateAtMidnight > currentDateAtMidnight {
            // Future date
            let days = difference.day ?? 0
            let hours = difference.hour ?? 0
            let minutes = difference.minute ?? 0
            let seconds = difference.second ?? 0
            
            if showTimeDetails {
                timeMessage = "Time until selected date: \(difference.year ?? 0) years, \(difference.month ?? 0) months, \(days) days, \(hours) hours, \(minutes) minutes, \(seconds) seconds."
            } else {
                timeMessage = "Time until selected date: \(difference.year ?? 0) years, \(difference.month ?? 0) months, \(days) days."
            }
        } else {
            // Past date
            let days = abs(difference.day ?? 0)
            let hours = abs(difference.hour ?? 0)
            let minutes = abs(difference.minute ?? 0)
            let seconds = abs(difference.second ?? 0)
            
            if showTimeDetails {
                timeMessage = "Time since selected date: \(abs(difference.year ?? 0)) years, \(abs(difference.month ?? 0)) months, \(days) days, \(hours) hours, \(minutes) minutes, \(seconds) seconds."
            } else {
                timeMessage = "Time since selected date: \(abs(difference.year ?? 0)) years, \(abs(difference.month ?? 0)) months, \(days) days."
            }
        }
    }


    func resetTimeToMidnight() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        if let newDate = calendar.date(from: components) {
            selectedDate = newDate
        }
    }
}

struct DayDreamerView_Previews: PreviewProvider {
    static var previews: some View {
        DayDreamerView()
    }
}
