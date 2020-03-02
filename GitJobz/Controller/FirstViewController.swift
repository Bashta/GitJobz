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
                self.updateDatasource(withViewmodels: viewModels)
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
    
}

// MARK: - UICollectionViewDelegate

extension FirstViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

// MARK: - Controller Setup

extension FirstViewController {
    
    func setupController() {
        registerCells()
        setupDatasource()
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
    }
    
}
