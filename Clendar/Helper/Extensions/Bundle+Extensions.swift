//
//  Bundle+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 11/5/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension Bundle {
	// reference: https://stackoverflow.com/a/51241158
	public var icon: UIImage? {
		guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any] else { return nil }
		guard let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any] else { return nil }
		guard let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String] else { return nil }
		guard let lastIcon = iconFiles.last else { return nil }
		return UIImage(named: lastIcon)
	}
}
