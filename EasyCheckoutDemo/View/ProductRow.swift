//
// Created on 2020/11/18, by Yin Tan
// 
//

import SwiftUI

struct ProductRow: View {
    @Binding var count: Int
    let product: Product

    var body: some View {
        HStack {
            Image(product.imageName)
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(Font.body)
                    .padding(.bottom, 4)
                Text("¥\(product.price)")
                    .font(Font.body.bold())
            }
            Spacer()
            NumericCounter(count: $count)
        }
        .padding()
    }
}

struct ProductRow_Preview: PreviewProvider {
    @State static private var count: Int = 0
    static var previews: some View {
        ProductRow(
            count: $count,
            product: Product(id: "0", imageName: "", imageUrl: "", name: "hello", price: 1000)
        )
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
