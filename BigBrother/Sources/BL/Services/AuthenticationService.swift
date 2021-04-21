import Foundation
import SwiftKeychainWrapper
import Alamofire

// MARK: - Protocols

protocol TokenProvider: AnyObject {

    var isTokenValid: Bool { get }
    var token: String? { get }

}

protocol AuthenticationService: TokenProvider {

    func authenticate(login: String,
                      password: String,
                      completion: ((AuthenticationResult) -> ())?)

    func signOut()

}

enum AuthenticationResult {

    case success
    case error(ErrorType)

    enum ErrorType {

        case invalidHost
        case invalidCredentials
        case serverError

    }

}

// MARK: - Implementation

final class AuthenticationServiceImpl: AuthenticationService {

    // MARK: - Private types

    private enum Constants {

        static var tokenKey: String {
            return "com.bigBrother.tokenKey"
        }

    }

    // MARK: - Private types

    @propertyWrapper
    private struct Token {
        let key: String

        var wrappedValue: String? {
            get {
                KeychainWrapper.standard.string(forKey: key)
            }
            set {
                guard let newValue = newValue else {
                    return
                }

                KeychainWrapper.standard.set(newValue, forKey: key)
            }
        }
    }

    // MARK: - Internal properties

    var isTokenValid: Bool {
        return validateToken()
    }

    @Token(key: Constants.tokenKey) private(set) var token

    // MARK: - Private properties

    private let serverHostProvider: ServerHostProvider

    // MARK: - Init

    init(serverHostProvider: ServerHostProvider) {
        self.serverHostProvider = serverHostProvider
    }

    // MARK: - Internal methods

    func authenticate1(login: String,
                      password: String,
                      completion: ((AuthenticationResult) -> ())? ) {
        guard
            let serverHost = serverHostProvider.serverHost,
            let url = URL(string: "https://\(serverHost)")
        else {
            return
        }

        let params = ["username": login, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        guard
            let httpBody = try? JSONSerialization.data(withJSONObject: params,
                                                       options: [])
        else {
            return
        }

        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion?(.error(.serverError))
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: String]
                self.token = json["accessToken"]
                self.token = json["refreshToken"]
            }
            catch {
                completion?(.error(.serverError))
            }

            completion?(.success)
        }.resume()
    }

    func authenticate(login: String,
                      password: String,
                      completion: ((AuthenticationResult) -> ())? ) {
        guard
            let serverHost = serverHostProvider.serverHost,
            let url = URL(string: "https://\(serverHost)/login")
        else {
            completion?(.error(.invalidHost))
            return
        }

        let parameters = ["username": login, "password": password]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { [weak self] response in

            switch response.result {
            case .success(let JSON):
                print("Success with JSON: \(JSON)")

                let response = JSON as! NSDictionary
                self?.token = response.object(forKey: "token") as? String
                completion?(.success)

            case .failure(let error):
                print("\n\n Request failed with error: \(error)")
                completion?(.error(.invalidCredentials))
            }

//            if let status = response.response?.statusCode {
//                switch status {
//                case 201:
//                    print("example success")
//
//                default:
//                    print("error with response status: \(status)")
//                }
//            }
//
//            if let result = response.value {
//                let JSON = result as! NSDictionary
//                print(JSON)
//            }
        }

    }

    func signOut() {
        token = nil
    }

    // MARK: - Private methods

    private func validateToken() -> Bool {
        guard let token = token, !token.isEmpty else {
            return false
        }

        return true
    }

}
