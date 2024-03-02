import SwiftUI

struct AddScreen: View {
    @State private var selectedDate: Date = Date() // Default to current date and time
    @State private var timeMessage: String = "" // To display the countdown or time since
    @State private var showTimeDetails: Bool = false // Toggle state for showing or hiding time details
    @State private var showWeeksDetails: Bool = false // Toggle state for showing or hiding week details
    @State private var title: String = ""
    @FocusState private var titleIsFocused: Bool

    
    // Timer to update the view every second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Add Day")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer(minLength: 0)
                    
                    inputFieldsSection
                        .padding(.horizontal)
                    
                    Button("Add Day", action: printConsole)
                        .buttonStyle(PrimaryButtonStyle())
                    
                    Text(timeMessage)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        //        .onAppear(perform: calculateDifference)
        //        .onReceive(timer) { _ in calculateDifference() }
    }
    
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [Color("Secondary"), Color("Primary")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private var inputFieldsSection: some View {
        Group {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.5))
                
                VStack(alignment: .leading) {
                    Text("Title")
                        .font(.headline)
                        .padding(.leading, 15)
                        .padding(.top, 15)
                    ZStack(alignment: .leading) {
                        if title.isEmpty && !titleIsFocused {
                            Text("Title Name")
                                .foregroundColor(.white.opacity(0.6))
                                .padding(.leading, 5) // Ensure this matches the TextField's leading padding
                        }
                        TextField("", text: $title)
                            .focused($titleIsFocused)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(5)
                            .foregroundColor(.black)
                    }
                    .padding(.bottom, 15)
                    .padding(.horizontal, 15)
                    
                    VStack(alignment: .leading) { // Align VStack contents to the leading edge
                        HStack {
                            Text("Select Date and Time")
                                .font(.headline) // Customize the font as needed
                                .padding(.leading) // Add padding to the leading edge to align with the DatePicker
                            Spacer() // Pushes the Text to the left
                        } // HStack ensures the text is aligned left and allows the use of Spacer
                        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                        DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .labelsHidden() // Hide the built-in label
                            .padding() // Adjust padding as necessary
                    }
                    //                    .padding() // Add padding around the VStack if needed for overall alignment
                    
                }
                //                .padding(.horizontal)
            }
            .frame(height: 150)
            
            Spacer(minLength: 20)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.5))
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Show Hours, Minutes, and Seconds")
                            .font(.headline) // Set font to .headline
                            .foregroundColor(.primary) // Set text color
                            .padding(.leading)
                        Spacer() // Pushes the Text to the left
                        Toggle("", isOn: $showTimeDetails)
                            .toggleStyle(SwitchToggleStyle(tint: Color("Success")))
                    }
                    .padding(.vertical, 8) // Adjust padding as necessary
                    
                    HStack {
                        Text("Show Weeks")
                            .font(.headline) // Set font to .headline
                            .foregroundColor(.primary) // Set text color
                            .padding(.leading)
                        Spacer() // Pushes the Text to the left
                        Toggle("", isOn: $showWeeksDetails)
                            .toggleStyle(SwitchToggleStyle(tint: Color("Success")))
                    }
                    .padding(.vertical, 8) // Adjust padding as necessary
                }
                .padding(.trailing, 20)
            }
            .frame(height: 150)
            
        }
    }
    
    func printConsole() {
        calculateDifference()
        print("Button tapped!")
    }
    
    func calculateDifference() {
        // Time calculation logic remains the same
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
        
        if let year = difference.year, year != 0 { message += "\(abs(year)) years, " }
        if let month = difference.month, month != 0 { message += "\(abs(month)) months, " }
        if let weekOfYear = difference.weekOfYear, weekOfYear != 0 && showWeeksDetails { message += "\(abs(weekOfYear)) weeks, " }
        if let day = difference.day, day != 0 { message += "\(abs(day)) days, " }
        if showTimeDetails {
            if let hour = difference.hour { message += "\(abs(hour)) hours, " }
            if let minute = difference.minute { message += "\(abs(minute)) minutes, " }
            if let second = difference.second { message += "\(abs(second)) seconds, " }
        }
        
        message = String(message.dropLast(2)) // Remove the last comma and space
        
        timeMessage = message
    }
}

// Example button style
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color("Primary"))
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct AddScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddScreen()
    }
}
