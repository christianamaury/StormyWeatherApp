//
//  ViewController.swift
//  Stormy

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var CurrentTemperatureLabel: UILabel!
    @IBOutlet weak var CurrentHumidityLabel: UILabel!
    @IBOutlet weak var CurrentPrecipitationLabel: UILabel!
    @IBOutlet weak var CurrentWeatherIcon: UIImageView!
    @IBOutlet weak var CurrentSummaryLabel: UILabel!
    @IBOutlet var RefreshButton: UIButton!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    //New Refactor
    let client = DarkSkyAPIClient()
    
    //Adding the Dark Sky API Key to the constant
    //fileprivate let darkSkyApiKit = "aa2562040e62fefb140289541ec46e5e"
    
    //Adding the URL Link from the darkSky website
    //let forceCastURL = URL(string: "https://api.darksky.net/forecast/aa2562040e62fefb140289541ec46e5e/////37.8267,-122.4233")
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Calling method (Weather)
        getCurrentWeather()
        
    }
        
        /*
        let base = URL(string: "https://api.darkshy.net/forecast/\(darkSkyApiKit)/")
        
       guard let forecastURL = URL(string:"37.8267,-122.4233", relativeTo: base)
       
        //..If we don't have an URL object, we will exit the ViewDidLoad
        else
        {
            return
        }
        
        //Creating a Request
        let request = URLRequest(url: forecastURL)
        
        //Defines configuration behavior and policies, configuration object..
        //let configuration = URLSessionConfiguration.default
        //Coordinates a group of related network data transfer tasks
        let session = URLSession(configuration: .default)
        
        //Creating a dataTask
        //session.dataTask(with: request, completionHandler:)
        
        //Creating a Task, enclosure..
        let dataTask = session.dataTask(with: request) {data, response, error in}
        
        //Running the task.
        dataTask.resume()
        
        Force unwrap
        let weatherData = try! Data(contentsOf: forecastURL!)
        print(weatherData)
        
        //Takes the data y la convierte, como no es segura es un throwing one..
        //Returns a type any to work with
        let json = try! JSONSerialization.jsonObject(with: weatherData, options: [])
 
        
        let currentWeather = CurrentWeather(temperature: 85.50, humidity: 0.8,precipProbability: 0.1, summary: "Hot", icon: "clear-day")
        
        let viewModel = CurrentWeatherViewModel(model: currentWeather)
            
        //Calling method now
        displayWeather(using: viewModel)
        */
    
    //Function for displaying
    func displayWeather(using viewModel: CurrentWeatherViewModel)
    {
        CurrentTemperatureLabel.text = viewModel.temperature
        CurrentHumidityLabel.text = viewModel.humidity
        CurrentPrecipitationLabel.text = viewModel.precipitationProbability
        CurrentSummaryLabel.text = viewModel.summary
        CurrentWeatherIcon.image = viewModel.icon
    }
    
    
    @IBAction func getCurrentWeather()
    {
        toggleRefreshAnimation(on: true)
        
        client.getCurrentWeather(at: Coordinate.alcatrazIsland)
        { [unowned self] currentWeather, error in
            
            //print(currentWeather)
            //print(error)
            
            if let currentWeather = currentWeather
            {
                let viewModel = CurrentWeatherViewModel(model: currentWeather)
                self.displayWeather(using: viewModel)
                
                //Setting it to false
                self.toggleRefreshAnimation(on: false)
            }
        }
        
    }
    func toggleRefreshAnimation(on:Bool)
    {
        RefreshButton.isHidden = on
        
        //If its true, we start animating the indicator
        if on
        {
            ActivityIndicator.startAnimating()
        }
        //Its false..
        else
        {
            ActivityIndicator.stopAnimating()
        }
    }
    
}


















