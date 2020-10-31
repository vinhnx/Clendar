//
//  ClendarWidgetEntryView.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import SwiftDate

struct PlaceholderView: View {
    var body: some View {
        ClendarWidgetEntryView(entry: ClendarWidgetEntry(date: Date()))
    }
}

struct ClendarWidgetEntryView: View {
    @Environment(\.widgetFamily) var family

    let entry: ClendarWidgetEntry

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
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
        default:
            ZStack {
                HStack {
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
                    }.padding(20)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

extension Date {
    var toDateString: String {
        toString(.custom("dd"))
    }

    var toDayString: String {
        toString(.custom("EEEE"))
    }

    var toMonthString: String {
        toString(.custom("MMMM"))
    }
}
