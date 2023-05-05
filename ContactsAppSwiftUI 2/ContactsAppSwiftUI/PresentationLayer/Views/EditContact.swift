//
//  EditContact.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 18/04/23.
//

import SwiftUI


struct EditContact: View {
    
    @Environment (\.dismiss) var dismiss
    @StateObject var vm: ContentViewModel
    @Binding var contact: Contact
    @State private var phoneArray: [String] = [""]
    @State private var emailArray: [String] = [""]
    @State private var urlArray: [String] = [""]
    @State private var addressArray: [String] = [""]
    @State private var socialArray: [String] = [""]
    @State private var instantArray: [String] = [""]

    @State private var isPresented = false
    @State private var isEditing = true
    @State private var showAction = false
    @State private var showAlert = false
//    @State private var isDisabled = true
    @Binding var rootPesented:Bool
    
    var body: some View {
        
        VStack{
            
            //TODO: Store in Core Data
            //MARK: PhotoPicker
            PhotoPickerView(profilePic: $contact.profilePicture)
            
            List{
                Section{
                    //MARK: FirstName TextField
                    TextField(Key.Strings.firstName, text: self.$contact.firstName)
                        .background(Color.clear)
                        .disableAutocorrection(true)
                    
                    //MARK: LastName TextField
                    TextField(Key.Strings.lastName, text: self.$contact.lastName)
                        .background(Color.clear)
                        .disableAutocorrection(true)
                    
                    //MARK: Company TextField
                    TextField(Key.Strings.company, text: self.$contact.company )
                        .background(Color.clear)
                        .disableAutocorrection(true)
                        
                }
                
                //MARK: Add Phone
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
                    AddCellView(dataArray: $addressArray, isEditing: $isEditing, isPresented: $isPresented, cell: Key.Strings.address)
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

                        TextEditor(text: $contact.notes)
                            .frame(height: 60)
                    }
                }
                
                //MARK: Delete Contact
                Section(header: Text("")){
                    Button{
                        showAction = true
                    }label:{
                        Text(Key.Strings.deleteContact)
                            .foregroundColor(Color.red)
                    }
                    .confirmationDialog(Key.Strings.deleteContact, isPresented: $showAction, titleVisibility: .hidden){
                        
                        Button(role: .destructive){
                            vm.core.delete(id: contact.id)
                            vm.getContacts()
                            rootPesented = true
                            dismiss()
                        }label:{
                            Text(Key.Strings.deleteContact)
                        }
                    }
                    
                }
            }
            .listStyle(.plain)
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active: EditMode.inactive))
            
            Spacer()
        }
        .background(Color(.systemGray6))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
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
                    if contact.firstName != "" || contact.lastName != "" || contact.company != "" || !arr1.isEmpty || !arr2.isEmpty || !arr3.isEmpty || !arr4.isEmpty || contact.notes != "" || contact.profilePicture.count != 0 || !arr5.isEmpty || !arr6.isEmpty{
                        vm.core.update(contact: Contact(id: contact.id,firstName: contact.firstName, lastName: contact.lastName, company: contact.company, profilePicture: contact.profilePicture, phone: arr1, url: arr3, email: arr2, address: arr4, notes: contact.notes, socialProfile: arr5, instantMssg: arr6))
                    }
                    dismiss()
                }, label: {
                    Text(Key.Strings.done)
                })
//                .disabled(isDisabled)
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
        .sheet(isPresented: $isPresented){
            NavigationView{
                SelectTypeView()
            }
        }
    }
}

//struct EditContact_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack{
//            EditContact(vm: ContentViewModel(), contact: Binding.constant(Contact(firstName: "", lastName: "", company: "", phone: [""],  url:[""], email: [""], address: [""], notes: "")), rootPesented: Binding.constant(true))
//        }
//    }
//}
