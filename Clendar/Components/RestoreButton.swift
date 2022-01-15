//
//  RestoreButton.swift
//  Clendar
//
//  Created by Vinh Nguyen on 15/01/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import Laden
import SwiftyStoreKit
import StoreKit

struct RestoreButton: View {
    @EnvironmentObject var store: SharedStore
    @Binding var isLoading: Bool
    @State private var isPurchasing: Bool = false

    var laden: some View {
        Laden.CircleLoadingView(
            color: .white, size: CGSize(width: 30, height: 30), strokeLineWidth: 3
        )
    }

    @ViewBuilder
    var loadingView: some View {
        if isLoading { laden }
        else { laden.hidden() }
    }

    var body: some View {
        Button(
            action: {
                genLightHaptic()
                restorePurschases()
            }, label: {})
            .overlay(loadingView)
            .disabled(isLoading)
            .buttonStyle(
                RestoreButtonStyle(title: "Restore Purchases")
            )
            .redacted(reason: isLoading ? .placeholder : [])
    }

    private func restorePurschases() {
        IAPHandler().restorePurchase()
    }
}
