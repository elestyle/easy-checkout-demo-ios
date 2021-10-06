# Easy Checkout Demo for iOS

## elepay-ios-sdk （日本語）

**elepay iOS SDK** は elepay を iOS アプリに導入するための SDK です。
具体的な導入ガイドは以下の URLでご確認ください。
[→ elepay iOS SDK 導入ガイド](https://developer.elepay.io/docs/ios-sdk)

## Example について  

### 対応バージョン  

* 開発環境：Xcode 11 以降  
* CocoaPods 1.10.0 以降  

### テストについて

1. `.EasyCheckoutDemo/Data/AppConfig.swift` にある `pKey`、`sKey` は、[「elepay 管理画面」](https://dashboard.elepay.io)→ アプリ →「開発設定」→「API」にある「公開鍵」及び「秘密鍵」をご利用ください。  
  **Live Key** は `pk_live_`、`sk_live_` から始まるキーです。  
  **Test Key**（`pk_test_`、`sk_test_` から始まるキー）をご利用の場合は実際な決済アプリへ遷移せず決済完了することが出来ます。  

2. elepay をご利用のお客様は `apiBaseUrl` をそのまま変更しないてください。  
   Private SaaS をご利用のお客様は `apiBaseUrl` をご自身のEndpointへご変更ください

 > **ご注意：** 当 Demo は機能展示のため、「機密鍵」をアプリに保存していますが、本番環境の「秘密鍵」は必ずサーバー上のみ保存してください。  
 > 決済結果の最終確認も、SDK の返却結果ではなく、elepay サーバーから御社サーバーへの返却内容をご利用ください。

## elepay-ios-sdk (English)

**elepay iOS SDK** is made for your iOS Apps to easily import elepay multi-payment platform. For more details, please access the link below.  
[→ Import Guide for elepay iOS SDK](https://developer.elepay.io/docs/ios-sdk)

## About elepay Example

### Version Informations

* Xcode 11 and above
* CocoaPods 1.10.0 and above

### How to test

1. Make sure your replace `pKey` and `sKey` in `.EasyCheckoutDemo/Data/AppConfig.swift` with the key from ["elepay console"](https://dashboard.elepay.io) -> App -> "Develop Settings" -> "API" -> "Public Key" & "Secret Key".  
  **Live Key** is the key start with `pk_live_` or `sk_live_`  
  **Test Key** is the key start with `pk_test_` or `sk_test_`
2. If you are using elepay (if you are not sure than you are using elepay), please do not modify the value of `apiBaseUrl`.  
   For users who are using our Private SaaS service, you can modify `apiBaseUrl` to your own endpoint.

> **WARNING:** This Demo App has Secret Key writed in source code for easy starting. In real world usage, you should **NEVER** save "Secret Key" in your App for security reason, and you should **ALWAYS** verify payment result on your server site with elepay server.
