//
//  IAPHandler.swift
//  Clendar
//
//  Created by Vinh Nguyen on 15/01/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftyStoreKit
import TPInAppReceipt

class IAPHandler: ObservableObject {
    @Published var isPurchasing = false

    // MARK: - Public

    func purchaseProduct(_ id: PurchaseProductIdentifier) {
        purchaseProduct(id.rawValue)
    }

    // swiftlint:disable:next cyclomatic_complexity
    func purchaseProduct(_ id: String) {
        guard !id.isEmpty else {
            logInfo("Empty IAP product ID")
            return
        }

        isPurchasing = true
        SwiftyStoreKit.purchaseProduct(id, atomically: true) { [weak self] result in
            guard let self = self else { return }
            defer { self.isPurchasing = false }

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

    private func hasPurchases() -> Bool {
        do {
            let receipt = try InAppReceipt.localReceipt()
            guard receipt.isValid else { return false }
            return receipt.hasPurchases
        } catch {
            logError(error)
            return false
        }
    }

    func hadPlus() -> Bool {
        hasPurchaseProduct(.plus)
    }

    func hasPurchaseProductID(_ productID: String) -> Bool {
        do {
            let receipt = try InAppReceipt.localReceipt()
            guard receipt.isValid else { return false }
            return receipt.containsPurchase(ofProductIdentifier: productID)
        } catch {
            logError(error)
            return false
        }
    }

    func hasPurchaseProduct(_ product: PurchaseProductIdentifier) -> Bool {
        do {
            let receipt = try InAppReceipt.localReceipt()
            guard receipt.isValid else { return false }
            return receipt.containsPurchase(ofProductIdentifier: product.rawValue)
        } catch {
            logError(error)
            return false
        }
    }

    func verifyReceipt(_ receipt: InAppReceipt) {
        do {
            try receipt.validate()
            logInfo("receipt verified!")
        } catch {
            // Do smth
            logError(error)
        }
    }

    func restorePurchase() {
        SwiftyStoreKit.restorePurchases { result in
            if !result.restoredPurchases.isEmpty {
                // scenario 1: check if purchase only plus product
//                let restoredPurchases = result.restoredPurchases
//                let restoredPurchaseIds = restoredPurchases.map(\.productId)
//                let plusPurchase = restoredPurchaseIds.first(where: { $0 == PurchaseProductIdentifier.plus.rawValue })
//                if plusPurchase != nil {
//                    logInfo("had \(PurchaseProductIdentifier.plus.rawValue)!")
//                    NotificationCenter.default.post(name: .inAppPurchaseSuccess, object: plusPurchase)
//                }

                // scenario 2: check if purcahse any product (included tip-jar)
                NotificationCenter.default.post(name: .inAppPurchaseSuccess, object: nil)
                logInfo("Purchases restored")
                return
            }

            if !result.restoreFailedPurchases.isEmpty {
                logInfo("Failed to restore purchases")
            }
        }
    }
}
