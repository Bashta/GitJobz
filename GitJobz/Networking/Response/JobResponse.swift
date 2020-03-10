//
//  JobResponse.swift
//  GitJobz
//
//  Created by er on 2/28/20.
//  Copyright © 2020 b4sht4. All rights reserved.
//

import Foundation

struct JobResponse: Decodable {
    
    let id: String
    let type: String
    let url: String
    let created_at: String
    let company: String
    let company_url: String?
    let location: String
    let title: String
    let description: String
    let how_to_apply: String
    let company_logo: String?
    
}
