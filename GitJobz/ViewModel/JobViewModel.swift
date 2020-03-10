//
//  JobViewModel.swift
//  GitJobz
//
//  Created by er on 3/2/20.
//  Copyright © 2020 b4sht4. All rights reserved.
//

import Foundation

class JobViewModel {
    
    let id: String
    
    
    init(withId id: String) {
        self.id = id
    }
    
}


// MARK: -

extension JobViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: JobViewModel, rhs: JobViewModel) -> Bool {
        return rhs.id == lhs.id
    }
}
