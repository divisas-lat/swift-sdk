import Foundation

public struct CountryResponse: Codable {
    public let code: String
    public let name: String
}

public struct RateData: Codable {
    public let currencyCode: String
    public let buy: Double
    public let sell: Double
    
    enum CodingKeys: String, CodingKey {
        case currencyCode = "currency_code"
        case buy
        case sell
    }
}

public struct TodayRatesResponse: Codable {
    public let country: String
    public let baseCurrency: String
    public let date: String
    public let rates: [RateData]?
    public let rate: RateData?
    
    enum CodingKeys: String, CodingKey {
        case country
        case baseCurrency = "base_currency"
        case date
        case rates
        case rate
    }
}

public struct ConversionResponse: Codable {
    public let country: String
    public let from: String
    public let to: String
    public let amount: Double
    public let result: Double
}

public struct HistoricalRateResponse: Codable {
    public let country: String
    public let baseCurrency: String
    public let currency: String
    public let from: String
    public let to: String
    public let data: [String: RateData]
    
    enum CodingKeys: String, CodingKey {
        case country
        case baseCurrency = "base_currency"
        case currency
        case from
        case to
        case data
    }
}

public struct StatsResponse: Codable {
    public let country: String
    public let baseCurrency: String
    public let currency: String
    public let period: String
    public let min: RateData
    public let max: RateData
    public let avg: RateData
    
    enum CodingKeys: String, CodingKey {
        case country
        case baseCurrency = "base_currency"
        case currency
        case period
        case min
        case max
        case avg
    }
}

public struct ForecastResponse: Codable {
    public let country: String
    public let baseCurrency: String
    public let currency: String
    public let forecast: [String: RateData]
    
    enum CodingKeys: String, CodingKey {
        case country
        case baseCurrency = "base_currency"
        case currency
        case forecast
    }
}

public struct PercentileResponse: Codable {
    public let country: String
    public let baseCurrency: String
    public let currency: String
    public let period: String
    public let percentile: Double
    
    enum CodingKeys: String, CodingKey {
        case country
        case baseCurrency = "base_currency"
        case currency
        case period
        case percentile
    }
}

public struct ErrorResponse: Codable {
    public let error: String?
    public let message: String?
}

public struct DivisasError: Error {
    public let statusCode: Int
    public let message: String
}
