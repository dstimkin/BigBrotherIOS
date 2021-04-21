import Foundation

@propertyWrapper
struct Storage<Value> {

    // MARK: - Internal properties

    var wrappedValue: Value? {
        get {
            return storage.value(forKey: key) as? Value
        }
        set {
            storage.setValue(newValue, forKey: key)
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
