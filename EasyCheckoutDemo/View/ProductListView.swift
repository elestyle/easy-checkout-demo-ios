//
// Created on 2020/11/18, by Yin Tan
// 
//

import SwiftUI

struct ProductListView: View {
    @Binding private var selectedProducts: [Product.ID: Int]

    private let products: [Product]

    init(products: [Product], selected: Binding<[Product.ID: Int]>) {
        self.products = products
        _selectedProducts = selected
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("商品")
                Spacer()
                Button(action: {
                    clearSelections()
                }, label: {
                    Image(systemName: "trash")
                    Text("リセット")
                        .foregroundColor(.blue)
                })
            }
            .padding(16)

            List {
                ForEach(products) { product in
                    ProductRow(count: bindedCount(key: product.id), product: product)
                        .buttonStyle(PlainButtonStyle())
                }
                .listRowBackground(Color(UIColor.tertiarySystemBackground))
                .listRowInsets(EdgeInsets())
            }
            .listStyle(PlainListStyle())
        }
        .background(Color(UIColor.tertiarySystemBackground))
        .cornerRadius(16)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.1), radius: 60, y: 3)
    }

    private func bindedCount(key: Product.ID) -> Binding<Int> {
        .init(
            get: { selectedProducts[key, default: 0] },
            set: { selectedProducts[key] = $0 }
        )
    }

    private func clearSelections() {
        for key in selectedProducts.keys {
            selectedProducts[key] = 0
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static private let products = [
        Product(id: "0", imageName: "coffee1", imageUrl: "", name: "Coffee", price: 120),
        Product(id: "1", imageName: "coffee1", imageUrl: "", name: "Coffee", price: 120),
        Product(id: "2", imageName: "coffee1", imageUrl: "", name: "Coffee", price: 120)
    ]
    @State static private var selectedProducts: [Product.ID: Int] = [
        "0": 0,
        "1": 0,
        "2": 0
    ]
    static var previews: some View {
        ProductListView(products: products, selected: $selectedProducts)
            .previewDevice("iPhone 12")
    }
}
