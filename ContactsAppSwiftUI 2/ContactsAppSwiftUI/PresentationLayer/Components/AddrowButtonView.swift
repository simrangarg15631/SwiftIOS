//
//  AddrowButtonView.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 25/04/23.
//

import SwiftUI

struct AddrowButtonView: View {
    
    @Binding var dataArray: [String]
    @Binding var isEditing: Bool
    var cell: String

    var body: some View {
        Button{
            dataArray.append("")
            isEditing = true
        } label: {
            HStack{
                Image(systemName: Key.Images.plus)
                    .resizable()
                    .frame(width: 22, height:22)
                    .foregroundColor(.green)
                Text(Key.Strings.add + " \(cell)")
                    .padding(.leading, 10)
            }
        }
    }
}

struct AddrowButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddrowButtonView(dataArray: Binding.constant([""]), isEditing: Binding.constant(true), cell: "")
    }
}
