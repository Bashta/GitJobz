//
//  JobsService.swift
//  GitJobz
//
//  Created by er on 3/2/20.
//  Copyright © 2020 b4sht4. All rights reserved.
//

import Alamofire

typealias JobsViewModelsCompletion = (Result<[JobViewModel], AFError>) -> Void

class JobsService {
    
    // MARK: - Repos
    
    private let jobsRepository: JobsRepository
    
    // MARK: - Singleton
    
    static let shared = JobsService()
    
    // MARK: - Lifecycle
    
    private init() {
        jobsRepository = JobsRepository()
    }
    
    // MARK: - Fetchers
    
    func fetchJobs(completion: @escaping JobsViewModelsCompletion) {
        
        jobsRepository.getJobs { result in
            switch result {
            case .success(let jobsResponses):
                let jobViemodels = jobsResponses.map { JobViewModel(withJobResponse: $0) }
                completion(.success(jobViemodels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
