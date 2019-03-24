/*
 MVVMCollectionViewController.swift
 
 Copyright (c) 2019 Alfonso Grillo
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

open class MVVMCollectionViewController<Model: CollectionViewViewModel>: UIViewController, CollectionViewViewModelOwner, UICollectionViewDataSource {
    
    @IBOutlet public weak var collectionView: UICollectionView! {
        didSet { collectionView.dataSource = self }
    }
    
    public typealias CustomViewModel = Model
    
    /// Override this method to bind your view model to the view
    open func bind(viewModel: Model) {
        
    }
    
    /**
     The view controller view model
     */
    open var viewModel: Model? {
        didSet { viewModel?.binder = self }
    }
    
    public var sections: [SectionViewModel] {
        return viewModel?.sections ?? []
    }
    
    // MARK: - UICollectionViewDataSource
    
    final public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    final public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = sections[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.identifier, for: indexPath)
        configureDelegate(of: cell)
        configure(view: cell, with: viewModel)
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section]
        let view: UICollectionReusableView
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let viewModel = section.headerViewModel else { return UICollectionReusableView() }
            view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewModel.identifier, for: indexPath)
            configure(view: view, with: viewModel)
        case UICollectionView.elementKindSectionFooter:
            guard let viewModel = section.footerViewModel else { return UICollectionReusableView() }
            view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewModel.identifier, for: indexPath)
            configure(view: view, with: viewModel)
        default:
            fatalError("Custom kinds for UICollectionReusableView are not supported yet")
        }
        
        configureDelegate(of: view)
        return view
    }
    
    open func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    open func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    open func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return nil
    }
    
    open func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        return IndexPath(item: 0, section: 0)
    }
}
