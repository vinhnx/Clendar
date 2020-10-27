//
//  CreateEventViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit
import EasyClosure

enum CreateEventType {
    case create
    case edit
}

struct CreateEventViewModel {
    var text: String = ""
    var startDate: Date = Date()
    var endDate: Date?

    init(event: Event? = nil) {
        guard let event = event?.event else { return }
        text = event.title
        startDate = event.startDate
        endDate = event.endDate
    }
}

internal struct EventOverride {
    let text: String
    let startDate: Date
    let endDate: Date
}

class CreateEventViewController: BaseViewController {

    // MARK: - Callback

    var didUpdateEvent: ((InputParser.InputParserResult) -> Void)?

    // MARK: - Properties

    private lazy var workItem = WorkItem()

    var createEventType: CreateEventType = .create

    var viewModel = CreateEventViewModel()

    @IBOutlet private var startDateStackContainerView: UIView!

    @IBOutlet private var endDateStackContainerView: UIView!

    @IBOutlet private var startDatePicker: UIDatePicker! {
        didSet {
            if #available(iOS 13.4, *) {
                startDatePicker.preferredDatePickerStyle = .automatic
            }
        }
    }

    @IBOutlet private var endDatePicker: UIDatePicker! {
        didSet {
            if #available(iOS 13.4, *) {
                endDatePicker.preferredDatePickerStyle = .automatic
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
        bind(viewModel)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputTextField.becomeFirstResponder()
    }

    // MARK: - Private

    private func createNewEvent(_ override: EventOverride? = nil) {
        guard let input = inputTextField.text else { return dismiss() }
        guard input.isEmpty == false else { return dismiss() }
        guard let result = InputParser().parse(input) else { return }

        let override = EventOverride(
            text: result.action,
            startDate: startDatePicker.date,
            endDate: endDatePicker.date
        )

        EventHandler.shared.createEvent(override.text, startDate: override.startDate, endDate: override.endDate) { [weak self] in
            guard let self = self else { return }
            self.inputTextField.text = ""
            self.didUpdateEvent?(result)
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
            self.startDatePicker.date = result.startDate
            self.endDatePicker.date = result.endDate
        }
    }

    private func bind(_ viewModel: CreateEventViewModel) {
        inputTextField.text = viewModel.text

        startDatePicker.date = viewModel.startDate

        endDatePicker.isHidden = viewModel.endDate == nil

        if let endDate = viewModel.endDate {
            endDatePicker.date = endDate
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
