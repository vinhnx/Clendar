//
//  EventListViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 29/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import EventKit
import EventKitUI
import UIKit
import Shift

internal typealias DataSource = UICollectionViewDiffableDataSource<Section, ClendarEvent>

final class EventListViewController: BaseViewController {
	// MARK: Internal

	override func viewDidLoad() {
		super.viewDidLoad()
		setupLayout()

		fetchEvents()

		view.backgroundColor = .backgroundColor

		NotificationCenter.default.addObserver(forName: .EKEventStoreChanged, object: nil, queue: .main) { _ in
			self.fetchEvents()
		}
	}

	func fetchEvents(for date: Date = Date()) {
		Shift.shared.fetchEvents(for: date) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case let .success(events):
				let items = events.compactMap(ClendarEvent.init)
				self.applySnapshot(items, date: date)

			case let .failure(error): AlertManager.showWithError(error)
			}
		}
	}

	func makeDatasource() -> DataSource {
		DataSource(
			collectionView: collectionView,
			cellProvider: { collectionView, indexPath, event in
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventListItemCell.reuseID, for: indexPath) as? EventListItemCell
				let viewModel = EventListItemCell.ViewModel(event: event)
				cell?.viewModel = viewModel
				return cell
			}
		)
	}

	func applySnapshot(_ items: [ClendarEvent], date: Date?) {
		guard let date = date else { return }
		var snapshot = NSDiffableDataSourceSnapshot<Section, ClendarEvent>()
		let section = Section(date: date, events: items)
		snapshot.appendSections([section])
		snapshot.appendItems(items, toSection: section)
		datasource.apply(snapshot, animatingDifferences: true, completion: nil)
	}

	// MARK: Private

	private lazy var collectionView = Layout.makeCollectionView()

	private lazy var datasource = makeDatasource()

	private func setupLayout() {
		collectionView.backgroundColor = .backgroundColor

		// cell
		collectionView.register(
			UINib(nibName: EventListItemCell.reuseID, bundle: nil),
			forCellWithReuseIdentifier: EventListItemCell.reuseID
		)

		collectionView.dataSource = datasource
		collectionView.delegate = self

		view.addSubViewAndFit(collectionView)

		// add menu context
		let interaction = UIContextMenuInteraction(delegate: self)
		view.addInteraction(interaction)
	}
}

extension EventListViewController: UICollectionViewDelegate {
	func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		genLightHaptic()
		guard let event = datasource.itemIdentifier(for: indexPath) else { return }
		EventHandler.viewEvent(event, delegate: self)
	}
}

extension EventListViewController: EKEventViewDelegate {
	func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
		controller.dismiss(animated: true) { [weak self] in
			guard let self = self else { return }
			guard action != .done else { return }
			self.fetchEvents(for: controller.event.startDate)
		}
	}
}

extension EventListViewController: UIContextMenuInteractionDelegate {
	func contextMenuInteraction(_: UIContextMenuInteraction, configurationForMenuAtLocation _: CGPoint) -> UIContextMenuConfiguration? {
		nil
	}

	func collectionView(_: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point _: CGPoint) -> UIContextMenuConfiguration? {
		guard let event = datasource.itemIdentifier(for: indexPath) else { return nil }
		guard let ekEvent = event.event else { return nil }

		return UIContextMenuConfiguration(identifier: nil, previewProvider: {
			EventViewerViewController(event: ekEvent)
		}, actionProvider: { _ in
			let view = UIAction(title: NSLocalizedString("View Event", comment: ""), image: UIImage(systemName: "viewfinder")) { _ in
				EventHandler.viewEvent(event, delegate: self)
			}

			let edit = UIAction(title: NSLocalizedString("Edit Event", comment: ""), image: UIImage(systemName: "pencil")) { _ in
				EventHandler.editEvent(event, delegate: self)
			}

			let delete = UIAction(title: NSLocalizedString("Delete Event", comment: ""), image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
				EventHandler.deleteEvent(event)
			}

			return UIMenu(children: [view, edit, delete])
		})
	}
}

extension EventListViewController: EKEventEditViewDelegate {
	func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
		dismiss(animated: true) { [weak self] in
			guard let self = self else { return }
			guard action != .canceled else { return }
			guard let event = controller.event else { return }
			self.fetchEvents(for: event.startDate)
		}
	}
}
