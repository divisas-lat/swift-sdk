# Divisas.lat Swift SDK

Official Swift SDK for [Divisas.lat](https://divisas.lat) - The easiest way to get official exchange rates from Central Banks across Latin America.

## Installation

Add the package dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/divisas-lat/swift-sdk.git", from: "1.0.0")
]
```

Or add it via Xcode's Package Manager using the repository URL.

## Setup

The client will automatically look for the `DIVISAS_API_KEY` environment variable.

## Usage

```swift
import DivisasLat

// Must be called in an async context
Task {
    let client = DivisasClient()
    
    do {
        // Get all supported countries
        let countries = try await client.getCountries()
        
        // Query today's exchange rates
        let todayRates = try await client.query()
            .forCountry(.GT)
            .getToday()
            
        if let rate = todayRates.rate {
            print("Buy: \(rate.buy)")
        }
    } catch {
        print("Error: \(error)")
    }
}
```

### In-Memory Caching Built-in
The SDK uses an actor-based thread-safe memory cache (default TTL is 1 hour) to avoid hitting the API rate limits on consecutive requests.

## Publishing
See [PUBLISH_INSTRUCTIONS.md](PUBLISH_INSTRUCTIONS.md).
