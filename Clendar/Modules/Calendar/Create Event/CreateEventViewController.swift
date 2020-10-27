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

    private lazy var workItem = WorkItem()

    var didCreateEvent: ((InputParser.InputParserResult) -> Void)?

    @IBOutlet private var datePicker: UIDatePicker! {
        didSet {
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .automatic
            }
        }
    }

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

    private func parseDate(_ substring: String) {
        guard substring.isEmpty == false else { return }

        workItem.perform { [weak self] in
            guard let self = self else { return }
            guard let result = InputParser().parse(substring) else { return }
            let startDate = result.startDate
            self.datePicker.date = startDate
        }
    }
}

extension CreateEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let substring = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        parseDate(substring)
        return true
    }
}
