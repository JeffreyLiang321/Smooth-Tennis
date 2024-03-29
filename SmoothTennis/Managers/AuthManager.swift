//
//  AuthManager.swift
//  SmoothTennis
//
//  Created by Afraz Siddiqui on 3/20/21.
//

import FirebaseAuth
import Foundation

/// Object to manage authentication
final class AuthManager {
    /// Shared instanece
    static let shared = AuthManager()

    /// Private constructor
    private init() {}

    /// Auth reference
    private let auth = Auth.auth()

    /// Auth errors that can occur
    enum AuthError: Error {
        case newUserCreation
        case signInFailed
    }

    /// Determine if user is signed in
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    public var isSignedOut: Bool {
        return auth.currentUser == nil
    }

    /// Attempt sign in
    /// - Parameters:
    ///   - email: Email of user
    ///   - password: Password of user
    ///   - completion: Callback
    public func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        DatabaseManager.shared.findUser(with: email) { [weak self] user in
            guard let user = user else {
                completion(.failure(AuthError.signInFailed))
                return
            }

            self?.auth.signIn(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else {
                    completion(.failure(AuthError.signInFailed))
                    return
                }

                UserDefaults.standard.setValue(user.username, forKey: "username")
                UserDefaults.standard.setValue(user.email, forKey: "email")
                UserDefaults.standard.setValue(user.playerType, forKey: "playerType")
                UserDefaults.standard.setValue(user.playerLevel, forKey: "playerLevel")
                completion(.success(user))
            }
        }
    }

    /// Attempt new user sign up
    /// - Parameters:
    ///   - email: Email
    ///   - username: Username
    ///   - password: Password
    ///   - profilePicture: Optional profile picture data
    ///   - completion: Callback
    public func signUp(
        email: String,
        username: String,
        password: String,
        playerType: String, ///Changes
        playerLevel: String,
        profilePicture: Data?,
        certificatePicture: Data?,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        let newUser: User!
        if playerType == "Coach" {
            newUser = User(username: username, email: email, playerType: playerType, topComments: 0, playerLevel: "")
        }
        else {
            newUser = User(username: username, email: email, playerType: playerType, topComments: -1, playerLevel: playerLevel)
        }
        // Create account
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(.failure(AuthError.newUserCreation))
                return
            }

            DatabaseManager.shared.createUser(newUser: newUser) { success in
                if success {
                    StorageManager.shared.uploadProfilePicture(
                        username: username,
                        data: profilePicture
                    ) { uploadSuccess in
                        if uploadSuccess {
                            completion(.success(newUser))
                        }
                        else {
                            completion(.failure(AuthError.newUserCreation))
                        }
                    }
                    if playerType == "Coach" {
                        StorageManager.shared.uploadCertificatePicture(
                            username: username,
                            data: certificatePicture
                        ) { success in
                            if success {
                                completion(.success(newUser))
                            }
                            else {
                                completion(.failure(AuthError.newUserCreation))
                            }
                    }
                }
                else {
                    completion(.failure(AuthError.newUserCreation))
                }
            }
            }
        }
    }

    /// Attempt Sign Out
    /// - Parameter completion: Callback upon sign out
    public func signOut(
        completion: @escaping (Bool) -> Void
    ) {
        do {
            try auth.signOut()
            completion(true)
        }
        catch {
            //print(error)
            completion(false)
        }
    }
    
}
