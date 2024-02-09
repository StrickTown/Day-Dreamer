import SwiftUI

struct DayDreamerScreen: View {
    @State private var selectedDate: Date = Date() // Default to current date and time
    @State private var timeMessage: String = "" // To display the countdown or time since
    @State private var showTimeDetails: Bool = false // Toggle state for showing or hiding time details
    @State private var showWeeksDetails: Bool = false // Toggle state for showing or hiding week details
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Timer to update every second
    
    var body: some View {
        Color("PrimaryBackground")
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    Toggle(isOn: $showTimeDetails) {
                        Text("Show Hours and Minutes")
                    }
                    .padding()
                    
                    Toggle(isOn: $showWeeksDetails) {
                        Text("Show Weeks")
                    }
                    .padding()
                    
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
            )
    }
    
    func calculateDifference() {
        let calendar = Calendar.current
        var currentDateAtMidnight = calendar.startOfDay(for: Date())
        var selectedDateAtMidnight = selectedDate
        
        if !showTimeDetails {
            selectedDateAtMidnight = calendar.startOfDay(for: selectedDate)
        }
        
        let differenceComponents: Set<Calendar.Component> = showWeeksDetails ? [.year, .month, .weekOfYear, .day, .hour, .minute, .second] : [.year, .month, .day, .hour, .minute, .second]
        let difference = calendar.dateComponents(differenceComponents, from: currentDateAtMidnight, to: selectedDateAtMidnight)
        
        var message = selectedDateAtMidnight > currentDateAtMidnight ? "Time until selected date: " : "Time since selected date: "
        message += "\(abs(difference.year ?? 0)) years, \(abs(difference.month ?? 0)) months"
        
        if showWeeksDetails {
            let weeks = abs(difference.weekOfYear ?? 0)
            message += ", \(weeks) weeks"
        }
        
        let days = abs(difference.day ?? 0)
        message += ", \(days) days"
        
        if showTimeDetails {
            let hours = abs(difference.hour ?? 0)
            let minutes = abs(difference.minute ?? 0)
            let seconds = abs(difference.second ?? 0)
            message += ", \(hours) hours, \(minutes) minutes, \(seconds) seconds."
        }
        
        timeMessage = message
    }
}

struct DayDreamerView_Previews: PreviewProvider {
    static var previews: some View {
        DayDreamerScreen()
    }
}
