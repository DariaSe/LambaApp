//
//  ExecutorsApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ExecutorsApiService {
    
    var isMore: Bool = false
    
    var page: Int = 1
    var limit: Int = 30
    
    func getExecutors(search: String, order: String, completion: @escaping ([Executor]?, [URL]?, String?) -> Void) {
        guard let request = URLRequest.signedGetRequest(url: AppURL.getExecutorsURL(page: page, limit: limit, search: search, order: order)) else { return }
        let task = URLSession.shared.dataTask(with: request) { [unowned self] (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, nil, error.localizedDescription)
                }
                else if let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any], let executorsDict = jsonDict["executors"] as? [[String : Any]] {
                    let executors = executorsDict
                        .map { Executor.initialize(from: $0) }
                        .filter { $0 != nil }
                    self.isMore = executors.count == self.limit
                    let imageURLStrings = executorsDict
                        .map{ $0["image"] as? String }
                        .filter{$0 != nil} as! [String]
                    let imageURLs = imageURLStrings.map { URL(string: $0) } as? [URL]
                    completion(executors as? [Executor], imageURLs, nil)
                }
                else {
                    completion(nil, nil, Strings.error)
                }
            }
        }
        task.resume()
        
    }
    
    func getExecutorDetails(executorID: Int) {
        
    }
    
    func setFavorite(executorID: Int, completion: @escaping (Bool, String?) -> Void) {
        guard let request = URLRequest.signedGetRequest(url: AppURL.setFavorite(executorID: executorID)) else { return }
        let task = URLSession.shared.postRequestDataTask(with: request, completion: completion)
        task.resume()
        
    }
    
    func sendOrder(executorID: Int, orderDict: [String : Any]) {
        
    }
}
