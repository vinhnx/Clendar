//
//  UIView+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 26/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation

extension UIView {

    /// Istantite view instance from nib
    ///
    /// - Returns: a view instance
    class func fromNib<T: UIView>() -> T? {
        let nib = String(describing: T.self)
        guard let result = Bundle.main.loadNibNamed(nib, owner: nil, options: nil)?.first as? T else {
            return nil
        }

        return result
    }

    /// Style modal with corner radiu
    func applyCornerRadius() {
        self.applyRound(4.0)
    }

    /// Make circle from view
    func applyCircle() {
        self.applyRound(self.frame.size.width / 2)
    }

    /// Apply round view with radius
    ///
    /// - Parameter radius: radius value
    func applyRound(_ radius: CGFloat) {
        self.applyRound(radius, borderColor: UIColor.clear, borderWidth: 1, addShadow: false)
    }

    /// Apply round view with radius gray color
    ///
    /// - Parameter radius: radius value
    func applyRoundGray(_ radius: CGFloat) {
        self.applyRound(radius, borderColor: UIColor.lightGray, borderWidth: 1, addShadow: false)
    }

    /// Apply round view shadow with offset shadow
    func applyRoundWithOffsetShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 8.0

        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = false
    }

    /// Apply round view
    ///
    /// - Parameters:
    ///   - radius: radius value
    ///   - borderColor: border color
    ///   - borderWidth: border width
    ///   - addShadow: should add shadow
    func applyRound(_ radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat, addShadow: Bool, shadowOffset: CGSize) {
        if addShadow {
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOffset = shadowOffset
            self.layer.shadowOpacity = 0.8
            self.layer.shadowRadius = 3.0
        }

        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = !addShadow
    }

    /// Apply round view
    ///
    /// - Parameters:
    ///   - radius: radius value
    ///   - borderColor: border color
    ///   - borderWidth: border width
    ///   - addShadow: should add shadow
    func applyRound(_ radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat, addShadow: Bool) {
        self.applyRound(radius, borderColor: borderColor, borderWidth: borderWidth, addShadow: addShadow, shadowOffset: .zero)
    }

    // MARK: - Cutout

    /// Apply cutout view mask on view
    ///
    /// - Parameter cutOutView: a view to apply
    func applyCutoutMaskWith(cutOutView: UIView) {
        let outerPath = UIBezierPath(rect: self.frame)

        let circlePath = UIBezierPath(ovalIn: cutOutView.frame)
        outerPath.usesEvenOddFillRule = true
        outerPath.append(circlePath)

        let maskLayer = CAShapeLayer()
        maskLayer.path = outerPath.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.fillColor = UIColor.white.cgColor

        self.layer.mask = maskLayer
    }

    /// Apply border
    ///
    /// - Parameter color: border color
    func applyBorder(color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
    }

    /// Remove any border
    func removeBorder() {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
        self.layer.masksToBounds = true
    }

    /// Style with drop shadow
    func applyDropshadow() {
        self.applyRound(3, borderColor: UIColor.white, borderWidth: 1, addShadow: true)
    }

    /// Remove drop shadow
    func removeDropshadow() {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOpacity = 0
        self.layer.shadowRadius = 0
    }
}
