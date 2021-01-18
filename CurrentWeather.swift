//
//  CurrentWeather.swift
//  Stormy
//

import Foundation
//To access the UIImage class..
import UIKit

struct CurrentWeather: Codable
{
    let temperature: Double
    let humidity: Double
    let precipProbability: Double
    let summary: String
    
    //For showing an icon..
    let icon: String
  
}

extension CurrentWeather
{
    var iconImage: UIImage
    {
        //Return images icon.
        switch icon
        {
        case "clear-day": return #imageLiteral(resourceName: "clear-day")
        case "clear-night": return #imageLiteral(resourceName: "clear-night")
        case "cloudy": return #imageLiteral(resourceName: "cloudy")
        case "DarkSkyLogo": return #imageLiteral(resourceName: "DarkSkyLogo")
        case "fog": return #imageLiteral(resourceName: "fog")
        case "partly-cloudy-day": return #imageLiteral(resourceName: "partly-cloudy-day")
        case "partly-cloudy-night": return #imageLiteral(resourceName: "partly-cloudy-night")
        case "rain": return #imageLiteral(resourceName: "rain")
        case "snow": return #imageLiteral(resourceName: "snow")
        case "wind": return #imageLiteral(resourceName: "wind")
        case "sleet": return #imageLiteral(resourceName: "sleet")
        //..Default
        default: return #imageLiteral(resourceName: "default")
        }
        
    }
}

extension CurrentWeather {
    struct Key {
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let precipitationProbability = "precipProbability"
        static let summary = "summary"
        static let icon = "icon"
    }
    
    
    init?(json: [String: AnyObject]) {
        guard let tempValue = json[Key.temperature] as? Double,
            let humidityValue = json[Key.humidity] as? Double,
            let precipitationProbabilityValue = json[Key.precipitationProbability] as? Double,
            let summaryString = json[Key.summary] as? String,
            let iconString = json[Key.icon] as? String else {
                return nil
        }
        
        self.temperature = tempValue
        self.humidity = humidityValue
        self.precipProbability = precipitationProbabilityValue
        self.summary = summaryString
        self.icon = iconString
    }
}
















