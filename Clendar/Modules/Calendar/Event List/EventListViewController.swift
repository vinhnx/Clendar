//
//  EventListViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 29/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

internal typealias DataSource = UICollectionViewDiffableDataSource<Section, Event>

final class EventListViewController: BaseViewController {

    // MARK: - Properties

    private lazy var collectionView = Layout.makeCollectionView()

    private lazy var datasource = makeDatasource()

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()

        fetchEvents()

        view.backgroundColor = .backgroundColor

        NotificationCenter.default.addObserver(forName: .EKEventStoreChanged, object: nil, queue: .main) { (_) in
            self.fetchEvents()
        }
    }

    // MARK: - Public

    func fetchEvents(for date: Date = Date()) {
        EventKitWrapper.shared.fetchEvents(for: date) { [weak self] events in
            guard let self = self else { return }
            let items = events.map(Event.init)
            self.applySnapshot(items, date: date)
        }
    }

    // MARK: - Datasource

    func makeDatasource() -> DataSource {
        let datasource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, event) in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventListItemCell.reuseID, for: indexPath) as? EventListItemCell
                let viewModel = EventListItemCell.ViewModel(event: event)
                cell?.viewModel = viewModel
                return cell
            }
        )

        datasource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let section = self.datasource.snapshot().sectionIdentifiers[indexPath.section]
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: EventSectionHeaderView.reuseID,
                for: indexPath) as? EventSectionHeaderView
            view?.titleLabel.text = section.date?.toFullDateString.uppercased()
            return view
        }

        return datasource
    }

    func applySnapshot(_ items: [Event], date: Date?) {
        guard let date = date else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Event>()
        let section = Section(date: date, events: items)
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        datasource.apply(snapshot, animatingDifferences: true, completion: nil)
    }

    private func setupLayout() {
        collectionView.backgroundColor = .backgroundColor

        // section header
        collectionView.register(
            EventSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: EventSectionHeaderView.reuseID
        )

        // cell
        collectionView.register(
            UINib(nibName: EventListItemCell.reuseID, bundle: nil),
            forCellWithReuseIdentifier: EventListItemCell.reuseID
        )

        collectionView.dataSource = datasource
        collectionView.delegate = self

        view.addSubViewAndFit(collectionView)
    }
}

extension EventListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let event = datasource.itemIdentifier(for: indexPath)?.event else { return }
        let eventViewer = EventViewerNavigationController(event: event, delegate: self)
        present(eventViewer, animated: true)
    }
}

extension EventListViewController: EKEventViewDelegate {
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.fetchEvents()
        }
    }
}
