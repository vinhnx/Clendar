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
    var viewModel: ModalWrapperView
    @Environment(\.presentationMode) var presentationMode
    @State private var isLoading = false
    @State private var products = [SKProduct]()
    @State private var confettiCounter = 0

    var buttonStack: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                Spacer()
                Spacer()
                Text("🌟🌟🌟")
                    .multilineTextAlignment(.center)

                Text("Clendar+ is an one-time-purchase to access premium features. Basic functionality will remain free forever. You can verify and restore past in-app-purchases, if any, by tapping on the Restore button.")
                    .font(.mediumFontWithSize(15))
                    .foregroundColor(.gray)

                VStack(alignment: .leading) {
                    HStack(spacing: 5) {
                        Text("* ")
                        Text("Unlock extra features")
                    }

                    HStack(spacing: 5) {
                        Text("* ")
                        Text("One time purchase")
                    }

                    HStack(spacing: 5) {
                        Text("* ")
                        Text("Supporting Clendar's development")
                    }
                }
                .font(.boldFontWithSize(15))
                .gradientForeground(colors: [.red, .blue])
                .multilineTextAlignment(.center)

                VStack {
                    ForEach(products, id: \.self) { product in
                        PurchaseButton(
                            isLoading: $isLoading,
                            model: product
                        )
                            .padding()
                            .frame(maxWidth: .infinity)
                            .id(UUID())
                    }

                    RestoreButton()
                }
            }
        }.onAppear {
            IAPHandler().restorePurchase()
        }
    }

    var closeButton: some View {
        Button(
            action: {
                genLightHaptic()
                self.viewModel.closeAction()
            },
            label: {
                Image(systemName: "chevron.down")
                    .font(.boldFontWithSize(20))
                    .accessibility(label: Text("Collapse this view"))
            }
        )
        .accentColor(.appRed)
        .keyboardShortcut(.escape)
    }

    var titleLabel: some View {
        Text("Clendar+")
            .font(.boldFontWithSize(20))
            .gradientForeground(colors: [.red, .blue])
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                titleLabel
                buttonStack
                closeButton
            }

            ConfettiCannon(counter: $confettiCounter, repetitions: 5, repetitionInterval: 1.0)
        }
        .onReceive(NotificationCenter.default.publisher(for: .inAppPurchaseSuccess)) { (_) in
            genSuccessHaptic()
            confettiCounter += 1
            AlertManager.show(message: "You have Clendar+. Thanks for your support! 😊")
            Task {
                try await Task.sleep(nanoseconds: 5_000_000_000)
                presentationMode.wrappedValue.dismiss()
            }
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
        let productIDs = Set(PurchaseProductIdentifier.allCases.compactMap { $0.rawValue })

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

extension SKProduct: Identifiable {}
