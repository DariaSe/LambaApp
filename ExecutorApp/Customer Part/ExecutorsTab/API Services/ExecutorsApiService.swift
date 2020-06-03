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
    
    func getExecutors(search: String, order: String, completion: @escaping ([Executor]?, String?) -> Void) {
        guard let request = URLRequest.signedGetRequest(url: AppURL.getExecutorsURL(page: page, limit: limit, search: search, order: order)) else { return }
        let task = URLSession.shared.dataTask(with: request) { [unowned self] (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error.localizedDescription)
                }
                else if
                    let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let executorsDict = jsonDict["executors"] as? [[String : Any]] {
                    let executors = executorsDict
                        .map { Executor.initialize(from: $0) }
                        .filter { $0 != nil }
                    self.isMore = executors.count == self.limit
                    completion(executors as? [Executor], nil)
                }
                else {
                    completion(nil, Strings.error)
                }
            }
        }
        task.resume()
    }
    
    func getExecutorDetails(executorID: Int, completion: @escaping (ExecutorDetails?, String?) -> Void) {
        guard let request = URLRequest.signedGetRequest(url: AppURL.getExecutorDetailsURL(executorID: executorID)) else { return }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error.localizedDescription)
                }
                else if
                    let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let executorDict = jsonDict["executor"] as? [String : Any] {
                    let executorDetails = ExecutorDetails.initialize(from: executorDict)
                    completion(executorDetails, nil)
                }
            }
        }
        task.resume()
    }
    
    func setFavorite(executorID: Int, completion: @escaping (Bool, String?) -> Void) {
        guard let request = URLRequest.signedPostRequest(url: AppURL.setFavorite(executorID: executorID), jsonDict: nil) else { return }
        let task = URLSession.shared.postRequestDataTask(with: request, completion: completion)
        task.resume()
    }
    
    func sendOrder(executorID: Int, orderDict: [String : Any], completion: @escaping (Bool, String?) -> Void) {
        
    }
}
