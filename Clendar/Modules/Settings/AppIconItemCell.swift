//
//  AppIconItemCell.swift
//  Clendar
//
//  Created by Vinh Nguyen on 11/3/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit
import SwiftyFORM

class AppIconItemCell: UITableViewCell, CellHeightProvider {
    @IBOutlet var iconImageView: UIImageView! { didSet { iconImageView.applyRound(10) } }
    @IBOutlet var titleLabel: UILabel!

    var xibHeight: CGFloat = 90

    var onSelected: (() -> (Void))?

    static func createCell() throws -> AppIconItemCell {
        try Bundle.main.form_loadView("AppIconItemCell")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        xibHeight = bounds.height
    }

    func form_cellHeight(indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        xibHeight
    }

    @IBAction private func didSelectView() {
        onSelected?()
    }
}
