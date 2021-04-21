import Foundation

@propertyWrapper
struct CustomObjectStorage<Value: Codable> {

    // MARK: - Internal properties

    var wrappedValue: Value? {
        get {
            let optionalData = storage.object(forKey: key) as? Data
            guard let data = optionalData else {
                return nil
            }

            let value = try? JSONDecoder().decode(Value.self, from: data)
            return value
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            storage.set(data, forKey: key)
        }
    }

    // MARK: - Private properties

    private let key: String
    private let storage: UserDefaults

    // MARK: - Init

    init(key: String,
         storage: UserDefaults = .standard) {
        self.key = key
        self.storage = storage
    }

}
