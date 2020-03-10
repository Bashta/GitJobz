//
//  JobsRepository.swift
//  GitJobz
//
//  Created by er on 2/28/20.
//  Copyright © 2020 b4sht4. All rights reserved.
//

import Alamofire

typealias JobsCompletion = (Result<[JobResponse], AFError>) -> Void

class JobsRepository {
    
    func getJobs(description: String? = nil, location: String? = nil, lat: Float? = nil, long: Float? = nil, fullTime: Bool = false, completion: @escaping JobsCompletion) {
        
        guard let url = URL(string: "https://jobs.github.com/positions.json") else {
            return
        }
        
        var params = Parameters()
        params["description"] = description
        params["location"] = location
        params["lat"] = lat
        params["long"] = long
        params["full_time"] = fullTime
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseDecodable { (response: DataResponse<[JobResponse], AFError>) in
            completion(response.result)
        }
    }
}
