import Foundation

// MARK: - Protocols

protocol ProfileListener: AnyObject {

    func onAccountExitProceed()

}

protocol ProfileInteractor: AnyObject {

}

// MARK: - Implementation

final class ProfileInteractorImpl: BaseInteractor, ProfileInteractor {

    // MARK: - Internal properties

    weak var view: ProfileView?

    // MARK: - Private properties

    private weak var listener: ProfileListener?
    private let userDataProvider: UserDataProvider

    // MARK: - Init

    init(userDataProvider: UserDataProvider, listener: ProfileListener? = nil) {
        self.userDataProvider = userDataProvider
        self.listener = listener
    }

    // MARK: - Internal methods

    override func start() {
        super.start()

        let vm = makeViewModel()
        view?.applyViewModel(vm)

        let onSucceed = { [weak self] in
            if let vm = self?.makeViewModel() {
                self?.view?.applyViewModel(vm)
            }
        }
        userDataProvider.updateData(onSucceed: onSucceed)
    }

    private func makeViewModel() -> ProfileViewModel {
        let post = userDataProvider.post ?? ""
        var name = userDataProvider.firstName ?? ""
        let lastName = userDataProvider.lastName ?? ""
        name += name.isEmpty ? lastName : " " + lastName

        return ProfileViewModel(profileImage: nil,
                                name: "Dmitry Timkin",
                                post: "Chief executive officer")
    }

}

// MARK: - Protocol ProfileViewEventHandler

extension ProfileInteractorImpl: ProfileViewEventHandler {

    func onExitButtonTap() {
        listener?.onAccountExitProceed()
    }

}
