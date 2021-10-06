//
// Created on 2020/11/17, by Yin Tan
// 
//

import SwiftUI
import ElepaySDK

@main
struct EasyCheckoutDemoApp: App {
    private let products = [
            Product(
                id: "0",
                imageName: "coffee1",
                imageUrl: "https://files.elecdn.com/images/app_8bd64f25c5545b99c43e295/product/file_2b2f7a136551e1dc919c020_s.jpg",
                name: "カフェ・オレ",
                price: 140),
            Product(
                id: "1",
                imageName: "water1",
                imageUrl: "https://files.elecdn.com/images/app_8bd64f25c5545b99c43e295/product/file_0844150fa11d0da8e05e1e2_s.jpg",
                name: "炭酸水",
                price: 180),
            Product(
                id: "2",
                imageName: "coffee2",
                imageUrl: "https://files.elecdn.com/images/app_8bd64f25c5545b99c43e295/product/file_862d322c5587e7fbdc0aff0_s.jpg",
                name: "コーヒー",
                price: 130),
            Product(
                id: "3",
                imageName: "water2",
                imageUrl: "https://files.elecdn.com/images/app_8bd64f25c5545b99c43e295/product/file_b618d71d8c5ab3b8c198e50_s.jpg",
                name: "天然水",
                price: 200)
        ]
        var body: some Scene {
            WindowGroup {
                ContentView(products: products)
                    .onOpenURL { url in
                        _ = Elepay.handleOpenURL(url)
                    }
            }
        }
}
