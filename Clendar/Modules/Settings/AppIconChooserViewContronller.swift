//
//  AppIconChooserViewContronller.swift
//  Clendar
//
//  Created by Vinh Nguyen on 11/3/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftyFORM
import UIKit

class AppIconChooserViewController: FormViewController {
    override func populate(_ builder: FormBuilder) {
        builder.navigationTitle = NSLocalizedString("Custom App Icon", comment: "")
        builder.demo_showInfo(NSLocalizedString("Choose your desired app icon", comment: ""))

        AppIcon.allCases.forEach { appIcon in
            let loader = CustomFormItem()
            loader.createCell = { _ in
                let cell = try AppIconItemCell.createCell()
                cell.iconImageView.image = appIcon.displayImage
                cell.titleLabel.text = appIcon.localizedText
                cell.accessoryType = SettingsManager.currentAppIcon == appIcon.rawValue ? .checkmark : .none
                cell.onSelected = {
                    SettingsManager.currentAppIcon = appIcon.rawValue
                    UIApplication.shared.setAlternateIconName(appIcon.iconName) { error in
                        if let error = error {
                            AlertManager.showWithError(ClendarError.mapFromError(error))
                        } else {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }

                return cell
            }

            builder += loader
        }
    }
}
