//
//  ContentView.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 17/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = ContentViewModel()
    @State private var searchText = ""
    @State private var showSheet = false
    
    
    var body: some View {
        
        NavigationStack{
            
            ScrollViewReader{ scrollProxy in
                
                ZStack{
                    
                    //MARK: Contact List
                    List{
                        ForEach(vm.sectionTitleArray, id:\.self){section in
                            //Section header
                            Section( header: Text(section).foregroundColor(.gray) ){
                                
                                if let contacts = vm.contactDict[section]{
                                    ForEach(contacts, id:\.id){ con in
                                        ZStack(alignment: .leading) {
                                            
                                            //On click Navigate to Detail View
                                            NavigationLink(destination: DetailView(vm: vm, contact: con), label: {
                                                EmptyView()
                                            })
                                            .opacity(0)
                                            
                                            //If Name is present show name
                                            if con.getfullname() != ""{
                                                Text(con.getfullname())
                                                
                                            }//else show Phone number
                                            else if con.phone != []{
                                                Text(con.phone[0])
                                            }
                                            // If no name and no phone number
                                            else{
                                                Text(Key.Strings.noName)
                                                    .italic()
                                            }
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                    .padding(.trailing, 20)
                    .scrollIndicators(.never)
                    .listStyle(.plain)
                    
                    
                    //MARK: No Search Result Found View
                    if !searchText.isEmpty && vm.searchResults?.count == 0{
                        VStack{
                            Image(systemName: Key.Images.magGlass)
                                .font(.system(size: 56))
                                .foregroundColor(.gray)
                                .padding(.bottom, 12)
                            
                            Text(" \(Key.Strings.noResultFor) \"\(searchText)\"")
                                .font(.title)
                                .bold()
                                .padding(.bottom,5)
                            
                            Text(Key.Strings.searchMssg)
                                .foregroundColor(.gray.opacity(0.8))
                                .font(.subheadline)
                            
                        }
                    }
                    
                    //MARK: Side Index
                    if searchText.isEmpty{
                        VStack{
                            ForEach(vm.sideIndex, id:\.self){ section in
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        if vm.sectionTitleArray.first(where: {$0 == section}) != nil {
                                            withAnimation {
                                                scrollProxy.scrollTo(section)
                                            }
                                        }
                                    }, label: {
                                        Text(section)
                                            .font(.system(size: 11))
                                            .bold()
                                            .padding(.trailing, 4)
                                    })
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Key.Strings.contacts)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar{
                //MARK: Plus Button
                ToolbarItem{
                    Button{
                        showSheet = true
                    }label:{
                        Image(systemName: Key.Images.new)
                    }
                    
                }
            }
            .onAppear{
                vm.getContacts()
                
            }
            //sheet is presented when click on plus button
            .sheet(isPresented: $showSheet, onDismiss:{vm.getContacts()}){
                NavigationStack{
                    AddNewContact(vm:vm)
                }
            }
            
            //MARK: Search Bar Logic
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: searchText){ text in
                if !text.isEmpty{
                    vm.searchResults = vm.core.getAll()?.filter{
                        if $0.getfullname() != ""{
                            return $0.getfullname().uppercased().contains(searchText.uppercased())
                        }else if $0.phone != []{
                            return $0.phone[0].contains(searchText)
                        }
                        else if $0.url != []{
                            return $0.url[0].contains(searchText)
                        }
                        else if $0.address != []{
                            return $0.address[0].contains(searchText)
                        }
                        else if $0.notes != ""{
                            return $0.notes.contains(searchText)
                        }
                        else if $0.socialProfile != []{
                            return $0.socialProfile[0].contains(searchText)
                        }
                        else if $0.instantMssg != []{
                            return $0.instantMssg[0].contains(searchText)
                        }
                        else{
                            return false
                        }
                    }
                }
                else{
                    vm.searchResults = vm.core.getAll()
                }
                vm.sortContacts(in: vm.searchResults)
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView()
        }
    }
}
