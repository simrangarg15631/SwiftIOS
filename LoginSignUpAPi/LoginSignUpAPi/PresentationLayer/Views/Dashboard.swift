//
//  Dashboard.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 02/05/23.
//

import SwiftUI

struct Dashboard: View {
    
    @StateObject var vm: ContentViewModel
    
    var body: some View {
        VStack{
            
            Text(Key.String.dashboard)
                .padding(10)
                .font(.title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
            
            Text("\(Key.String.welcome) \(vm.userData.status.data.firstName)")
                .font(.title2)
                .bold()
                .padding(.vertical, 20)
            
            //MARK: Image
            if let imageUrl = vm.userData.imageUrl{
                AsyncImage(url: imageUrl){ phase in
                    if let image = phase.image{
                        // Image from Api
                        image
                            .resizable()
                            .frame(width:150, height: 150)
                            .clipShape(Circle())
                            .padding(.top, 15)
                        
                    }else{
                        //Activity Indicator Till the icon is loading show
                        ProgressView()
                            .frame(width:150, height: 150)
                    }
                }
            }
            
            //MARK: Details
            VStack(alignment: .leading){
                Text("\(Key.String.firstName) : \(vm.userData.status.data.firstName)")
                Divider()
                Text("\(Key.String.lastName) : \(vm.userData.status.data.lastName)")
                
                Divider()
                Text("\(Key.String.age) : \(vm.userData.status.data.age)")
                
                Divider()
                Text("\(Key.String.gender) : \(vm.userData.status.data.gender)")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            //MARK: LogOut Button
            
            Button{
                vm.signOut()
            }label:{
                ButtonLabelView(label: Key.String.logOut)
            }
            .padding()
            //MARK: Alert
            .alert(Key.String.error, isPresented: $vm.showAlert, actions: {
                Button(role: .cancel, action: {}, label: {
                    Text(Key.String.ok)
                })
            }, message: {
                Text(vm.errorMessage)
            })
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Dashboard(vm: ContentViewModel())
        }
    }
}
