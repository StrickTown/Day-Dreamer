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
        
        ZStack {
            LinearGradient(
                colors: [Color("Secondary"),Color("Primary")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            // Gloss Background....
            GeometryReader{proxy in
                
                let size = proxy.size
                
                // Slighlty Darkening ...
                Color.black
                    .opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                
                Circle()
                    .fill(Color("Accent"))
                    .padding(50)
                    .blur(radius: 120)
                // Moving Top...
                    .offset(x: -size.width / 1.8, y: -size.height / 5)
                
                Circle()
                    .fill(Color("Primary"))
                    .padding(50)
                    .blur(radius: 150)
                // Moving Top...
                    .offset(x: size.width / 1.8, y: -size.height / 2)
                
                
                Circle()
                    .fill(Color("Secondary"))
                    .padding(50)
                    .blur(radius: 90)
                // Moving Top...
                    .offset(x: size.width / 1.8, y: size.height / 2)
                
                // Adding Purple on both botom ends...
                
                Circle()
                    .fill(Color("Accent"))
                    .padding(100)
                    .blur(radius: 110)
                // Moving Top...
                    .offset(x: size.width / 1.8, y: size.height / 2)
                
                Circle()
                    .fill(Color("Secondary"))
                    .padding(100)
                    .blur(radius: 110)
                // Moving Top...
                    .offset(x: -size.width / 1.8, y: size.height / 2)
            }
                VStack(spacing: 10) {
                    //                    .scrollContentBackground(.hidden)
                    //                    .scrollDisabled(true)
                    Text("Add Day")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white) // Set the background color of the RoundedRectangle
                            .opacity(0.2)
                            .frame(width: 390, height: 150)
                        
                        VStack {
                            HStack {
                                Text("Title")
                                    .font(.headline)
                                    .padding(.leading, 20)
                                Spacer()
                                TextField("Title Name", text: $title)
                                    .frame(width: 260, height: 30)
                            }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 30))
                            
                            HStack {
                                DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                                    .padding()
                            }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 15))
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white) // Set the background color of the RoundedRectangle
                            .opacity(0.2)
                            .frame(width: 390, height: 150)
                        
                        VStack {
                            HStack {
                                Toggle("Show Hours, Minutes, and Seconds", isOn: $showTimeDetails)
                                    .toggleStyle(SwitchToggleStyle(tint: Color("Success")))
                            }
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                            
                            HStack {
                                Toggle("Show Weeks", isOn: $showWeeksDetails)
                                    .toggleStyle(SwitchToggleStyle(tint: Color("Success")))
                            }
                            .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
                            
                        }
                    }
                    .padding(.bottom, 80)
                    
                    
                    Button("Add Day", action: printConsole)
                        .frame(width: 350, height: 42, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color("Primary"))
                        .border(Color.gray, width: 2)
                        .cornerRadius(8)
                    
                    
                    
                        .onAppear(perform: calculateDifference)
                        .onReceive(timer) { _ in
                            calculateDifference() // Recalculate difference every second
                        }
                    Text(timeMessage)
                    //                    Spacer(minLength: 150)
                    
                    
                    //                Spacer(minLength: 50)
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .navigationTitle("Add Day")
                .background(Color.clear)
            
        }
        
        
    }
    
    func printConsole() {
        print("It works!")
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
