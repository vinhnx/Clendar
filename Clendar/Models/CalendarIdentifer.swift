//
//  CalendarIdentifer.swift
//  Clendar
//
//  Created by Vinh Nguyen on 01/01/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import Foundation

enum CalendarIdentifier: Int, CaseIterable {
    case gregorian = 0
    case buddhist
    case chinese
    case coptic
    case ethiopicAmeteMihret
    case ethiopicAmeteAlem
    case hebrew
    case iso8601
    case indian
    case islamic
    case islamicCivil
    case japanese
    case persian
    case republicOfChina
    case islamicTabular
    case islamicUmmAlQura

    static var current: Self {
        // prioritize selected calendar identifier
        if let selectedCalendarIdentifier = CalendarIdentifier(rawValue: UserDefaults.selectedCalendarIdentifier) {
            return selectedCalendarIdentifier
        }

        // if non founded, map from system's Calendar identifier
        // otherwise, return Gregorian calendar
        return defaultCalendarIdentifier
    }

    static var defaultCalendarIdentifier: CalendarIdentifier {
        let currentSystemIdentifier = Calendar.autoupdatingCurrent.identifier
        let mapIdentifiers = CalendarIdentifier.allCases.map(\.identifier)
        if let matched = mapIdentifiers.first(where: { $0 == currentSystemIdentifier }) {
            return CalendarIdentifier.mapFromNativeCalendarIdentifier(matched)
        }

        return .gregorian
    }

    // swiftlint:disable:next cyclomatic_complexity
    static func mapFromNativeCalendarIdentifier(_ identifier: Calendar.Identifier) -> CalendarIdentifier {
        switch identifier {
        case .gregorian: return .gregorian
        case .buddhist: return .buddhist
        case .chinese: return .chinese
        case .coptic: return .coptic
        case .ethiopicAmeteMihret: return .ethiopicAmeteMihret
        case .ethiopicAmeteAlem: return .ethiopicAmeteAlem
        case .hebrew: return .hebrew
        case .iso8601: return .iso8601
        case .indian: return .indian
        case .islamic: return .islamic
        case .islamicCivil: return .islamicCivil
        case .japanese: return .japanese
        case .persian: return .persian
        case .republicOfChina: return .republicOfChina
        case .islamicTabular: return .islamicTabular
        case .islamicUmmAlQura: return .islamicUmmAlQura
        @unknown default: return .gregorian
        }
    }

    var calendar: Calendar {
        var instance = Calendar(identifier: identifier)
        instance.locale = Locale.autoupdatingCurrent // IMPORTANT
        if let firstWeekDayIndex = instance.weekdaySymbols.firstIndex(of: UserDefaults.firstWeekDay),
           firstWeekDayIndex != NSNotFound {
            // IMPORTANT: The weekday units are one-based. For Gregorian and ISO 8601 calendars, 1 is Sunday.
            instance.firstWeekday = firstWeekDayIndex + 1
        }
        
        return instance
    }

    var identifier: Calendar.Identifier {
        switch self {
        case .gregorian: return .gregorian
        case .buddhist: return .buddhist
        case .chinese: return .chinese
        case .coptic: return .coptic
        case .ethiopicAmeteMihret: return .ethiopicAmeteMihret
        case .ethiopicAmeteAlem: return .ethiopicAmeteAlem
        case .hebrew: return .hebrew
        case .iso8601: return .iso8601
        case .indian: return .indian
        case .islamic: return .islamic
        case .islamicCivil: return .islamicCivil
        case .japanese: return .japanese
        case .persian: return .persian
        case .republicOfChina: return .republicOfChina
        case .islamicTabular: return .islamicTabular
        case .islamicUmmAlQura: return .islamicUmmAlQura
        }
    }

    var shortDescription: String {
        switch self {
        case .gregorian: return NSLocalizedString("Gregorian", comment: "")
        case .buddhist: return NSLocalizedString("Buddhist", comment: "")
        case .chinese: return NSLocalizedString("Lunar calendar (Chinese calendar)", comment: "")
        case .coptic: return NSLocalizedString("Coptic", comment: "")
        case .ethiopicAmeteMihret: return NSLocalizedString("Ethiopic (Amete Mihret)", comment: "")
        case .ethiopicAmeteAlem: return NSLocalizedString("Ethiopic (Amete Alem)", comment: "")
        case .hebrew: return NSLocalizedString("Hebrew", comment: "")
        case .iso8601: return NSLocalizedString("ISO8601", comment: "")
        case .indian: return NSLocalizedString("Indian", comment: "")
        case .islamic: return NSLocalizedString("Islamic", comment: "")
        case .islamicCivil: return NSLocalizedString("Islamic civil", comment: "")
        case .japanese: return NSLocalizedString("Japanese", comment: "")
        case .persian: return NSLocalizedString("Persian", comment: "")
        case .republicOfChina: return NSLocalizedString("Republic of China", comment: "")
        case .islamicTabular: return NSLocalizedString("tabular Islamic", comment: "")
        case .islamicUmmAlQura: return NSLocalizedString("Islamic Umm al-Qura", comment: "")
        }
    }

}
