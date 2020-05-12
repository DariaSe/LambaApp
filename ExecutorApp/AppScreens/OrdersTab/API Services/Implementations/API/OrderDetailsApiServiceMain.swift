//
//  OrderDetailsApiServiceMain.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 01.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class OrderDetailsApiServiceMain {
    
    var delegate: URLSessionDataDelegate?
    
    var orderID: Int?
    
    lazy var uploadSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: orderID?.string ?? "upload")
        return URLSession(configuration: configuration,
                          delegate: delegate,
                          delegateQueue: nil) }()
    
    
    func rejectOrder(orderID: Int, completion: @escaping (Bool, String?) -> Void) {
        guard let token = Defaults.token else { return }
        var request = URLRequest(url: AppURL.rejectOrderURL(orderID: orderID))
        request.httpMethod = "DELETE"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        let task = URLSession.shared.postRequestDataTask(with: request, completion: completion)
        task.resume()
    }
    
    func setOrderStatus(status: OrderStatus, orderID: Int, completion: @escaping (Bool, String?) -> Void) {
        var statusString: String?
        switch status {
        case .uploading: statusString = "upload"
        case .active: statusString = "active"
        default: break
        }
        let jsonDict: [String : Any] = ["orderId" : orderID, "newStatus" : statusString ?? ""]
        guard let request = URLRequest.signedPostRequest(url: AppURL.setOrderStatusURL(), jsonDict: jsonDict) else { return }
        let task = URLSession.shared.postRequestDataTask(with: request, completion: completion)
        task.resume()
    }
    
    func uploadVideo(orderID: Int, url: URL) {
        guard let token = Defaults.token else { return }
        self.orderID = orderID
        let parameters = [["key": "file", "src": url, "type": "file"],
                          ["key": "preview", "value": VideoService.generateThumbnail(path: url)!, "type": "text"]] as [[String : Any]]
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var data = Data()
        for param in parameters {
            let paramName = param["key"]!
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition:form-data; name=\"\(paramName)\"".data(using: .utf8)!)
            let paramType = param["type"] as! String
            if paramType == "text" {
                let paramValue = param["value"] as! String
                data.append("\r\n\r\n\(paramValue)\r\n".data(using: .utf8)!)
            } else {
                let paramSrc = param["src"] as! URL
                let fileData = try! Data(contentsOf: url)
                data.append(("; filename=\"\(paramSrc.absoluteString)\"\r\n" + "Content-Type: \"content-type header\"\r\n\r\n").data(using: .utf8)!)
                data.append(fileData)
                data.append("\r\n".data(using: .utf8)!)
            }
        }
        
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        var request = URLRequest(url: AppURL.uploadVideoURL(orderID: orderID))
        request.addValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "PUT"
        let dataURL = data.write(withName: "data.data")
        
        let task = uploadSession.uploadTask(with: request, fromFile: dataURL)
        task.resume()
    }
}
