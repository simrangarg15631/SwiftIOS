//
//  ApiModel.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 04/04/23.
//


//Open Weather API
import Foundation

struct ApiModel: Codable {
    
    var coord : Coordinates?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Double?
    var wind: Wind?
    var rain: Rain?
    var snow: Snow?
    var clouds: Clouds?
    var dt: Double?
    var sys: Sys?
    var timezone: Double?
    var id: Double?
    var name: String?
    var cod: Int
    
}

struct Coordinates: Codable{
    var lon : Double
    var lat : Double
}

struct Weather: Codable{
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Double
    var seaLevel: Double?
    var grndLevel: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

struct Wind: Codable{
    var speed: Double
    var deg: Double?
    var gust: Double?
}

struct Rain: Codable {
    var lh: Double?
    var bh: Double?
    
    enum Codingkeys: String, CodingKey{
        case lh = "1h"
        case bh = "3h"
    }
}
struct Snow: Codable {
    var lh: Double?
    var bh: Double?
    
    enum Codingkeys: String, CodingKey{
        case lh = "1h"
        case bh = "3h"
    }
}

struct Clouds: Codable{
    var all: Double
}

struct Sys: Codable{
    var type: Int?
    var id: Int?
    var message: String?
    var country: String?
    var sunrise: Double
    var sunset: Double
}

extension ApiModel{
    static let data: ApiModel = ApiModel(
        coord: Coordinates(lon: 0.0, lat: 0.0),
        weather: [Weather(id: 0, main: "", description: "", icon: "")],
        base: "",
        main: Main(temp: 0, feelsLike: 0, tempMin: 0, tempMax: 0, pressure: 0, humidity: 0),
        visibility: 0,
        wind: Wind(speed: 0),
        clouds: Clouds(all: 0),
        dt: 1680587835,
        sys: Sys(sunrise: 1680583945, sunset: 1680630330),
        timezone: 0,
        id: 0,
        name: "",
        cod: 200
    )
}
