//
//  LunarSmallDateWidgetView.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 11/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct LunarSmallDateWidgetView: View {
    let entry: WidgetEntry

    var body: some View {
        VStack(alignment: .center) {
            Text(entry.date.toMonthString.localizedUppercase)
                .font(.boldFontWithSize(18))
                .foregroundColor(.gray)
            Text(entry.date.toFullDayString)
                .font(.boldFontWithSize(20))
                .foregroundColor(.appRed)
            Text(entry.date.toDateString)
                .font(.boldFontWithSize(45))
                .foregroundColor(.appDark)
            Text(DateFormatter.lunarDateString(forDate: entry.date))
                .font(.boldFontWithSize(20))
                .foregroundColor(.red)
        }.padding(.all)
    }
}
