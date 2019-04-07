//
//  EventListViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 29/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import EventKit
import Foundation

#warning("TODO: refactor")

final class EventListViewController: BaseViewController {

    // MARK: - Properties

    let cellID = "Cell"
    var contentSizeDidChange: SizeUpdateHandler?
    private var tableView = TableView(frame: .zero, style: .grouped)
    private var events = [EKEvent]()
    private lazy var headerView: UILabel = {
        let label = UILabel()
        label.font = FontConfig.boldFontWithSize(15)
        label.text = Date().toFullDateString
        label.backgroundColor = .white
        return label
    }()

    // MARK: - Override

    override func setupViews() {
        super.setupViews()
        self.configureTableView()
        self.fetchEvents()
    }

    // MARK: - Public

    func fetchEvents() {
        EventHandler.shared.fetchEventsForToday { [weak self] result in
            switch result {
            case .success(let value):
                self?.updateDataSource(value)
            case .failure(let error):
                logError(error)
            }
        }
    }

    func updateDataSource(_ dataSource: [EKEvent]) {
        self.events = dataSource
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func updateHeader(_ date: Date) {
        self.headerView.text = date.toFullDateString
    }

    // MARK: - Private

    private func configureTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubViewAndFit(self.tableView)
        self.tableView.isScrollEnabled = false
        self.tableView.contentSizeDidChange = self.contentSizeDidChange
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .white
    }
}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let event = self.events[safe: indexPath.row] else { return UITableViewCell() }

        #warning("TODO: ")
        var date = ""
        if event.isAllDay {
            date = "All day"
        } else {
            date = event.startDate != event.endDate ? "\(event.startDate.toHourAndMinuteString) to \(event.endDate.toHourAndMinuteString)" : "\(event.startDate.toHourAndMinuteString)"
        }

        cell.textLabel?.text = "[\(date)] \(event.title ?? "")"
        cell.textLabel?.font = FontConfig.regularFontWithSize(12)

        let view = UIView()
        view.backgroundColor = UIColor.init(cgColor: event.calendar.cgColor)
        view.frame = CGRect(x: 0, y: 0, width: 5, height: cell.frame.size.height)
        view.applyCornerRadius()
        cell.contentView.addSubview(view)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        #warning("TODO")
        guard let event = self.events[safe: indexPath.row] else { return }
        log(event)

        var date = ""
        if event.isAllDay {
            date = "All day"
        } else {
            date = event.startDate != event.endDate ? "\(event.startDate.toHourAndMinuteString) to \(event.endDate.toHourAndMinuteString)" : "\(event.startDate.toHourAndMinuteString)"
        }
        self.presentAlertModal(iconText: "\(event.startDate.toDateString)", title: date, message: event.title)
    }
}
