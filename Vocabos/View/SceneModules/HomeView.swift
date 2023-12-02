//
//  HomeView.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 23.09.2023.
//

import SwiftUI
import URLImage


struct HomeView: View {
    @State private var selectedOption = 0
    let imageURL = URL(string: "https://media.licdn.com/dms/image/D4D03AQFFX5KLV8gc2g/profile-displayphoto-shrink_800_800/0/1691842363292?e=1706745600&v=beta&t=yvJ5Y1SSwhcXqMBzATZolElquc21fbIPLqm2gZ-Dxzg")!

    let options = ["English", "French", "Deutchs"]
    
    
    var body: some View {
        VStack{
            //menu and language
            HStack{
                Button(action: {
                    // Button tıklandığında yapılacak işlemler
                    print("Button Tıklandı!")
                }) {
                    Image("menu_icon")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.black)
                }
                Spacer()
                
                // Stacked Menu Button
                Menu {
                    ForEach(options.indices, id: \.self) { index in
                        Button(action: {
                            self.selectedOption = index
                        }) {
                            Text(self.options[index])
                        }
                    }
                } label: {
                    HStack {
                        Image("france")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 19)
                        
                        Text(self.options[selectedOption])
                            .font(.setCustom(fontStyle: .caption, fontWeight: .semibold))
                            .foregroundColor(.black)
                            .padding(.leading, -2)
                        
                        Image("arrow_down")
                    }
                    .background(Color.white)  // Arka plan rengi
                    .frame(width: 120, height: 40)
                    .border(Color.borderGray)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.borderGray, lineWidth: 1)
                    )
                    
                }
            }
            
            HStack{
                URLImage(URL(string: AppUserDefaults.photo_url) ?? imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle()) // Resmi yuvarlak bir çerçeveye koyar
                        .overlay(Circle().stroke(Color.white, lineWidth: 1)) // İsteğe bağlı olarak beyaz bir çerçeve ekler
                        .shadow(radius: 3) // İsteğe bağlı olarak gölge ekler
                }
                .padding(0)

                VStack(alignment: .leading){
                    Text(AppUserDefaults.name_surname)
                        .font(.headline)
                       
                    
                    Text("Location: Turkey, TR")
                        .font(.setCustom(fontStyle: .subheadline, fontWeight: .regular))
                        .foregroundColor(.gray)
                       
                }
                Spacer()
            }
            .padding(.top,10)
            
            Spacer()
        }
        .background(StandartBackground())
        .padding()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
