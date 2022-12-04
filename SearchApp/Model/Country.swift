//
//  Country.swift
//  SearchApp
//
//  Created by Mehmet Baturay Yasar on 04/06/2022.
//

import Foundation

struct Country: Codable {
    var name:String
    var currency: currency?
}

struct currency: Codable {
    var symbol: String?
    var code: String?
    var name: String?
}
