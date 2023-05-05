//
//  DetailView.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 17/04/23.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: ContentViewModel
    @State var contact: Contact
    @State var rootPesented:Bool = false
    
    var body: some View {
        
        VStack(spacing: 20){
            
            //MARK: Profile Picture
            if let uiImage = UIImage(data: contact.profilePicture){
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width:150, height: 150)
                    .clipShape(Circle())
                    .padding(.top, 15)
            }else{
                Image(systemName: Key.Images.person)
                    .resizable()
                    .frame(width:150, height: 150)
                    .clipShape(Circle())
                    .padding(.top, 15)
                    .foregroundColor(.gray)
            }
            
            VStack(spacing: 5){
                
                //MARK: Name
                if !contact.email.isEmpty{
                    if contact.getfullname() != contact.email[0]{
                        Text(contact.getfullname())
                            .font(.title)
                    }
                }else if contact.getfullname() != "" {
                    Text(contact.getfullname())
                        .font(.title)
                }
                //MARK: Company
                if contact.getfullname() != contact.company{
                    Text(contact.company)
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            
            //MARK: Action Buttons
            HStack{
                ActionButtonView(imageName: Key.Images.message, btn: Key.Strings.message)
                ActionButtonView(imageName: Key.Images.phone, btn: Key.Strings.call)
                ActionButtonView()
            }
            
            List{
                //MARK: Phone
                if contact.phone != []{
                    Section{
                        VStack(alignment: .leading, spacing: 4){
                            
                            ForEach(contact.phone, id: \.self){ phone in
                                Text(Key.Strings.main)
                                    .font(.subheadline)
                                Text(phone)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                
                //MARK: Email
                if contact.email != []{
                    Section{
                        VStack(alignment: .leading, spacing: 4){
                            
                            ForEach(contact.email, id: \.self){ email in
                                Text(Key.Strings.work)
                                    .font(.subheadline)
                                Text(email)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                
                //MARK: URL
                if contact.url != []{
                    Section{
                        VStack(alignment: .leading, spacing: 4){

                            ForEach(contact.url, id: \.self){ url in
                                Text(Key.Strings.home)
                                    .font(.subheadline)
                                Text(url)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                
                //MARK: Address
                if contact.address != []{
                    Section{
                        VStack(alignment: .leading, spacing: 4){

                            ForEach(contact.address, id: \.self){ address in
                                Text(Key.Strings.home)
                                    .font(.subheadline)
                                Text(address)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
                
                //MARK: Social Profile
                if contact.socialProfile != []{
                    Section{
                        VStack(alignment: .leading, spacing: 4){
                            
                            ForEach(contact.socialProfile, id: \.self){ profile in
                                Text(Key.Strings.twitter)
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                Text(profile)
                            }
                        }
                    }
                }
                
                //MARK: Instant Message
                if contact.instantMssg != []{
                    Section{
                        VStack(alignment: .leading, spacing: 4){
                            
                            ForEach(contact.instantMssg, id: \.self){ mssg in
                                Text(Key.Strings.skype)
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                Text(mssg)
                            }
                        }
                    }
                }

                //MARK: Notes
                Section{
                    VStack(alignment: .leading){

                        Text(Key.Strings.notes)
                            .padding(.top, 4)
                        
                        TextEditor(text: $contact.notes)
                            .frame(height: 60)
                            .padding(.bottom, 10)
                    }
                }
            
                
                Section{
                    
                    //MARK: Send Message Button
                    if !contact.phone.isEmpty{
                        Menu{
                            Button(action: {}, label: {
                                HStack{
                                        Text(Key.Strings.loading)
                                            .foregroundColor(.gray)
                                        
                                        ProgressView()
                                            .tint(Color.gray)
                                }
                            })
                            
                        } label: {
                            Text(Key.Strings.sendMssg)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    //MARK: Share Contact Button
                    Button(action: {
                        
                    }, label: {
                        Text(Key.Strings.shareContact)
                            .foregroundColor(.blue)
                    })
                    
                    //MARK: Add to Favourites Button
                    if !contact.phone.isEmpty || !contact.email.isEmpty{
                        
                        Menu {
                            
                            Text(Key.Strings.favourites)
                                .foregroundColor(.gray)
                            
                            if !contact.email.isEmpty{
                                ForEach(contact.email, id:\.self){ email in
                                    Button(action: {
                                        
                                    }, label: {
                                        Text(email)
                                    })
                                }
                            }
                            else{
                                Button(action: {}, label: {
                                    HStack{
                                        Text(Key.Strings.loading)
                                            .foregroundColor(.gray)
                                            
                                        ProgressView()
                                            .tint(Color.gray)
                                    }
                                })
                            }
                            
                        } label:{
                            Text(Key.Strings.favourites)
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                //MARK: Add to Emergency Contact
                if !contact.phone.isEmpty{
                    Section{
                        Button(action: {}, label: {
                            Text(Key.Strings.emergency)
                                .foregroundColor(.blue)
                        })
                    }
                }
                
                
                //MARK: Share Location Button
                if !contact.phone.isEmpty || !contact.email.isEmpty{
                    Section{
                        Menu{
                            Text(Key.Strings.shareLocation)
                                .foregroundColor(.gray)
                            
                            Button(action: {}, label: {
                                HStack{
                                    Text(Key.Strings.shareIndefinitely)
                                    Image(systemName: Key.Images.infinity)
                                }
                            })
                            
                            Button(action: {}, label: {
                                HStack{
                                    Text(Key.Strings.endOfDay)
                                    Image(systemName: Key.Images.calendar)
                                }
                            })
                            
                            Button(action: {}, label: {
                                HStack{
                                    Text(Key.Strings.oneHour)
                                    Image(systemName: Key.Images.clock)
                                }
                            })
                            
                        } label:{
                            Text(Key.Strings.shareLocation)
                                .foregroundColor(.blue)
                        }
                    }
                }
                
//                Section{
//                    Button(action: {}, label: {
//                        Text(Key.Strings.addToList)
//                            .foregroundColor(.blue)
//                    })
//                }
            }
            .listStyle(.insetGrouped)
            
            Spacer()
        }
        .onAppear{
            if !rootPesented{
                contact = vm.core.get(byIdentifier: contact.id) ?? Contact(firstName: "", lastName: "", company: "", profilePicture: Data(), phone: [""],  url:[""], email: [""], address: [""], notes: "", socialProfile: [""], instantMssg: [""])
            }
            else{
                self.dismiss()
            }
        }
        .background(Color(.systemGray6))
        .toolbar{
            //MARK: Edit Button
            ToolbarItem{
                NavigationLink(destination: EditContact(vm: ContentViewModel(), contact: $contact, rootPesented: $rootPesented), label: {Text(Key.Strings.edit)})
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(rootPesented)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(vm: ContentViewModel(), contact: Contact(firstName: "", lastName: "", company: "", profilePicture: Data(), phone: [""],  url:[""], email: [""], address: [""], notes: "", socialProfile: [""], instantMssg: [""]))
        }
    }
}
