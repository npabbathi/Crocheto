//
//  ProfileView.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 11/29/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    var backgroundColor : some View = CrochetoColors.green
    var body: some View {
        let currentUser = viewModel.currentUser
        
            List {
                Section {
                    HStack {
                        Text(currentUser?.initals ?? User.MOCK_USER.initals)
                            .frame(width: 70, height: 70)
                            .background(CrochetoColors.white)
                            .clipShape(Circle())
                            .font(.title)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(currentUser?.fullname.uppercased() ?? User.MOCK_USER.fullname)
                                .font(.title2)
                                .kerning(2)
                            
                            Text(currentUser?.email.lowercased() ?? User.MOCK_USER.email)
                                .font(.caption)
                        }
                    }
                    .padding(10)
                    .foregroundColor(CrochetoColors.brown)
                    
                }
                .listRowBackground(backgroundColor)
                
                Section {
                    Button {
                        viewModel.signOut()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill")
                                .foregroundColor(CrochetoColors.brown)
                            Text("SIGN OUT")
                                .kerning(2)
                                .foregroundColor(CrochetoColors.brown)
                        }
                    }
                    .padding(10)
                    .foregroundColor(CrochetoColors.brown)
                }
                .listRowBackground(backgroundColor)
                
               
            }
            .background(LinearGradient(colors: [CrochetoColors.darkGreen, CrochetoColors.white], startPoint: .topLeading, endPoint: .bottomLeading))
            .scrollContentBackground(.hidden)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}
