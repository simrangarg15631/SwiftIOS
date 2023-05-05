//
//  SelectTypeView.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 18/04/23.
//

import SwiftUI

struct SelectTypeView: View {
    @Environment (\.dismiss) var dismiss
    @StateObject var vm = ContentViewModel()
//    @State private var ifSelected = false
    
    var body: some View {
        List{
            ForEach(vm.phoneType, id:\.self){ type in
                
                Text(type)
                    .onTapGesture {
                        dismiss()
                    }
//                HStack{
//                    Text(type)
//                        .onTapGesture {
//                            ifSelected = true
//                        }
//                    Spacer()
//
//                    if ifSelected{
//                        Image(systemName: Key.Images.checkMark)
//                            .foregroundColor(.blue)
//                            .bold()
//                    }
//                }
            }
        }
        .background(Color(.systemGray6))
        .listStyle(PlainListStyle())
        .navigationTitle(Key.Strings.label)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button{
                    dismiss()
                }label:{
                    Text(Key.Strings.cancel)
                }
            }
        }
    }
}

struct SelectTypeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SelectTypeView()
        }
    }
}
