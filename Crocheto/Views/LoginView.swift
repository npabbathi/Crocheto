//
//  LoginView.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 11/29/23.
//

import SwiftUI

struct LoginView: View {

    @EnvironmentObject var viewModel : AuthViewModel

    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [CrochetoColors.green, CrochetoColors.white], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Text("CROCHETO")
                        .font(.largeTitle)
                        .foregroundColor(CrochetoColors.white)
                        .kerning(6)
                    
                    Image("logo_dark")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                    
                    TextField("Username", text: $email)
                        .padding()
                        .background(CrochetoColors.white)
                        .cornerRadius(20)
                        .padding()
                        .tint(CrochetoColors.brown)
                        .foregroundColor(CrochetoColors.brown)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(CrochetoColors.white)
                        .cornerRadius(20)
                        .padding()
                        .tint(CrochetoColors.brown)
                        .foregroundColor(CrochetoColors.brown)
                    
                    Button {
                        Task {
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    } label: {
                        Text("LOGIN")
                            .kerning(4)
                    }
                    .tint(CrochetoColors.darkGreen)
                    .buttonStyle(.bordered)
                    .cornerRadius(10)
                    
                    NavigationLink("Don't have an account? **Sign up**", destination: SignupView()
                            .navigationBarBackButtonHidden())
                        .tint(CrochetoColors.brown)
                }
                .padding()
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
