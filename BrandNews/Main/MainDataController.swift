//
//  MainDataController.swift
//  BrandNews
//
//  Created by 박진수 on 08/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum NewsState: String {
    case bad = "bad"
    case good = "good"
}

enum Path: String {
    case newsList = "/access_news_list/"
}

class MainDataController: NSObject {
    static let baseUrl = "http://ec2-13-124-106-168.ap-northeast-2.compute.amazonaws.com:8080"
    
    static func getNews(brand: String, _ state: NewsState) -> [News] {
        let parameter = [
            "access_key": "ere",
            "brand_key": "ere",
            "brand_name": brand,
            "from": "2015-01-01",
            "top_count": "10",
            "until": "2019-05-14"
        ]
        var newsList: [News] = []
        Alamofire.request(baseUrl + "/analyze/access_news_list/" + state.rawValue, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil)
                 .validate()
                .responseJSON { response in
                    if response.result.isSuccess {
                        if let data = response.result.value {
                            let json = JSON(data)
                            for item in json["return_object"]["documents"].arrayValue {
                                newsList.append(News(title: item["title"].stringValue, content: item["content"].stringValue, company: item["provider"].stringValue))
                            }
                        }
                    }
                    else {
                        guard let error = response.result.error else { return }
                        print("\(error.localizedDescription)!!")
                    }
                
                }
        return newsList
    }
    

}
