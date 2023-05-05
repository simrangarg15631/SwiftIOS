//
//  ContentView.swift
//  LocalizationTask
//
//  Created by Saheem Hussain on 29/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.layoutDirection) var direction
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
//    @State private var selectedDate = Date()
    @State private var selectedHeight: String = ""
    
    @State private var isOn = false
    
    
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                //Profile Photo
                ZStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 100, height:100)
                    
                    Image(systemName: "camera.circle")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 40 , height: 40)
                        .background(Color.orange)
                        .cornerRadius(20)
                        .background(Circle().stroke(.white, lineWidth:2))
                        .offset(CGSize(width: 40, height: 40))
                }
                
                VStack(alignment:.leading, spacing: 30){
                    
                    //First Name
                    VStack(alignment:.leading){
                        Text("First Name".localized(language) + "*")
                            .font(.subheadline)
                        TextField("Enter name".localized(language), text: $firstName)
                            .padding(12)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                            .padding(.horizontal, 5)
                    }
                    
                    //Last Name
                    VStack(alignment:.leading){
                        Text("Last Name".localized(language) + "*")
                            .font(.subheadline)
                        TextField("Enter name".localized(language), text: $lastName)
                            .padding(12)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                            .padding(.horizontal, 5)
                    }
                    
                    //Date of birth
                    VStack(alignment:.leading){
                        
                        Text("Date of Birth".localized(language) + "*")
                            .font(.subheadline)
                        
                        HStack{
                            Text("Select".localized(language))
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Button{
                                print("")
                            } label:{
                                Image(systemName: "calendar")
                                    .foregroundColor(.black)
                            }
            
                        }
                        .padding(12)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(color:Color.gray, radius:1)
                        .padding(.horizontal, 5)
//
//                        DatePicker("Select".localized(language), selection: $selectedDate, displayedComponents: .date)
//                            .padding(12)
//                            .background(.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 1)
//                            .padding(.horizontal, 5)
                        
                        HStack{
                            Image(systemName: "info.circle")
                            Text("Minimum age allowed is 18 years old".localized(language))
                        }
                        .padding(.top, 5)
                        .font(.caption)
                        .foregroundColor(.red)
                    }
                    
                    //Height
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .bottom){
                            
                            Text("Height".localized(language) + "*")
                                .font(.subheadline)
                            
                            Spacer()
                            
                            //Segmented Picker
                            Segmented_Picker()
                        }
                        
                        MenuView()
                        
                        HStack{
                            Text ("*")
                                .font(.largeTitle)
                            Text("You will be asked to log your weight as soon as your challenge is started".localized(language))
                                .font(.subheadline)
                        }
                        .padding(.top, 10)
                        .foregroundColor(.gray)
                        
                    }
                    .padding(.top, 10)
                    
                    //Gender
                    VStack(alignment:.leading){
                        Text("Gender".localized(language) + "*")
                            .font(.subheadline)
                        
                        MenuView(btn1: "Male", btn2: "Female")
                        
                        //CheckBox
                        Toggle(isOn: $isOn) {
                            Text("Hide my weight from other members".localized(language))
                                .foregroundColor(Color.gray)
                                .font(.subheadline)
                        }
                        .toggleStyle(iOSCheckboxToggleStyle())
                        .padding(10)
                    }
                    
                    //Sync Better Together with
                    VStack(alignment: .leading, spacing: 30){
                        HStack{
                            VStack{
                                Divider()
                            }
                            
                            Text("Sync BetterTogether with".localized(language))
                                .layoutPriority(1)
                            
                            VStack{
                                Divider()
                            }
                        }
                        
                        //Apple Health
                        BoxView(imageName: "Apple Health", name: "Apple Health", text: "Steps, Floors, Glasses")
                        
                        //Fitbit
                        BoxView(imageName: "Fitbit",name: "Fitbit", text: "Steps, Floors, Glasses")
                        
                        HStack{
                            Text ("*")
                                .font(.largeTitle)
                            Text("The sync is activated every time that you enter the app. It is recommended to enter at the end of the day to record the full day achievemnts".localized(language))
                                .font(.subheadline)
                        }
                        .foregroundColor(.gray)
                    }
                    
                    //Pop up Settings
                    VStack(alignment: .leading, spacing: 30){
                        HStack{
                            VStack{
                                Divider()
                            }
                            
                            Text("Popup Settings".localized(language))
                                .layoutPriority(1)
                            
                            VStack{
                                Divider()
                            }
                        }
                        
                        //Daily Tips
                        BoxView(imageName: "dailyTips",name: "Daily Tips", text: "Wellness daily tips pop-ups")
                    }
                    
                    //Save Button
                    Button(action: {print("Save")}, label: {
                        Text("Save".localized(language))
                            .padding()
                            .font(.title2)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.8), Color.orange]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                    })
                }
                .padding()
            }
            .background(Color.gray.opacity(0.1))
            .navigationTitle("Account Details".localized(language))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                    //Language Change Menu
                    LanguageMenu()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
