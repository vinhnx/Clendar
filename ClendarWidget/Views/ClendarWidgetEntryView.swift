//
//  ClendarWidgetEntryView.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct ClendarWidgetEntryView: View {
    let entry: ClendarWidgetEntry

    var body: some View {
        ZStack {
            VStack {
                Text(entry.date.toMonthString.uppercased())
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.gray)
                Text(entry.date.toDayString)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color(.moianesD))
                Text(entry.date.toDateString)
                    .font(.system(size: 45, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

extension Date {
    var toDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }

    var toDayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }

    var toMonthString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}
