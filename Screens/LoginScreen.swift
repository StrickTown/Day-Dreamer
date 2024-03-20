import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 25)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 25)
                .padding(.top, 10)

            Button(action: {
                // Handle login logic here
                print("Login button tapped")
            }) {
                Text("Login")
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
            }
        }
        .padding(.top, 50)
    }
}

// Preview
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
