//
//  AppIconChooserViewContronller.swift
//  Clendar
//
//  Created by Vinh Nguyen on 11/3/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit
import SwiftyFORM

class AppIconChooserViewController: FormViewController {
    override func populate(_ builder: FormBuilder) {
        builder.navigationTitle = "Custom App Icon"
        builder.demo_showInfo("Choose your desired app icon")

        AppIcon.allCases.forEach { (appIcon) in
            let loader = CustomFormItem()
            loader.createCell = { _ in
                let cell = try AppIconItemCell.createCell()
                cell.iconImageView.image = appIcon.displayImage
                cell.titleLabel.text = appIcon.text
                cell.accessoryType = SettingsManager.currentAppIconName == appIcon.text ? .checkmark : .none
                cell.onSelected = {
                    SettingsManager.currentAppIconName = appIcon.text
                    UIApplication.shared.setAlternateIconName(appIcon.iconName) { (error) in
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
