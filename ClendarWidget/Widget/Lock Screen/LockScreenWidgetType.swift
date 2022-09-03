//
//  LockScreenWidgetType.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 03/09/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

enum LockScreenWidgetTranslucentStyle {
    case all
    case content
}

enum LockScreenWidgetAlignment {
    case leading
    case trailing
}

enum LockScreenWidgetStyle {
    case translucent(LockScreenWidgetTranslucentStyle)
    case minimal(LockScreenWidgetAlignment)
    case line(LockScreenWidgetAlignment)
    case icon

}

enum LockScreenWidgetContentStyle {
    case nextEvent
    case counter
}
