//
//  WeatherData.swift
//  Clima
//
//  Created by Katie McBratney on 8/16/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    //let timezone: Int
    let sys : Sys
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}

struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}
