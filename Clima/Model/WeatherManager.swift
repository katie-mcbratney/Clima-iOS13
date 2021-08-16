//
//  WeatherManager.swift
//  Clima
//
//  Created by Katie McBratney on 8/16/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=0dda4f4dcb70558596439a88ec20e0a6&units=imperial"

    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        self.performRequest(urlString)
    }
    
    func fetchWeather(lat: Double, lon: Double){
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString)
    }
        
    func performRequest(_ urlString: String){
        //1.Create a URL
        if let url = URL(string: urlString){
            //2. create url session
            let session = URLSession(configuration: .default)
            //give session a task
            let task = session.dataTask(with: url){(data, response, error) in
                if(error != nil) {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4.start task
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, city: name, temp: temp)
            return weather
            //let imageName = weather.conditionName
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
