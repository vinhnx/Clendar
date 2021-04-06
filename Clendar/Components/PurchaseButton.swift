//
//  PurchaseButton.swift
//  Clendar
//
//  Created by Vinh Nguyen on 06/02/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import Laden
import SwiftyStoreKit
import StoreKit

struct PurchaseButton: View {
    @EnvironmentObject var store: SharedStore
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
                NotificationCenter.default.post(name: .inAppPurchaseSuccess, object: nil)

            case .error(let error):
                switch error.code {
                case .paymentCancelled: break
                case .unknown: AlertManager.show(message: "Unknown error. Please contact support")
                case .clientInvalid: AlertManager.show(message: "Not allowed to make the payment")
                case .paymentInvalid: AlertManager.show(message: "The purchase identifier was invalid")
                case .paymentNotAllowed: AlertManager.show(message: "The device is not allowed to make the payment")
                case .storeProductNotAvailable: AlertManager.show(message: "The product is not available in the current storefront")
                case .cloudServicePermissionDenied: AlertManager.show(message: "Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: AlertManager.show(message: "Could not connect to the network")
                case .cloudServiceRevoked: AlertManager.show(message: "User has revoked permission to use this cloud service")
                default: AlertManager.show(message: (error as NSError).localizedDescription)
                }
            }
        }
    }
}
