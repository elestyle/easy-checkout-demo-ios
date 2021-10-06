//
// Created on 2020/11/18, by Yin Tan
// 
//

import SwiftUI

struct AmountEditor: View {
    @Binding var amount: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("支払い金額")
                .font(.body)
            HStack {
                Text("¥")
                    .foregroundColor(Color.blue)
                    .font(.largeTitle)
                TextField("", text: $amount)
                    .foregroundColor(Color.blue)
                    .font(Font.largeTitle.bold())
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
            }
        }
        .padding()
        .background(Color(UIColor.tertiarySystemBackground))
        .cornerRadius(16)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.1), radius: 60, y: 3)
    }
}

struct AmountEditorPreview: PreviewProvider {
    @State static private var amount: String = ""
    static var previews: some View {
        AmountEditor(amount: $amount)
    }
}
