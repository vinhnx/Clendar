//
//  CreateEventViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit
import EasyClosure

class CreateEventViewController: BaseViewController {

    // MARK: - Properties

    var didCreateEvent: ((InputParser.InputParserResult) -> Void)?

    @IBOutlet private var closeButton: UIButton! {
        didSet {
            closeButton.on.tap { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true)
            }
        }
    }

    @IBOutlet private var saveButton: UIButton! {
        didSet {
            saveButton.on.tap { [weak self] in
                guard let self = self else { return }
                self.createNewEvent()
            }
        }
    }

    @IBOutlet private var scrollView: UIScrollView! {
        didSet {
            scrollView.backgroundColor = .backgroundColor
        }
    }

    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "New Event"
            titleLabel.numberOfLines = 0
            titleLabel.textColor = .appDark
            titleLabel.font = .boldFontWithSize(30)
        }
    }

    @IBOutlet private var inputTextField: TextField! {
        didSet {
            inputTextField.delegate = self
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputTextField.becomeFirstResponder()
    }

    // MARK: - Private

    private func createNewEvent() {
        guard let input = inputTextField.text else { return dismiss() }
        guard input.isEmpty == false else { return dismiss() }
        guard let result = InputParser().parse(input) else { return }

        EventHandler.shared.createEvent(result.action, startDate: result.startDate, endDate: result.endDate) { [weak self] in
            guard let self = self else { return }
            self.inputTextField.text = ""
            self.didCreateEvent?(result)
            self.dismiss()
        }
    }

    private func dismiss() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

}

extension CreateEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
