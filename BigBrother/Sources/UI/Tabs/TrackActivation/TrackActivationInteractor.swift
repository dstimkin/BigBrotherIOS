import Foundation

// MARK: - Protocols

protocol TrackActivationInteractor: AnyObject {

}

// MARK: - Implementation

final class TrackActivationInteractorImpl: BaseInteractor, TrackActivationInteractor {

    // MARK: - Private types

    private enum Constants {

        static var numberOfSendingContacts: Int {
            return 50
        }

    }

    // MARK: - Internal properties

    weak var router: TrackActivationRouter?
    weak var view: TrackActivationView?

    // MARK: - Private properties

    private let hostProvider: ServerHostProvider
    private let tokenProvider: TokenProvider
    private let contactsStorage: ContactsStorage
    private var contactTracker: ContactTracker!

    // MARK: - Init

    init(hostProvider: ServerHostProvider,
         tokenProvider: TokenProvider,
         contactsStorage: ContactsStorage) {

        self.hostProvider = hostProvider
        self.tokenProvider = tokenProvider
        self.contactsStorage = contactsStorage
        super.init()
        self.contactTracker = BeaconContactTracker(delegate: self)
    }

    // MARK: - Internal Methods

    override func start() {
        super.start()

        let trackingActivated = contactsStorage.toggleState ?? false
        view?.activateTracking(trackingActivated)
        onTrackActivated(trackingActivated)
        view?.updateContacts(contactsStorage.lastContacts ?? [])
    }

    override func stop() {
        contactTracker.stopTracking()
        super.stop()
    }

    private func sendContactsToServer(_ contacts: [Contact]) {
        guard contacts.count > Constants.numberOfSendingContacts else {
            return
        }

        // TODO: - Send Contacts to server

        var updatedContacts = contacts
        updatedContacts.removeLast(Constants.numberOfSendingContacts)
        contactsStorage.unsentContacts = updatedContacts
    }

}

// MARK: - Protocol TrackActivationViewEventHandler

extension TrackActivationInteractorImpl: TrackActivationViewEventHandler {

    func onTrackActivated(_ activated: Bool) {
        activated ? contactTracker.startTracking() : contactTracker.stopTracking()
        contactsStorage.toggleState = activated
    }

}

// MARK: - Protocol ContactTrackerDelegate

extension TrackActivationInteractorImpl: ContactTrackerDelegate {

    func contactDidOccur(contact: Contact) {
        var lastContacts = contactsStorage.lastContacts ?? []
        var unsentContacts = contactsStorage.lastContacts ?? []
        lastContacts.insert(contact, at: 0)
        unsentContacts.insert(contact, at: 0)

        if lastContacts.count > 1000 {
            lastContacts.removeLast(lastContacts.count - 1000)
        }

        contactsStorage.lastContacts = lastContacts
        view?.updateContacts(lastContacts)
        sendContactsToServer(unsentContacts)
    }

    func trackingErrorDidOccur() {
        view?.showTrackingErrorAlert()
    }

}
