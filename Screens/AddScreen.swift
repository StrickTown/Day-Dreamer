import SwiftUI

struct AddScreen: View {
    @State private var selectedDate: Date = Date() // Default to current date and time
    @State private var timeMessage: String = "" // To display the countdown or time since
    @State private var showTimeDetails: Bool = false // Toggle state for showing or hiding time details
    @State private var showWeeksDetails: Bool = false // Toggle state for showing or hiding week details
    
    // Timer to update the view every second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Primary Information")) {
                        TextField("Title", text: $title)
                        DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    }
                    
                    Section(header: Text("Details")) {
                        Toggle("Show Hours, Minutes, and Seconds", isOn: $showTimeDetails)
                            .toggleStyle(SwitchToggleStyle(tint: Color("Success")))
                        Toggle("Show Weeks", isOn: $showWeeksDetails)
                            .toggleStyle(SwitchToggleStyle(tint: Color("Success")))
                    }
                    
                }
                
                Button("Add Day", action: printConsole)
                    .frame(width: 350, height: 42, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color("Success"))
                    .cornerRadius(8)
                
                
                
                    .onAppear(perform: calculateDifference)
                    .onReceive(timer) { _ in
                        calculateDifference() // Recalculate difference every second
                    }
                
                Spacer(minLength: 150)
                
                Text(timeMessage)
                //                        .padding()
                
                
            }
            .navigationTitle("Add Day")
            .background(Color("PrimaryBackground"))
        }
               
    }
    
    func printConsole() {
        print("It works!")
    }
    
    func calculateDifference() {
        let calendar = Calendar.current
        let now = Date()
        var components: Set<Calendar.Component> = [.year, .month, .day]
        
        if showWeeksDetails {
            components.insert(.weekOfYear)
        }
        if showTimeDetails {
            components.formUnion([.hour, .minute, .second])
        }
        
        let difference = calendar.dateComponents(components, from: now, to: selectedDate)
        
        var message = selectedDate > now ? "Time until event: " : "Time since event: "
        
        // Construct message
        if let year = difference.year, year != 0 { message += "\(abs(year)) years, " }
        if let month = difference.month, month != 0 { message += "\(abs(month)) months, " }
        if let week = difference.weekOfYear, showWeeksDetails { message += "\(abs(week)) weeks, " }
        
        if let day = difference.day {
            if showWeeksDetails {
                let daysWithoutWeeks = abs(day) % 7
                message += "\(daysWithoutWeeks) days, "
            } else {
                message += "\(abs(day)) days, "
            }
        }
        
        if showTimeDetails {
            if let hour = difference.hour { message += "\(abs(hour)) hours, " }
            if let minute = difference.minute { message += "\(abs(minute)) minutes, " }
            if let second = difference.second { message += "\(abs(second)) seconds, " }
        }
        
        // Remove trailing comma and space
        message = String(message.dropLast(2))
        
        timeMessage = message
    }
}

struct AddScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddScreen()
    }
}
