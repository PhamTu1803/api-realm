//
//  EpisodieModel.swift
//  API-Realm-Cd
//
//  Created by phamtu on 08/07/2021.
//

import UIKit

class EpisodeModel: NSObject {
    var id: Int = 0
    var name: String = ""
    var air_date: String = ""
    var episode: String = ""

    
    func initLoad(_ json:  [String: Any]) -> EpisodeModel{
        if let temp = json["id"] as? Int { id = temp }
        if let temp = json["name"] as? String { name = temp }
        if let temp = json["air_date"] as? String { air_date = temp }
        if let temp = json["episode"] as? String { episode = temp}
        return self
    }
}
