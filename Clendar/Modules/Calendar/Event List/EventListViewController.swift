//
//  EventListViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 29/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit
import EventKit

#warning("TODO: refactor")

final class EventListViewController: BaseViewController {

    // MARK: - Properties

    let cellID = "Cell"
    var contentSizeDidChange: SizeUpdateHandler?
    private var tableView = TableView(frame: .zero, style: .grouped)
    private var events = [EKEvent]()
    private lazy var headerView: UILabel = {
        let label = UILabel()
        label.textColor = .appDark
        label.font = UIFont.boldFontWithSize(15)
        label.text = Date().toFullDateString
        label.backgroundColor = .clear
        return label
    }()

    // MARK: - Override

    override func setupViews() {
        super.setupViews()

        view.backgroundColor = .backgroundColor
        tableView.backgroundColor = .backgroundColor
        configureTableView()
        fetchEvents()
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
        events = dataSource
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func updateHeader(_ date: Date) {
        headerView.text = date.toFullDateString
    }

    // MARK: - Private

    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(EventListTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubViewAndFit(tableView)
        tableView.isScrollEnabled = false
        tableView.contentSizeDidChange = contentSizeDidChange
        tableView.separatorStyle = .none
    }
}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? EventListTableViewCell else { return UITableViewCell() }
        guard let event = events[safe: indexPath.row] else { return cell }
        cell.configure(event: event)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        guard let event = events[safe: indexPath.row] else { return }
        presentAlertModal(iconText: "\(event.startDate.toDateString)", title: event.displayText, message: event.title)
    }
}
