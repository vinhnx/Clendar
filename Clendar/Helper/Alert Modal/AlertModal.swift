//
//  AlertModal.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import PanModal

class AlertView: UIView {

    // MARK: - Views

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldFontWithSize(20)
        label.textColor = .black
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontWithSize(15)
        label.textColor = .black
        return label
    }()

    let message: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontWithSize(13)
        label.textColor = .darkGray
        return label
    }()

    private lazy var alertStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, message])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4.0
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setupView()
        applyRoundWithOffsetShadow()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupView() {
        layoutIcon()
        layoutStackView()
    }

    private func layoutIcon() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: dateLabel.heightAnchor).isActive = true
    }

    private func layoutStackView() {
        addSubview(alertStackView)
        alertStackView.translatesAutoresizingMaskIntoConstraints = false
        alertStackView.topAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        alertStackView.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10).isActive = true
        alertStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14).isActive = true
        alertStackView.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
    }
}

class AlertViewController: UIViewController, PanModalPresentable {

    private let alertViewHeight: CGFloat = 68

    let alertView: AlertView = {
        let alertView = AlertView()
        alertView.layer.cornerRadius = 10
        return alertView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        alertView.heightAnchor.constraint(equalToConstant: alertViewHeight).isActive = true
    }

    func configure(dateText: String, title: String, message: String, backgroundColor: UIColor? = .white) {
        alertView.dateLabel.text = dateText
        alertView.titleLabel.text = title
        alertView.message.text = message
        alertView.backgroundColor = backgroundColor
    }

    // MARK: - PanModalPresentable

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(alertViewHeight)
    }

    var longFormHeight: PanModalHeight {
        return shortFormHeight
    }

    var backgroundAlpha: CGFloat {
        return 0.1
    }

    var shouldRoundTopCorners: Bool {
        return false
    }

    var showDragIndicator: Bool {
        return true
    }

    var anchorModalToLongForm: Bool {
        return false
    }

    var isUserInteractionEnabled: Bool {
        return true
    }
}

class TransientAlertViewController: AlertViewController {

    private weak var timer: Timer?
    private var countdown: Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        updateMessage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.countdown -= 1
            self?.updateMessage()
        }
    }

    @objc func updateMessage() {
        if countdown == 0 {
            invalidateTimer()
            dismiss(animated: true, completion: nil)
        }
    }

    func invalidateTimer() {
        timer?.invalidate()
    }

    deinit {
        invalidateTimer()
    }

    // MARK: - Pan Modal Presentable

    override var showDragIndicator: Bool {
        return false
    }

    override var anchorModalToLongForm: Bool {
        return true
    }

    override var backgroundAlpha: CGFloat {
        return 0.0
    }

    override var isUserInteractionEnabled: Bool {
        return false
    }
}
