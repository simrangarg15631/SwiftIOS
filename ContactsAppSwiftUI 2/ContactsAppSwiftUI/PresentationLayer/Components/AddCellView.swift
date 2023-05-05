//
//  AddCellView.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 25/04/23.
//

import SwiftUI

struct AddCellView: View {
    
    @Binding var dataArray: [String]
    @Binding var isEditing: Bool
    @Binding var isPresented: Bool
    var cell: String
    var body: some View {
        Section{
            ForEach(1..<dataArray.count, id:\.self){ i in
                
                HStack{
                    Button{
                        isPresented = true
                    }label:{
                        if cell == Key.Strings.phone{
                            Text(Key.Strings.mobile)
                        }else if cell == Key.Strings.email{
                            Text(Key.Strings.work)
                        }else if cell == Key.Strings.url{
                            Text(Key.Strings.home)
                        }else if cell == Key.Strings.address{
                            Text(Key.Strings.address)
                        }else if cell == Key.Strings.socialProfile{
                            Text(Key.Strings.twitter)
                        }else if cell == Key.Strings.instantMssg{
                            Text(Key.Strings.skype)
                        }
                        
                    }
                    Divider()
                    if cell == Key.Strings.phone{
                    TextField("\(cell.capitalized)", text: $dataArray[i])
                        .keyboardType(.phonePad)
                    }else if cell == Key.Strings.email{
                        TextField("\(cell.capitalized)", text: $dataArray[i])
                            .keyboardType(.emailAddress)
                    }else if cell == Key.Strings.url{
                        TextField("\(cell.capitalized)", text: $dataArray[i])
                            .keyboardType(.URL)
                    }else if cell == Key.Strings.address{
                        TextField("\(cell.capitalized)", text: $dataArray[i])
                    }
                    else if cell == Key.Strings.socialProfile{
                        TextField("\(cell.capitalized)", text: $dataArray[i])
                    }
                    else if cell == Key.Strings.instantMssg{
                        TextField("\(cell.capitalized)", text: $dataArray[i])
                    }
                }
            }
            .onDelete{ indexset in
                dataArray.remove(atOffsets: indexset)
            }
            
            AddrowButtonView(dataArray: $dataArray, isEditing: $isEditing, cell: cell)
            
        }
    }
}


struct AddCellView_Previews: PreviewProvider {
    static var previews: some View {
        AddCellView(dataArray: Binding.constant([""]), isEditing: Binding.constant(true), isPresented: Binding.constant(true), cell: "")
    }
}
