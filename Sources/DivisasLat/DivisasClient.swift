import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public class DivisasClient {
    public let apiKey: String?
    public let baseUrl: String
    private let session: URLSession
    private let cache: MemoryCache
    
    public init(apiKey: String? = ProcessInfo.processInfo.environment["DIVISAS_API_KEY"],
                baseUrl: String = "https://api.divisas.lat/v1",
                cacheTtl: TimeInterval = 3600) {
        self.apiKey = apiKey
        self.baseUrl = baseUrl
        self.session = URLSession.shared
        self.cache = MemoryCache(ttl: cacheTtl)
    }
    
    public func query() -> QueryBuilder {
        return QueryBuilder(client: self)
    }
    
    public func getCountries() async throws -> [CountryResponse] {
        return try await request(endpoint: "/countries")
    }
    
    public func getCurrencies(country: Country) async throws -> [String] {
        return try await request(endpoint: "/\(country.rawValue)/currencies")
    }
    
    internal func request<T: Codable>(endpoint: String, queryItems: [URLQueryItem]? = nil) async throws -> T {
        var components = URLComponents(string: "\(baseUrl)\(endpoint)")!
        if let queryItems = queryItems, !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        let url = components.url!
        let cacheKey = url.absoluteString
        
        if let cached: T = await cache.get(cacheKey) {
            return cached
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("DivisasLat-SwiftSDK/1.0", forHTTPHeaderField: "User-Agent")
        
        if let apiKey = apiKey {
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw DivisasError(statusCode: 0, message: "Invalid response")
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            let errorMsg: String
            if let errorObj = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                errorMsg = errorObj.message ?? errorObj.error ?? "Unknown error"
            } else if let rawMsg = String(data: data, encoding: .utf8) {
                errorMsg = rawMsg
            } else {
                errorMsg = "Unknown error"
            }
            throw DivisasError(statusCode: httpResponse.statusCode, message: errorMsg)
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        
        await cache.set(cacheKey, value: result)
        
        return result
    }
}
