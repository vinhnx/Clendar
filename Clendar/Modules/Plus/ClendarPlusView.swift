//
//  ClendarPlusView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 06/02/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import SwiftyStoreKit
import StoreKit
import Laden
import ConfettiSwiftUI

enum CosumablePurchaseProductIdentifier: String, CaseIterable {
    case tip1 = "com.vinhnx.clendar.iap.tip.one"
    case tip2 = "com.vinhnx.clendar.iap.tip.two"
    case tip3 = "com.vinhnx.clendar.iap.tip.three"
    case tip4 = "com.vinhnx.clendar.iap.tip.fourth"
}

struct PurchaseButton: View {
    @EnvironmentObject var store: Store
    @Binding var isLoading: Bool
    @State private var isPurchasing: Bool = false

    var model: SKProduct

    var laden: some View {
        Laden.CircleLoadingView(
            color: .white, size: CGSize(width: 30, height: 30), strokeLineWidth: 3
        )
    }

    @ViewBuilder
    var loadingView: some View {
        if isPurchasing { laden }
        else { laden.hidden() }
    }

    var body: some View {
        Button(
            action: {
                genLightHaptic()
                purchaseProduct(model.productIdentifier)
            }, label: {})
            .overlay(loadingView)
            .disabled(isLoading)
            .buttonStyle(
                PurchaseButtonStyle(title: model.localizedTitle, price: model.localizedPrice)
            )
            .redacted(reason: isLoading ? .placeholder : [])
    }

    // swiftlint:disable:next cyclomatic_complexity
    private func purchaseProduct(_ id: String) {
        guard !id.isEmpty else {
            logInfo("Empty IAP product ID")
            return
        }

        isPurchasing = true
        SwiftyStoreKit.purchaseProduct(id, atomically: true) { result in
            defer { isPurchasing = false }

            switch result {
            case .success(let purchase):
                logInfo("Purchase Success: \(purchase.productId)!")
                genSuccessHaptic()
                store.inAppPurchaseSuccess = true

            case .error(let error):
                genErrorHaptic()

                switch error.code {
                case .unknown: logInfo("Unknown error. Please contact support")
                case .clientInvalid: logInfo("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: logInfo("The purchase identifier was invalid")
                case .paymentNotAllowed: logInfo("The device is not allowed to make the payment")
                case .storeProductNotAvailable: logInfo("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: logInfo("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: logInfo("Could not connect to the network")
                case .cloudServiceRevoked: logInfo("User has revoked permission to use this cloud service")
                default: logInfo((error as NSError).localizedDescription)
                }
            }
        }
    }
}

struct ClendarPlusView: View {
    @EnvironmentObject var store: Store

    @State private var isLoading = false
    @State private var isPurchasing = false
    @State private var iapProducts = [SKProduct]()
    @State private var confettiCounter = 0

    @Binding var showView: Bool

    var buttonStack: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                Text("If you're feeling Clendar is helpful and would like to support the app development effort; like new features, extra themes, app icons in the future; tips are greatly appreciated. Any tip amount helps a lot, thank you very much!")
                    .font(.mediumFontWithSize(15))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                ForEach(iapProducts, id: \.self) { product in
                    PurchaseButton(isLoading: $isLoading, model: product)
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

                Button(
                    action: {
                        genLightHaptic()
                        showView = false
                    },
                    label: {
                        Image(systemName: "chevron.down")
                            .font(.boldFontWithSize(20))
                            .accessibility(label: Text("Collapse this view"))
                    }
                )
                .accentColor(.primaryColor)
                .keyboardShortcut(.escape)
                .hoverEffect()

            }

            ConfettiCannon(counter: $confettiCounter, repetitions: 5, repetitionInterval: 0.8)
        }
        .onReceive(store.$inAppPurchaseSuccess, perform: { (_) in
            confettiCounter += 1
        })
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
            }
            else {
                if case let invalidProductIDs = result.invalidProductIDs, !invalidProductIDs.isEmpty {
                    logInfo("Invalid product IDS: \(invalidProductIDs)")
                }

                DispatchQueue.main.async {
                    iapProducts = Array(result.retrievedProducts)
                }
            }
        }
    }
}
