//
// Created on 2020/11/17, by Yin Tan
// 
//

import SwiftUI
import ElepaySDK

/// Wrap a UIViewController to present other UIViewController.
private final class ElepayUIPresenter: UIViewControllerRepresentable {
    private(set) var wrappedViewController: UIViewController? = nil

    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        wrappedViewController = UIViewController()

        return wrappedViewController!
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct ContentView: View {
    private struct ResultMessage: Identifiable {
        let id: String
        let content: String
    }

    // Hold the raw data for convenience.
    private let products: [Product]
    // Transformed data structure used for looking up.
    private let productsMap: [Product.ID: Product]
    @State private var selectedProducts: [Product.ID: Int] = [:]
    @State private var amount: String = "0"
    @State private var elepayResultMessage: ResultMessage?
    private var uiPresenter = ElepayUIPresenter()

    init(products: [Product]) {
        self.products = products
        productsMap = Dictionary(uniqueKeysWithValues: products.map { ($0.id, $0) })
        for product in products {
            selectedProducts[product.id] = 0
        }

        Elepay.initApp(key: AppConfig.elepay.pKey, apiURLString: AppConfig.elepay.apiBaseUrl)
    }

    var body: some View {
        NavigationView {
            contentView
                .navigationTitle("Easy Checkout Demo")
        }
    }

    private var contentView: some View {
        VStack {
            ProductListView(products: products, selected: $selectedProducts)
                .padding(.vertical, 4)
                .padding(.horizontal, 16)
            AmountEditor(amount: $amount)
                .padding(.vertical, 4)
                .padding(.horizontal, 16)
            Button(action: {
                performPayment()
            }, label: {
                Text("支払")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .layoutPriority(1)
            })
            .padding()

            uiPresenter
                .frame(maxWidth: 1, maxHeight: 1)
        }
        .onChange(of: selectedProducts) { selected in
            let total = selected.reduce(0) { (res, item) -> Int in
                if let prod = productsMap[item.key] {
                    return res + prod.price * item.value
                } else {
                    return res
                }
            }
            amount = String(total)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
        .alert(item: $elepayResultMessage) { elepayRes in
            Alert(title: Text(""), message: Text("\(elepayRes.content)"), dismissButton: nil)
        }
    }

    private func performPayment() {
        guard let total = Int(amount),
              let presenter = uiPresenter.wrappedViewController
        else { return }

        let items: [Any]? = selectedProducts.isEmpty ? nil : generateProductItemsForAPI()
        PaymentManager.checkout(amount: total, products: items, from: presenter) { res in
            switch res {
            case .failure(let err):
                elepayResultMessage = ResultMessage(id: "failure", content: "\(err)")
            case .success(let msg):
                elepayResultMessage = ResultMessage(id: "success", content: msg)
            }
        }
    }

    private func generateProductItemsForAPI() -> [[String: Any]] {
        products.compactMap { product -> [String: Any]? in
            if let count = selectedProducts[product.id] {
                return [
                    "name": product.name,
                    "price": product.price,
                    "count": count,
                    "image": product.imageUrl,
                ]
            } else {
                return nil
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static private let products = [
        Product(id: "0", imageName: "coffee1", imageUrl: "", name: "Coffee", price: 120),
        Product(id: "1", imageName: "coffee1", imageUrl: "", name: "Coffee", price: 120),
        Product(id: "2", imageName: "coffee1", imageUrl: "", name: "Coffee", price: 120),
        Product(id: "3", imageName: "coffee1", imageUrl: "", name: "Coffee", price: 120)
    ]
    static var previews: some View {
        ContentView(products: products)
            .previewDevice("iPhone 12")
    }
}
