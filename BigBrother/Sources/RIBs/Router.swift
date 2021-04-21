import Foundation

// MARK: - Protocol

public protocol Router: AnyObject {

    func start()
    func stop()

}

// MARK: - Implementation

open class BaseRouter: Router {

    // MARK: - Public properties

    public private(set) var children: [Router] = []

    // MARK: - Private properties

    private var isActive = false
    private let interactor: Interactor

    // MARK: - Init

    public init(interactor: Interactor) {
        self.interactor = interactor
    }

    // MARK: - Deinit

    deinit {
        guard isActive else {
            return
        }

        assertionFailure("Router should be stopped before deiniting")
    }

    // MARK: - Open methods

    open func start() {
        assert(!isActive, "Router is expected to be inactive")
        isActive = true
        interactor.start()
    }

    open func stop() {
        assert(isActive, "Interactor is expected to be active")
        isActive = false
        interactor.stop()
    }

    // MARK: - Public methods

    public func attachChild(_ child: Router) {
        guard !children.contains(where: { $0 === child }) else {
            assertionFailure("Child is attached - \(child)")
            return
        }

        children.append(child)
        child.start()
    }

    public func detachChild(_ child: Router) {
        guard let index = children.firstIndex(where: { $0 === child }) else {
            assertionFailure("Child is not attached - \(child)")
            return
        }

        child.stop()
        children.remove(at: index)
    }

    public func detachChildren() {
        while !children.isEmpty {
            let child = children.removeFirst()
            child.stop()
        }
    }

}
