//
//  WeatherModel.swift
//  Clima
//
//  Created by Katie McBratney on 8/16/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let city: String
    let temp: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temp)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...233:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 800...804:
            return "smoke"
        default:
            return "sun.max"
        }
    }
}
