import Foundation

public class QueryBuilder {
    private let client: DivisasClient
    private var country: Country?
    private var currency: Currency?
    
    internal init(client: DivisasClient) {
        self.client = client
    }
    
    public func forCountry(_ country: Country) -> QueryBuilder {
        self.country = country
        return self
    }
    
    public func withCurrency(_ currency: Currency) -> QueryBuilder {
        self.currency = currency
        return self
    }
    
    private func getCountry() throws -> Country {
        guard let c = country else {
            throw DivisasError(statusCode: 400, message: "Country is required. Call forCountry() first.")
        }
        return c
    }
    
    public func getToday() async throws -> TodayRatesResponse {
        let c = try getCountry()
        var endpoint = "/\(c.rawValue)/rates"
        if let curr = currency {
            endpoint += "/\(curr.rawValue)"
        }
        
        return try await client.request(endpoint: endpoint)
    }
    
    public func convert(to: Currency, amount: Double) async throws -> ConversionResponse {
        let c = try getCountry()
        let endpoint = "/\(c.rawValue)/rates/convert"
        
        var queryItems = [
            URLQueryItem(name: "to", value: to.rawValue),
            URLQueryItem(name: "amount", value: String(amount))
        ]
        
        if let curr = currency {
            queryItems.append(URLQueryItem(name: "from", value: curr.rawValue))
        }
        
        return try await client.request(endpoint: endpoint, queryItems: queryItems)
    }
    
    public func getHistory(from: String? = nil, to: String? = nil) async throws -> HistoricalRateResponse {
        let c = try getCountry()
        guard let curr = currency else {
            throw DivisasError(statusCode: 400, message: "Currency is required for historical data.")
        }
        
        let endpoint = "/\(c.rawValue)/rates/history"
        var queryItems = [URLQueryItem(name: "currency", value: curr.rawValue)]
        
        if let from = from { queryItems.append(URLQueryItem(name: "from", value: from)) }
        if let to = to { queryItems.append(URLQueryItem(name: "to", value: to)) }
        
        return try await client.request(endpoint: endpoint, queryItems: queryItems)
    }
    
    public func getStats(period: String = "30d") async throws -> StatsResponse {
        let c = try getCountry()
        let endpoint = "/\(c.rawValue)/rates/stats"
        var queryItems = [URLQueryItem(name: "period", value: period)]
        
        if let curr = currency {
            queryItems.append(URLQueryItem(name: "currency", value: curr.rawValue))
        }
        
        return try await client.request(endpoint: endpoint, queryItems: queryItems)
    }
    
    public func getForecast(days: Int = 7) async throws -> ForecastResponse {
        let c = try getCountry()
        let endpoint = "/\(c.rawValue)/rates/forecast"
        var queryItems = [URLQueryItem(name: "days", value: String(days))]
        
        if let curr = currency {
            queryItems.append(URLQueryItem(name: "currency", value: curr.rawValue))
        }
        
        return try await client.request(endpoint: endpoint, queryItems: queryItems)
    }
    
    public func getPercentile(period: String = "1y") async throws -> PercentileResponse {
        let c = try getCountry()
        let endpoint = "/\(c.rawValue)/rates/percentile"
        var queryItems = [URLQueryItem(name: "period", value: period)]
        
        if let curr = currency {
            queryItems.append(URLQueryItem(name: "currency", value: curr.rawValue))
        }
        
        return try await client.request(endpoint: endpoint, queryItems: queryItems)
    }
}
