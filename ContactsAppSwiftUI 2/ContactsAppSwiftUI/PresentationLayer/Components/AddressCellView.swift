//
//  AddressCellView.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 25/04/23.
//

import SwiftUI

struct AddressCellView: View {
    
    @Binding var street1: [String]
    @Binding var street2: [String]
    @Binding var city: [String]
    @Binding var state: [String]
    @Binding var zip: [String]
    @Binding var country: [String]
    @Binding var isEditing: Bool
    @Binding var isPresented: Bool

    var body: some View {
        Section{
            ForEach(1..<street1.count, id:\.self){ i in
                
                HStack{
                    Button{
                        isPresented = true
                    }label:{
                        Text(Key.Strings.home)
                    }
                    Divider()
                    
                    VStack{
                        TextField(Key.Strings.street, text: $street1[i])
                        Divider()
                        TextField(Key.Strings.street, text: $street2[i])
                        Divider()
                        TextField(Key.Strings.city, text: $city[i])
                        Divider()
                        HStack{
                            TextField(Key.Strings.state, text: $state[i])
                            Divider()
                            TextField(Key.Strings.zip, text: $zip[i])
                        }
                        Divider()
                        TextField(Key.Strings.country, text: $country[i])
                        
                    }
                }
            }
            .onDelete{ indexset in
                street1.remove(atOffsets: indexset)
                street2.remove(atOffsets: indexset)
                city.remove(atOffsets: indexset)
                state.remove(atOffsets: indexset)
                zip.remove(atOffsets: indexset)
                country.remove(atOffsets: indexset)
            }
            
            Button{
                street1.append("")
                street2.append("")
                city.append("")
                state.append("")
                zip.append("")
                country.append("")
                isEditing = true
            } label: {
                HStack{
                    Image(systemName: Key.Images.plus)
                        .resizable()
                        .frame(width: 22, height:22)
                        .foregroundColor(.green)
                    Text(Key.Strings.addAddress)
                        .padding(.leading, 10)
                }
            }
            
        }
    }
}

//struct AddressCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddressCellView(dataArray: Binding.constant([""]), isEditing: Binding.constant(true), isPresented: Binding.constant(true), cell: "")
//    }
//}
