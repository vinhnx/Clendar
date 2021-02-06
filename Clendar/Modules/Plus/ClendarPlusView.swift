//
//  ClendarPlusView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 06/02/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import ConfettiSwiftUI
import SwiftyStoreKit
import StoreKit

struct ClendarPlusView: View {
    @State private var isLoading = false
    @State private var products = [SKProduct]()
    @State private var confettiCounter = 0
    @State private var showView: Bool = false

    var buttonStack: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                Text("If you're feeling Clendar is helpful and would like to support the app development effort; like new features, extra themes, app icons in the future; tips are greatly appreciated. Any tip amount helps a lot, thank you very much!")
                    .font(.mediumFontWithSize(15))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                ForEach(products, id: \.self) { product in
                    PurchaseButton(
                        isLoading: $isLoading,
                        model: product
                    )
                    .padding()
                    .frame(maxWidth: .infinity)
                    .id(UUID())
                }
            }
        }
    }

    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Text("Tip Jar")
                    .font(.boldFontWithSize(20))
                    .gradientForeground(colors: [.red, .blue])

                buttonStack

                Text("Swipe down to dismiss")
                    .font(.mediumFontWithSize(13))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }

            ConfettiCannon(counter: $confettiCounter, repetitions: 5, repetitionInterval: 0.8)
        }
        .onReceive(NotificationCenter.default.publisher(for: .inAppPurchaseSuccess)) { (_) in
            confettiCounter += 1
            Popup.showSuccess("Tip received. Thank you so much and wish you have a nice day! 😊")
        }
        .onAppear {
            fetchIAPInfo()
        }

        .padding(20)
        .frame(maxWidth: .infinity)
        .preferredColorScheme(appColorScheme)
        .environment(\.colorScheme, appColorScheme)
    }

    // MARK: - Private

    private func fetchIAPInfo() {
        let productIDs = Set(CosumablePurchaseProductIdentifier.allCases.compactMap { $0.rawValue })

        isLoading = true
        SwiftyStoreKit.retrieveProductsInfo(productIDs) { result in
            defer { isLoading = false }

            if let error = result.error {
                logError(error)
                AlertManager.showWithError(error)
            }
            else {
                if case let invalidProductIDs = result.invalidProductIDs, !invalidProductIDs.isEmpty {
                    logInfo("Invalid product IDS: \(invalidProductIDs)")
                }

                DispatchQueue.main.async {
                    products = Array(result.retrievedProducts)
                }
            }
        }
    }
}
