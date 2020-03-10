//
//  FirstViewController.swift
//  GitJobz
//
//  Created by er on 2/28/20.
//  Copyright © 2020 b4sht4. All rights reserved.
//

import UIKit

enum JobsSection: Int, CaseIterable {
    case jobs = 0
    
    // MARK: - Localization
    
    var headerTitle: String {
        switch self {
        case .jobs:
            return "jobs_header_title".localized()
        }
    }
    
    var headerDescription: String {
        switch self {
        case .jobs:
            return "jobs_header_title_description".localized()
        }
    }
}

class FirstViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    private var dataSource: UICollectionViewDiffableDataSource<JobsSection, JobViewModel>!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupController()
            
        JobsService.shared.fetchJobs { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let viewModels):
                self.updateCollectionView(withViewmodels: viewModels)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Helpers

extension FirstViewController {
    
    func updateDatasource(withViewmodels viewModels: [JobViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<JobsSection, JobViewModel>()
        snapshot.appendSections(JobsSection.allCases)
        snapshot.appendItems(viewModels)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func updateCollectionView(withViewmodels viewModels: [JobViewModel]) {
         // Add all sections initially
         var snapshot = NSDiffableDataSourceSnapshot<JobsSection, JobViewModel>()
         snapshot.appendSections(JobsSection.allCases)
         snapshot.appendItems(viewModels, toSection: .jobs)

         dataSource.apply(snapshot, animatingDifferences: true)
     }
}

// MARK: - UICollectionViewDelegate

extension FirstViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


// MARK: - Collection View Layout

private extension FirstViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - Controller Setup

extension FirstViewController {
    
    func setupController() {
        registerCells()
        setupDatasource()
        
        // Create Layout
        collectionView.collectionViewLayout = createLayout()
        
    }
    
    func registerCells() {
        collectionView.register(JobCollectionViewCell.nib, forCellWithReuseIdentifier: JobCollectionViewCell.reuseId)
    }
    
    func setupDatasource() {
        collectionView.delegate = self
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {(collectionView, indexPath, viewModel) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobCollectionViewCell.reuseId, for: indexPath) as? JobCollectionViewCell else {
                return nil
            }

            cell.setupCell(withViewModel: viewModel, indexPath: indexPath)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                   guard kind == UICollectionView.elementKindSectionHeader else { return nil }
//                   let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
//                                                                                withReuseIdentifier: GenericHeaderCollectionReusableView.reuseIdentifier,
//                                                                                for: indexPath) as? GenericHeaderCollectionReusableView
//                   let section = DiscoverSection(rawValue: indexPath.section)
//                   header?.setup(withViewModel: self.viewModel, forDiscoverSection: section!)
                   return nil
               }
    }
    
}
