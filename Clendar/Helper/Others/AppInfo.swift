//
//  AppInfo.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/28/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct AppInfo {
	static var buildDate: Date? {
		guard let infoPath = Bundle.main.path(forResource: "Info.plist", ofType: nil) else {
			return nil
		}
		guard let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath) else {
			return nil
		}
		let key = FileAttributeKey(rawValue: "NSFileCreationDate")
		guard let infoDate = infoAttr[key] as? Date else {
			return nil
		}
		return infoDate
	}

	static var packageDate: String {
		guard let date = buildDate else { return "" }
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
		formatter.timeZone = TimeZone(abbreviation: "UTC")
		return formatter.string(from: date)
	}

	static var deviceName: String {
		if let key = "hw.machine".cString(using: String.Encoding.utf8) {
			var size: Int = 0
			sysctlbyname(key, nil, &size, nil, 0)
			var machine = [CChar](repeating: 0, count: Int(size))
			sysctlbyname(key, &machine, &size, nil, 0)
			return String(cString: machine)
		}

		return ""
	}

	static var appName: String {
		let mainBundle = Bundle.main
		let string0 = mainBundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
		let string1 = mainBundle.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
		let string = string0 ?? string1 ?? ""
		return string
	}

	static var appVersion: String {
		let mainBundle = Bundle.main
		let string0 = mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
		let string = string0 ?? ""
		return string
	}

	static var appBuild: String {
		let mainBundle = Bundle.main
		let string0 = mainBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
		let string = string0 ?? ""
		return string
	}

	static var appVersionAndBuild: String {
		"\(appVersion), build \(appBuild)"
	}

	static var systemVersion: String {
		UIDevice.current.systemVersion
	}
}
