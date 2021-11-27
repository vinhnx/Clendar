//
//  ComplicationController.swift
//  ClendarWatchApp Extension
//
//  Created by Vinh Nguyen on 12/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import ClockKit
import SwiftUI
import EventKit
import Shift

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "Clendar", supportedFamilies: CLKComplicationFamily.allCases)
            // Multiple complication support can be added here with more descriptors
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        handler(Shift.shared.events.last?.startDate)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        Task {
            do {
                let response = try await Shift.shared.fetchEventsRangeUntilEndOfDay(from: Date())
                let clendarEvents = response.compactMap(ClendarEvent.init)
                if let template = self.makeTemplate(date: Date(), event: clendarEvents.first, complication: complication) {
                    handler(
                        CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
                    )
                } else {
                    handler(nil)
                }
            }
            catch {
                handler(nil)
            }
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after the given date
        let events = Shift.shared.events.compactMap(ClendarEvent.init)
        guard !events.isEmpty else {
            handler(nil)
            return
        }

        let fiveMinutes = 5.0 * 60.0
        var entries: [CLKComplicationTimelineEntry] = []
        var current = date
        let endDate = date.addingTimeInterval(3600.0)

        while (current.compare(endDate) == .orderedAscending) && (entries.count < limit) {
            if let nextEvent = events.first,
               let nextEKEvent = nextEvent.event,
               let nextEventDate = nextEKEvent.startDate,
               let ctemplate = self.makeTemplate(date: nextEventDate, event: nextEvent, complication: complication) {
                let entry = CLKComplicationTimelineEntry(
                    date: current,
                    complicationTemplate: ctemplate)
                entries.append(entry)
            }
            current = current.addingTimeInterval(fiveMinutes)
        }

        handler(entries)
    }

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        handler(makeTemplate(complication: complication))
    }
}

extension ComplicationController {
    func makeTemplate(
        date: Date = Date(),
        event: ClendarEvent? = nil,
        complication: CLKComplication
    ) -> CLKComplicationTemplate? {
        switch complication.family {
        case .graphicCircular:
            return CLKComplicationTemplateGraphicCircularView(ComplicationViewCircular(date: date))
        case .graphicCorner:
            return CLKComplicationTemplateGraphicCornerCircularView(ComplicationViewCircular(date: date))
        case .graphicRectangular:
            return event.flatMap { event in CLKComplicationTemplateGraphicRectangularFullView(ComplicationViewRectangular(event: event)) }
        default:
            return nil
        }
    }
}
