//
//  JobViewModel.swift
//  GitJobz
//
//  Created by er on 3/2/20.
//  Copyright © 2020 b4sht4. All rights reserved.
//

import ReactiveSwift

class JobViewModel {
    
    let id: String
    let type: Property<String>
    let url: String
    let created_at: String
    let company: String
    let company_url: String?
    let location: String
    let title: Property<String>
    let description: Property<String>
    let how_to_apply: String
    let company_logo: Property<String?>
    
    init(withJobResponse jobResponse: JobResponse) {
        self.id = jobResponse.id
        self.type = Property(value: jobResponse.type)
        self.url = jobResponse.url
        self.created_at = jobResponse.created_at
        self.company = jobResponse.company
        self.location = jobResponse.location
        self.title = Property(value: jobResponse.title)
        self.description =  Property(value: jobResponse.description)
        self.company_url = jobResponse.company_url
        self.how_to_apply = jobResponse.how_to_apply
        self.company_logo = Property(value: jobResponse.company_logo)
    }
}

// MARK: - Hashable

extension JobViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: JobViewModel, rhs: JobViewModel) -> Bool {
        return rhs.id == lhs.id
    }
}
