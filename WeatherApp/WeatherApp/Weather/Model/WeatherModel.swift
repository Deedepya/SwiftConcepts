//
//  WeatherModels.swift
//  WeatherApp
//
//  Created by dedeepya reddy salla on 03/06/23.
//

import Foundation

struct WeatherModel: Codable {
    let id: Int
    let cod: Int
    let coord: Coordinates
    let weather: [SkyInfo]
    let base: String
    let main: Main
    let visibility: Int
    let dt: Int?
    let timezone: Int?
    let name: String?
}

struct Coordinates: Codable, EncodeConvertable {
    let lon: Double
    let lat: Double
}

struct SkyInfo: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct CurrentWeatherInfo: Codable, EncodeConvertable {
    var temperature: Double = 0.0
    var feelsLike: Double = 0.0
    var visibility: Double = 0.0
    var pressure: Double = 0.0
    var humidity: Double = 0.0
    var minTemp: Double = 0.0
    var maxTemp: Double = 0.0
    var skyImageUrl: String = ""
    var description: String = ""
    var cityName: String = ""
}
