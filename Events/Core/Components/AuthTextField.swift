

import SwiftUI

struct AuthTextField: View {
    let ImageName: String
    let placeholder: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    @Binding var text: String
    @Binding var isLoading: Bool
    var validator: (() async -> (Bool, String))? = nil
    @State private var isValid: (Bool, String) = (true, "")

    var body: some View {
        VStack(spacing: 0) {

            HStack {
                // TextField
                if isSecure {
                    Image(systemName: ImageName).foregroundStyle(Color.darkGray2)
                    SecureField(text: $text) {
                        Text(placeholder)
                    }
                    .keyboardType(keyboardType)
                    .onChange(of: text) {
                        if let validator = validator{
                            Task {
                                isValid = await validator()
                            }
                        }
                    }
                    .tint(Color(.lightBlue))
                    .foregroundStyle(Color(.lightBlue))
                } else {
                    Image(systemName: ImageName).foregroundStyle(Color.darkGray2)
                    TextField(text: $text) {
                        Text(placeholder)
                    }
                    .keyboardType(keyboardType)
                    .onChange(of: text) {
                        if let validator = validator{
                            Task {
                                isValid = await validator()
                            }
                        }                    }
                    .tint(Color(.lightBlue))
                    .foregroundStyle(Color(.lightBlue))
                }

                // Trailing Icon
                if isLoading {
                    ProgressView()
                } else {
                    if !text.isEmpty && validator != nil {
                        Image(systemName: isValid.0 ? "checkmark" : "exclamationmark")
                            .resizable()
                            .scaledToFit()
                            .fontWeight(.bold)
                            .frame(width: 12, height: 12)
                            .padding(4)
                            .foregroundStyle(.white)
                            .background(
                                Circle()
                                    .fill(isValid.0 ? .green : .red)
                                    .frame(width: 24)
                            )
                    }
                }
            }.padding().background(Capsule().fill(Color.gray.opacity(0.1))) //: HStack
            .padding(.horizontal, 16)
//            .padding(.bottom, 8)
            
            
            

            if !text.isEmpty && !isLoading && !isValid.0 {
                HStack {
                    Text(isValid.1)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 8)
                }
                .background(.red)
                .overlay {
                    let triangleSize = 8
                    Path { path in
                        path.move(to: CGPoint(x: 32 - triangleSize, y: 0))
                        path.addLine(to: CGPoint(x: 32, y: -triangleSize))
                        path.addLine(to: CGPoint(x: 32 + triangleSize, y: 0))
                    }
                    .foregroundColor(.red)
                }
            }
        }
             //: VStack
    }
}

#Preview {
    AuthTextField(ImageName: "envelope", placeholder: "Name", text: .constant(""), isLoading: .constant(true)) 
}
