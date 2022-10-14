// Project: Management Standards
//
//  Singleton class used to handle all things "User" related
//

import Foundation

class Users {
    
    public static let shared = Users()
    
    private var currentUser: User?
    private var userList: UserList!
    
    private init() {
        loadUserList()
    }
    
    // MARK: - Pubic interface
    
    /// Returns the currently logged in user details
    ///
    ///  - Returns: The current user details or nil if there is no logged in user
    var loggedInUser: User? {
        get {
            return currentUser
        }
        set { }
    }
    
    /// Signin the specified user. We fetch the user detaiols and assign them to the internal currentUser
    /// variable.
    ///
    /// - Parameter userName: The name of the user to signin
    ///
    func signin(userName: String) {
        currentUser = userList.users.first(where: { $0.name.lowercased() == userName.lowercased()})
    }
    
    /// Signs the usre out, clearing the currently logged in user details
    func signout() {
        currentUser = nil
    }
    
    /// Fetch the secified user from the users list
    ///
    /// - Parameter userName: The name of the user to fetch.
    ///
    /// - Returns: A populated User object if the user was found, or Nil if the usrer does not exist.
    ///
    func get(userName: String) -> User? {
        return userList.users.first(where: { $0.name.lowercased() == userName.lowercased()})
    }
    
    /// Saves the specified user to the list of users.
    ///
    /// - Parameter user: A populated User object. It is assumed that the password field has been
    /// properly encoded at the point of save.
    ///
    func save(_ user: User) {
        loadUserList()
        
        let userIndex = userList.users.firstIndex(where: {$0.name.lowercased() == user.name.lowercased()})
        if let userIndex = userIndex {
            // Replace this user
            userList.users[userIndex] = user
            userList.users[userIndex].updated = Date.now
        } else {
            userList.users.append(user)
        }
        
        // Save the user to the users array and serialise.
        saveUserList()
    }
    
    /// Removes a user from the user list
    ///
    /// - Parameter user: The user name to be removed
    ///
    func remove(userName: String) {
        Reviews.shared.remove(forUser: userName)

        loadUserList()
        
        let userIndex = userList.users.firstIndex(where: {$0.name.lowercased() == userName.lowercased()})
        if let userIndex = userIndex {
            userList.users.remove(at: userIndex)
            saveUserList()
        }        
    }
    
    /// Updates the logged in user to change the first name, last name and email address. After the changes have been
    /// made, they will be persisted to disk.
    ///
    /// - Parameters:
    ///   - firstname: The users first name
    ///   - lastname: The users last name
    ///   - email: The users email address.
    ///
    func updateLoggedInUser(firstname: String, lastname: String, email: String) {
        guard let user = currentUser else { return }

        user.firstname = firstname
        user.lastname = lastname
        user.email = email
        
        save(user)
        signin(userName: user.name)
    }
    
    /// Updates the current userrs password. It is assumed that the password has been validated before we update it, so
    /// no additional validation is done here.
    ///
    /// - Parameter newPassword: The new, encrypted, password for the user.
    ///
    func updateLoggedInPassword(newPassword: String) {
        guard let user = currentUser else { return }

        user.password = newPassword
        
        save(user)
        signin(userName: user.name)
    }
    
    // MARK: - Load/save user list

    fileprivate func loadUserList() {
        // Find and load the user list. If it doesn't exist, create it
        let fileURL = usersFileName()
        
        do {
            // Get the saved data
            let savedData = try Data(contentsOf: fileURL)
            
            // Decode the data file
            userList = try JSONDecoder().decode(UserList.self, from: savedData)
        } catch {
            // Assume file not found, create dummy file
            userList = UserList(users: [])
        }
    }
    
    fileprivate func saveUserList() {
        let fileURL = usersFileName()
        
        do {
            let data = try JSONEncoder().encode(userList)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save data")
        }
    }
    
    // MARK: - File name generation

    fileprivate func usersFileName() -> URL {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return URL(fileURLWithPath: "UserList", relativeTo: directoryURL)
            .appendingPathExtension("json")
    }

}
