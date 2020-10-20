//
//  UIView+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 26/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    // MARK: - Autolayout

    func addSubViewAndFit(_ subView: UIView) {
        subView.prepareForAutolayout()
        self.prepareForAutolayout()
        self.addSubview(subView)
        subView.fitLayoutOnSuperView(self)
    }

    func prepareForAutolayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func fitLayoutOnSuperView(_ superView: UIView, insets: UIEdgeInsets = .zero) {
        self.prepareForAutolayout()

        let constraints: [NSLayoutConstraint]
        if #available(iOS 11.0, *) {
            constraints = [
                self.leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor, constant: insets.left),
                self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: insets.top),
                self.rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor, constant: insets.right),
                self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom)
            ]
        } else {
            constraints = [
                self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: insets.left),
                self.topAnchor.constraint(equalTo: superView.topAnchor, constant: insets.top),
                self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: insets.right),
                self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: insets.bottom)
            ]
        }

        NSLayoutConstraint.activate(constraints)
    }

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
        self.applyRound(radius, borderColor: UIColor.systemGray3, borderWidth: 1, addShadow: false)
    }

    func applyRoundWithOffsetShadow(backgroundColor: UIColor = .white) {
        self.backgroundColor = backgroundColor
        self.layer.shadowColor = UIColor.systemGray3.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false

        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = false
    }

    /// Apply round view shadow with offset shadow
    func applyRoundWithOffsetShadow() {
        self.applyRoundWithOffsetShadow(backgroundColor: .white)
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
            self.layer.shadowColor = UIColor.systemGray3.cgColor
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
