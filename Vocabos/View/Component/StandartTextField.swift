//
//  StandartTextField.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 27.11.2023.
//


import SwiftUI
import Veil

struct StandartTextField: View {
    @Binding var value: String
    @State private var isClicked: Bool = false
    @FocusState private var isInputActive: Bool

    var fieldName: LocalizedStringKey
    var contentType: UITextContentType?
    var keyboardType: UIKeyboardType = .default
    var pattern: InputPattern?
    var isDisabled = false
    var isPassword = false
    var isFocused = false
    var balance: Double?
    var canCopy = false
    var fontStyle: Font.TextStyle = .title3
    var fontWeight: Font.Weight = .semibold
    var height: CGFloat = 56
    var limit: Int?
    var icon: Image?
    var autoCapitalization: TextInputAutocapitalization = .sentences
    var action: (() -> ())?

    private var patternMask: Veil? {
        guard let pattern = pattern else { return nil }
        return Veil(pattern: pattern.rawValue)
    }

    var isEditing: Bool {
        isClicked || !value.isEmpty
    }

    var balanceText: String {
        "balance"
    }

    var body: some View {
        ZStack(alignment: .leading) {
            if isPassword {
                // Placeholder
                Text(fieldName)
                    .font(.setCustom(fontStyle: isEditing ? .subheadline : .title3, fontWeight: .semibold))
                    .foregroundColor(isEditing ? .mainColor : .gray)
                    .offset(y: isEditing ? -14 : 0)
                    .padding()

                SecureField("", text: $value)
                    .onChange(of: value) { newValue in
                        if let limit = limit, limit > 0, newValue.count > limit {
                            value = String(newValue.prefix(limit))
                        }
                        guard let patternMask = patternMask else { return }
                        value = patternMask.mask(input: newValue, exhaustive: false)
                    }
                    .disabled(isDisabled)
                    .font(.setCustom(fontStyle: fontStyle, fontWeight: .bold))
                    .keyboardType(keyboardType)
                    .textContentType(contentType)
                    .foregroundColor(Color.black)
                    .focused($isInputActive)
                    .textInputAutocapitalization(autoCapitalization)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            if isInputActive {
                                Button("Tamam") {
                                    isInputActive = false
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: -16, trailing: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 1)
                            .fill(Color.mainColor)
                            .frame(height: height)
                    )
            } else {
                // Placeholder
                Text(fieldName)
                    .font(.setCustom(fontStyle: isEditing ? .subheadline : .title3, fontWeight: .semibold))
                    .foregroundColor(isEditing ? .mainColor : .gray)
                    .offset(y: isEditing ? -14 : 0)
                    .padding()

                TextField("", text: $value) { _ in
                    withAnimation {
                        isClicked.toggle()
                    }
                }
                .onChange(of: value) { newValue in
                    if let limit = limit, limit > 0, newValue.count > limit {
                        value = String(newValue.prefix(limit))
                    }
                    guard let patternMask = patternMask else { return }
                    value = patternMask.mask(input: newValue, exhaustive: false)
                }
                .disabled(isDisabled)
                .font(.setCustom(fontStyle: fontStyle, fontWeight: .bold))
                .keyboardType(keyboardType)
                .textContentType(contentType)
                .foregroundColor(Color.black)
                .focused($isInputActive)
                .textInputAutocapitalization(autoCapitalization)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        if isInputActive {
                            Button("Tamam") {
                                isInputActive = false
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: -16, trailing: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1)
                        .fill(Color.mainColor)
                        .frame(height: height)
                )
            }

            HStack(spacing: 1) {
                Spacer()

          

                icon?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .padding(.trailing)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(height: height)
        )
        .padding(.vertical, 4)
        .onAppear {
            if isFocused { isInputActive = true }
        }
        .onTapGesture {
            action?()
        }
        .tint(Color.black)
    }

    private func copyText() {
        UIPasteboard.general.string = value
    }
}

struct ViewWrapper: View {
    @State var value: String = ""
    var body: some View {
        StandartTextField(value: $value, fieldName: "Test", contentType: .name, balance: 10.5, canCopy: false)
    }
}

struct StandartTextField_Previews: PreviewProvider {
    static var previews: some View {
        ViewWrapper()
            .preferredColorScheme(.dark)
    }
}
