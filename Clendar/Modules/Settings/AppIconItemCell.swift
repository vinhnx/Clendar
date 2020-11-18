//
//  AppIconItemCell.swift
//  Clendar
//
//  Created by Vinh Nguyen on 11/3/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftyFORM
import UIKit

class AppIconItemCell: UITableViewCell, CellHeightProvider {
	// MARK: Internal

	@IBOutlet var titleLabel: UILabel!

	var xibHeight: CGFloat = 90

	var onSelected: (() -> Void)?

	@IBOutlet var iconImageView: UIImageView! { didSet { iconImageView.applyRound(10) } }

	static func createCell() throws -> AppIconItemCell {
		try Bundle.main.form_loadView("AppIconItemCell")
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		xibHeight = bounds.height
	}

	func form_cellHeight(indexPath _: IndexPath, tableView _: UITableView) -> CGFloat {
		xibHeight
	}

	// MARK: Private

	@IBAction private func didSelectView() {
		onSelected?()
	}
}
