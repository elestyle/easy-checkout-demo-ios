# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def elepay_pods
  use_frameworks!

  pod 'ElepaySDK', '~> 3.1.0'
  pod 'Elepay_ChinesePayments_Plugin', '~> 2.0.1'
  # pod 'ElepaySDK', :path => '../elepay-pod'
  # pod 'ElePay_ChinesePayments_Plugin', :path => '../elepay-chinesepayments-plugin-pod'

  pod 'Braintree'
  pod 'Stripe'

end

target 'EasyCheckoutDemo' do
  elepay_pods
end
