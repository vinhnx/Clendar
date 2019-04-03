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
    private var tableView = TableView(frame: .zero)
    private var events = [EKEvent]()

    // MARK: - Override

    override func setupViews() {
        super.setupViews()
        self.configureTableView()
        self.fetchEvents()
    }

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
        self.tableView.reloadData()
    }

    private func configureTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubViewAndFit(self.tableView)
        self.tableView.isScrollEnabled = false
        self.tableView.contentSizeDidChange = self.contentSizeDidChange
        self.tableView.separatorStyle = .none
        self.tableView.applyRoundWithOffsetShadow()
    }
}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let event = self.events[safe: indexPath.row]

        #warning("TODO: ")
        let date = event?.startDate != event?.endDate ? "\(event?.startDate.toHourAndMinuteString ?? "") to \(event?.endDate.toHourAndMinuteString ?? "")" : "\(event?.startDate.toHourAndMinuteString ?? "")"
        cell.textLabel?.text = "[\(date)] \(event?.title ?? "")"
        cell.textLabel?.font = FontConfig.regularFontWithSize(15)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        #warning("TODO")
        guard let event = self.events[safe: indexPath.row] else { return }
        log(event)
    }
}
