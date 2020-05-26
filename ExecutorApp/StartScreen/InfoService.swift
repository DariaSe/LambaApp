//
//  InfoService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 29.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class InfoService {
    
    static let shared = InfoService()
    
    let placeholderImage = UIImage(named: "Portrait_Placeholder")
    
    private init() {
        userImage = placeholderImage
    }
    
    var userInfo: UserInfo?
    
    var userImage: UIImage? {
        didSet {
            delegate?.setImage(userImage)
        }
    }
    
    var delegate: UserImageDelegate?
    
    func getUserInfo(completion: @escaping (_ userInfo: UserInfo?, _ socialMediaImageURLs: [URL]?, _ errorMessage: String?) -> Void) {
        guard let token = Defaults.token else { return }
        var request = URLRequest(url: AppURL.checkInfoURL)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: AppURL.xAuthToken)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error as NSError? {
                    completion(nil, nil, error.localizedDescription)
                }
                else if
                    let data = data,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let user = jsonDict["user"] as? [String : Any] {
                    if let imageURLString = user["image"] as? String,
                        let imageURL = URL(string: imageURLString) {
                        UIImage.getImage(from: imageURL) { (image) in
                            self.userImage = image ?? UIImage(named: "Portrait_Placeholder")
                        }
                    }
                    let userInfo = UserInfo.initialize(from: user)
                    self.userInfo = userInfo
                    if
                        let socials = user["socialLinks"] as? [[String : Any]],
                        let socialTypes = socials.map({$0["socialType"] as? [String : Any]}) as? [[String : Any]],
                        let urlStrings = socialTypes.map({$0["image"] as? String}) as? [String],
                        let urls = urlStrings.map({URL(string: $0)}) as? [URL] {
                        completion(userInfo, urls, nil)
                    }
                    else {
                        completion(userInfo, nil, nil)
                    }
                }
                else {
                    completion(nil, nil, nil)
                }
            }
        }
        task.resume()
    }
}


protocol UserImageDelegate: AnyObject {
    func setImage(_ image: UIImage?)
}
