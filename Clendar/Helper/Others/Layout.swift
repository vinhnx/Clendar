//
//  Layout.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit

/*
 Diffable datasource and compositional layout:
 + https://www.donnywals.com/modern-table-views-with-diffable-data-sources/
 + https://www.swiftbysundell.com/articles/building-modern-collection-views-in-swift/
 */

enum CompositionalLayoutType {
    case grid
    case list
}

class Layout {
    static func makeCollectionView(type: CompositionalLayoutType = .list) -> UICollectionView {
        let layout = makeCollectionViewCompositionalLayout(type: type)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }

    static func makeGridLayoutSection() -> NSCollectionLayoutSection {
        // Each item will take up half of the width of the group
        // that contains it, as well as the entire available height:
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)
        ))

        // Each group will then take up the entire available
        // width, and set its height to half of that width, to
        // make each item square-shaped:
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.5)
            ),
            subitem: item,
            count: 2
        )

        return NSCollectionLayoutSection(group: group)
    }

    static func makeListLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)))
        let inset: CGFloat = 10
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: 0, bottom: 0, trailing: 0)

        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 10

        // Supplementary header view setup
        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(20)
        )

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    static func makeCollectionViewCompositionalLayout(
        type: CompositionalLayoutType = .list
    ) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (_, _) in
            switch type {
            case .grid:
                return makeGridLayoutSection()
            case .list:
                return makeListLayoutSection()
            }
        }
    }
}
