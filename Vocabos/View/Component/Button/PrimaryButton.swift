//
//  PrimaryButton.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 16.10.2023.
//


import SwiftUI

struct PrimaryButton: View {
    var buttonText: LocalizedStringKey
    var textColor: Color = .white
    var isDisabled = false
    var leadingIcon: Image?
    var trailingIcon: Image?
    var action: (() -> ())?
    
  
    var body: some View {
        Button {
            action?()
        } label: {
            ZStack {
                Text(buttonText)
                    .font(.setCustom(fontStyle: .title2, fontWeight: .semibold))
                
                HStack {
                    if let leadingIcon {
                        leadingIcon
                            .resizable()
                            .scaledToFit()
                    }
                    Spacer()
                    if let trailingIcon {
                        trailingIcon
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(height: 26)
                .padding()
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(Color.mainColor)
            .cornerRadius(10)
            .foregroundColor(.white)
        }
     
        .disabled(isDisabled)
    }
}


struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(buttonText: "Test")
    }
}
