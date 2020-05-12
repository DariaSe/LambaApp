//
//  FinancesApiServiceMain.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 12.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class FinancesApiServiceMain: FinancesApiService {
    
    func getFinances(completion: @escaping (FinancesInfo?, String?) -> Void) {
        guard let request = URLRequest.signedGetRequest(url: AppURL.financesInfoURL) else { return }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error.localizedDescription)
                }
                if let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    print(jsonDict)
                    completion(FinancesInfo.sample(), nil)
                }
                else {
                    completion(nil, Strings.error)
                }
            }
        }
        task.resume()
    }
    
    func getTransferDescription(completion: @escaping (_ info: String?, _ errorMessage: String?) -> Void) {
        guard let request = URLRequest.signedGetRequest(url: AppURL.transferDescriptionURL) else { return }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error.localizedDescription)
                }
                if let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    print(jsonDict)
                    completion("Some transfer description", nil)
                }
                else {
                    completion(nil, Strings.error)
                }
            }
        }
        task.resume()
    }
    
    func transferMoney(completion: @escaping (Bool, String?) -> Void) {
//        guard let request = URLRequest.signedGetRequest(url: AppURL.transferURL) else { return }
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    completion(false, error.localizedDescription)
//                }
//                if let data = data,
//                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
//                    print(jsonDict)
//                    completion(true, nil)
//                }
//                else {
//                    completion(false, Strings.error)
//                }
//            }
//        }
//        task.resume()
    }
}
