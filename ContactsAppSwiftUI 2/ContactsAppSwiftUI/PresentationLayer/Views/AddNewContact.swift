//
//  AddNewContact.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 17/04/23.
//

import SwiftUI
import PhotosUI

struct AddNewContact: View {
    @Environment (\.dismiss) var dismiss
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var company: String = ""
    @State private var phoneArray: [String] = [""]
    @State private var addressArray: [String] = [""]
    @State private var emailArray: [String] = [""]
    @State private var urlArray: [String] = [""]
    @State private var socialArray: [String] = [""]
    @State private var instantArray: [String] = [""]
    @State private var notes: String = ""
    @State private var showAlert = false
    @State private var street1: [String] = [""]
    @State private var street2: [String] = [""]
    @State private var city: [String] = [""]
    @State private var state: [String] = [""]
    @State private var zip: [String] = [""]
    @State private var country: [String] = [""]
    @State private var profilePic: Data = Data()
    
    @StateObject var vm: ContentViewModel
    
    @State private var isPresented = false
    @State var isEditing = false
    
    var body: some View {
        
        VStack{
            
            //MARK: Photo Picker
            PhotoPickerView(profilePic: $profilePic)
            
            List{
                Section{
                    //MARK: FirstName TextField
                    TextField(Key.Strings.firstName, text: $firstName)
                        .background(Color.clear)
                        .disableAutocorrection(true)
                    
                    //MARK: LastName TextField
                    TextField(Key.Strings.lastName, text: $lastName)
                        .background(Color.clear)
                        .disableAutocorrection(true)
                    
                    //MARK: Company TextField
                    TextField(Key.Strings.company, text: $company)
                        .background(Color.clear)
                        .disableAutocorrection(true)
                }
                
                // MARK: Add Phone
                Section(header: Text("")){
                    AddCellView(dataArray: $phoneArray, isEditing: $isEditing, isPresented: $isPresented, cell: Key.Strings.phone)
                }
                
                // MARK: Add Email
                Section(header: Text("")){
                    AddCellView(dataArray: $emailArray, isEditing: $isEditing, isPresented: $isPresented, cell: Key.Strings.email)
                }
                
                // MARK: Add url
                Section(header: Text("")){
                    AddCellView(dataArray: $urlArray, isEditing: $isEditing, isPresented: $isPresented, cell: Key.Strings.url)
                }
                
                // MARK: Add Address
                Section(header: Text("")){
                    
                    AddressCellView(street1: $street1, street2: $street2, city: $city, state: $state, zip: $zip, country: $country, isEditing: $isEditing, isPresented: $isPresented)
                }
                
                //MARK: Add Social Profile
                Section(header: Text("")){
                    AddCellView(dataArray: $socialArray, isEditing: $isEditing, isPresented: $isPresented, cell: Key.Strings.socialProfile)
                }
                
                //MARK: Add Instant Message
                Section(header: Text("")){
                    AddCellView(dataArray: $instantArray, isEditing: $isEditing, isPresented: $isPresented, cell: Key.Strings.instantMssg)
                }
                
                //MARK: Notes
                Section(header: Text("")){
                    VStack(alignment: .leading, spacing: 10){
                        
                        Text(Key.Strings.notes)
                            .padding(.top, 4)

                        TextEditor(text: $notes)
                            .frame(height: 60)

                    }
                }
            }
            .listStyle(.plain)
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active: EditMode.inactive))
            
            Spacer()
        }
        .background(Color(.systemGray6))
        .navigationTitle(Key.Strings.newContact)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(){
            //MARK: Done Button
            ToolbarItem{
                Button(action: {
                    var arr1 = [String]()
                    for val in phoneArray {
                        if val != "" {
                            arr1.append(val)
                        }
                    }
                    var arr2 = [String]()
                    for val in emailArray {
                        if val != "" {
                            arr2.append(val)
                        }
                    }
                    var arr3 = [String]()
                    for val in urlArray {
                        if val != "" {
                            arr3.append(val)
                        }
                    }
                    
                    
                    
                    for i in 1..<street1.count{
                        var address: String = ""
                        
                        if street1[i] != "" {
                            address += street1[i]
                        }
                        if street2[i] != "" {
                            address += street2[i]
                        }
                        if city[i] != "" {
                            address += city[i]
                        }
                        if state[i] != "" {
                            address += state[i]
                        }
                        if zip[i] != "" {
                            address += zip[i]
                        }
                        if country[i] != "" {
                            address += country[i]
                        }
                        addressArray.append(address)
                    }
                    var arr4 = [String]()
                    for val in addressArray {
                        if val != "" {
                            arr4.append(val)
                        }
                    }
                    
                    var arr5 = [String]()
                    for val in socialArray {
                        if val != "" {
                            arr5.append(val)
                        }
                    }
                    
                    var arr6 = [String]()
                    for val in instantArray {
                        if val != "" {
                            arr6.append(val)
                        }
                    }
                    if firstName != "" || lastName != "" || company != "" || !arr1.isEmpty || !arr2.isEmpty || !arr3.isEmpty || !arr4.isEmpty || notes != "" || profilePic.count != 0 || !arr5.isEmpty || !arr6.isEmpty
                    {
                        vm.core.create(contact: Contact(firstName: firstName, lastName: lastName, company: company, profilePicture: profilePic, phone: arr1, url: arr3, email: arr2, address: arr4, notes: notes, socialProfile: arr5, instantMssg: arr6))
                    }
                    dismiss()
                }, label: {
                    Text(Key.Strings.done)
                })
            }
            
            //MARK: Cancel button
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                   showAlert = true
                }, label: {
                    Text(Key.Strings.cancel)
                })
                //MARK: Action Sheet
                .confirmationDialog(Key.Strings.alertMssg, isPresented: $showAlert, titleVisibility: .visible, actions: {
                    Button(role: .destructive, action: {
                        dismiss()
                    }, label: {
                        Text(Key.Strings.discard)
                    })
                    
                    Button(role: .cancel, action: {}, label: {
                        Text(Key.Strings.keepEditing)
                    })
                })
            }
        }
//        .sheet(isPresented: $isPresented){
//            NavigationView{
//                SelectTypeView()
//            }
//        }
    }
}

//struct AddNewContact_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack{
//            AddNewContact(vm: ContentViewModel())
//        }
//    }
//}
