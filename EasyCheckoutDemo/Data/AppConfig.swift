//
// Created on 2020/11/17, by Yin Tan
// 
//

struct AppConfig {
    struct Elepay {
        let pKey: String
        let sKey: String
        let apiBaseUrl: String
    }

    // https://dashboard.elepay.io のアプリ → 開発設定 → API から
    //「公開鍵」を 'pKey' に設定してください
    //「秘密鍵」を 'sKey' に設定してください
    // elepay をご利用のお客様は 'apiBaseUrl' をそのまま変更しないてください
    // Private SaaS をご利用のお客様は 'apiBaseUrl' をご自身のEndpointへご変更ください

    static let elepay = Elepay(
        pKey: "pk_live_XXXXXXXXXXXXXXXXXXXXX",
        sKey: "sk_live_XXXXXXXXXXXXXXXXXXXXX",
        apiBaseUrl: "https://api.elepay.io")
}
