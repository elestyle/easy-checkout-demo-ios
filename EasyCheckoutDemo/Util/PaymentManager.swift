//
// Created on 2020/11/17, by Yin Tan
// 
//

import Foundation
import ElepaySDK

enum PaymentError: Error {
    case badApiResponse(String)
    case paymentFailure(ElepayError)
}

final class PaymentManager {

    static func checkout(
        amount: Int,
        products: [Any]?,
        from viewController: UIViewController,
        resultHandler: @escaping (Result<String, PaymentError>) -> Void
    ) {
        let url = "\(AppConfig.elepay.apiBaseUrl)/codes"
        var request = URLRequest(url: URL(string: url)!)
        var body: [String: Any] = [
            "amount": amount,
            "orderNo": UUID.init().uuidString,
        ]
        if let items = products {
            body["items"] = items
        }
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
        #if DEBUG
        if let reqBodyStr = String(data: bodyData!, encoding: .utf8) {
            print("checkout: " + reqBodyStr)
        }
        #endif
        request.httpBody = bodyData
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let auth = "\(AppConfig.elepay.sKey):".data(using: .utf8)?.base64EncodedString()
        let authString = "Basic \(auth ?? "")"
        request.setValue(authString, forHTTPHeaderField: "Authorization")

        let task = URLSession(configuration: URLSessionConfiguration.default)
            .dataTask(with: request) { (result, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                let err = PaymentError
                    .badApiResponse("Unknown response type \(response.debugDescription)")
                resultHandler(.failure(err))
                return
            }

            if error != nil || (httpResponse.statusCode / 100) != 2 || result == nil {
                let desc = error?.localizedDescription ?? String(httpResponse.statusCode)
                let reason: String
                if let errorJSON = try? JSONSerialization
                    .jsonObject(with: result!, options: []) as? [String: Any],
                   let code = errorJSON["code"] as? String,
                   let msg = errorJSON["message"] as? String {
                    reason = "Make Payment Failed: \(desc), Code: \(code), Message: \(msg)"
                } else {
                    reason = "Checkout Failed: \(desc)"
                }
                resultHandler(.failure(.badApiResponse(reason)))
                return
            }

            let checkoutJSON = try! JSONSerialization.jsonObject(with: result!, options: [])
                as! [String: Any]
            DispatchQueue.main.async {
                Elepay.checkout(checkoutJSON: checkoutJSON, from: viewController) { elepayRes in
                    switch elepayRes {
                    case .succeeded(_):
                        resultHandler(.success("Payment Succeed"))
                    case let .cancelled(id):
                        resultHandler(.success("Payment Cancelled. id: \(id)"))
                    case let .failed(_, error):
                        resultHandler(.failure(.paymentFailure(error)))
                    @unknown default:
                        break
                    }
                }
            }
        }
        task.resume()
    }
}
