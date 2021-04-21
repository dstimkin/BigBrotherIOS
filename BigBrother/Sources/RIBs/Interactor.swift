import Foundation

// MARK: - Protocol

public protocol Interactor: AnyObject {

    func start()
    func stop()

}

// MARK: - Implementation

open class BaseInteractor: Interactor {

    // MARK: - Public properties

    public private(set) var isActive: Bool = false

    //  MARK: - Init

    public init() {}

    //  MARK: - Deinit

    deinit {
        guard isActive else {
            return
        }

        assertionFailure("Interactor should be stopped before deiniting")
    }

    // MARK: - Open methods

    open func start() {
        assert(!isActive, "Interactor is expected to be inactive")
        isActive = true
    }

    open func stop() {
        assert(isActive, "Interactor is expected to be active")
        isActive = false
    }

}
