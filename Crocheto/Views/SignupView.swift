//
//  SignupView.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 11/29/23.
//

import SwiftUI

struct SignupView: View {
    
    @State var fullname = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var email = ""
    
    @EnvironmentObject var viewModel : AuthViewModel
//    @ObservableObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [CrochetoColors.green, CrochetoColors.darkGreen], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Text("CROCHETO")
                        .font(.largeTitle)
                        .foregroundColor(CrochetoColors.white)
                        .kerning(6)
                    
                    Image("logo_light")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                    
                    VStack {
                        
                        TextField("Email", text: $email)
                            .padding()
                            .background(CrochetoColors.lightGreen)
                            .cornerRadius(20)
                            .tint(CrochetoColors.brown)
                            .foregroundColor(CrochetoColors.brown)
                        
                        TextField("Display Name", text: $fullname)
                            .padding()
                            .background(CrochetoColors.lightGreen)
                            .cornerRadius(20)
                            .tint(CrochetoColors.brown)
                            .foregroundColor(CrochetoColors.brown)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(CrochetoColors.lightGreen)
                            .cornerRadius(20)
                            .tint(CrochetoColors.brown)
                            .foregroundColor(CrochetoColors.brown)
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .background(CrochetoColors.lightGreen)
                            .cornerRadius(20)
                            .tint(CrochetoColors.brown)
                            .foregroundColor(CrochetoColors.brown)
                    }
                    .padding()
                    Button {
                        Task {
                            try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                        }
                    } label: {
                        Text("SIGN UP")
                            .kerning(4)
                    }
                    .tint(CrochetoColors.lightGreen)
                    .buttonStyle(.bordered)
                    .cornerRadius(10)
                    
                    NavigationLink("Already have an account? **Login**", destination: LoginView()
                        .navigationBarBackButtonHidden()
                    )
                        .tint(CrochetoColors.white)
                }
                .padding()
            }
        }
    }
}

extension SignupView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5 && !fullname.isEmpty && password == confirmPassword
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
