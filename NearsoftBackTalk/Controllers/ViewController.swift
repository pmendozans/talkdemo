//
//  ViewController.swift
//  NearsoftBackTalk
//
//  Created by Pablo Ruiz on 4/19/18.
//  Copyright © 2018 nearsoft. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var temperatureImage: UIImageView!
  
  private let weatherService = WeatherService()
  private var weatherTracker: WeatherTracker!
  private let baseLocation = CLLocationCoordinate2D(latitude: 29.1016613, longitude: -111.0077639)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    weatherTracker = WeatherTracker()
    trackWeather()
    //loadDataWithPromise()
    //loadDataWithCallback()
  }
  
  private func trackWeather() {
    weatherTracker.trackUserWeather { weather in
      self.cityLabel.text = weather.city
      self.countryLabel.text = weather.country
      if let temperature = weather.temperature {
        self.temperatureLabel.text = "\(temperature)"
        self.temperatureImage.image = IconHelper.getIcon(byTemperature: temperature)
      }
    }
  }

  private func loadDataWithPromise() {
    weatherService.getWeatherWithPromise(byLocation: baseLocation)
    .done { weather in
        print("Weather from Promise")
        print(weather)
    }
    .ensure {
      print("I'M ALWAYS CALLED")
    }
    .catch { error in
        print(error)
    }
  }
  
  private func loadDataWithCallback() {
    weatherService.getWeatherWithCallback(byLocation: baseLocation, serviceCompletion: { weather in
      print("Weather from callback")
      print(weather)
    })
  }
}

