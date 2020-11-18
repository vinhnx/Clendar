//
//  TableView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

class TableView: UITableView {
	var contentSizeDidChange: ((CGSize) -> Void)?

	override var contentSize: CGSize {
		didSet { contentSizeDidChange?(contentSize) }
	}
}
