import Foundation

actor MemoryCache {
    private var store: [String: (value: Any, expiresAt: Date)] = [:]
    private let ttl: TimeInterval
    
    init(ttl: TimeInterval) {
        self.ttl = ttl
    }
    
    func get<T>(_ key: String) -> T? {
        guard let entry = store[key] else { return nil }
        
        if Date() > entry.expiresAt {
            store.removeValue(forKey: key)
            return nil
        }
        
        return entry.value as? T
    }
    
    func set<T>(_ key: String, value: T) {
        store[key] = (value, Date().addingTimeInterval(ttl))
    }
}
