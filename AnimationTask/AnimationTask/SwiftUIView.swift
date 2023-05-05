import SwiftUI

struct SwiftUIView: View {
    
    @State var size : CGFloat = UIScreen.main.bounds.width - 140
    
    var body: some View {
        
        ZStack{
            Text("Hello Cairocoders")
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
            
            SideMenuView(showMenu: Binding.constant(true)).cornerRadius(20).padding(15).offset(x: -size)
                .gesture(DragGesture()
                    .onChanged({ (value) in
                        
                        if value.translation.width > 0{
                            self.size = value.translation.width
                        }
                        else{
                            let temp = UIScreen.main.bounds.width - 140
                            self.size = temp + value.translation.width
                        }
                    })
                        .onEnded({ (value) in
                            if value.translation.width > 0{
                                if value.translation.width > 200{
                                    self.size = UIScreen.main.bounds.width - 140
                                }
                                else{
                                    self.size = 15
                                }
                            }
                            else{
                                //since in negative lower value will be greater...
                                if value.translation.width < -200{
                                    self.size = 15
                                }
                                else{
                                    self.size = UIScreen.main.bounds.width - 140
                                }
                            }
                        })
                )
                .transition(.slide)
                .animation(.spring())
            // animation for drag
        }
        .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}



struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

