//
//  CurrentViewModel.swift
//  Stormy
//

import Foundation
import UIKit

//This actually format the date
struct  CurrentWeatherViewModel
{
    let temperature: String
    let humidity: String
    let precipitationProbability: String
    let summary: String
    
    let icon: UIImage

    //Overwriting initializer..
    
    init(model: CurrentWeather)
    {
        let roundedTemperature = Int(model.temperature)
        self.temperature = "\(roundedTemperature)º"
        let humidityPercentValue = Int(model.humidity * 100)
        
        self.humidity = "\(humidityPercentValue)"
        
        let precipitationPercentValue = Int(model.precipProbability * 100)
        
        self.precipitationProbability = "\(precipitationPercentValue)%"
        
        self.summary = model.summary
        self.icon    = model.iconImage
    }
}
