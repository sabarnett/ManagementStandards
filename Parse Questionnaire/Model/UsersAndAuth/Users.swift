// Project: Parse Questionnaire
//
//  
//

import Foundation

class Users {
    
    public static let shared = Users()
    
    private var currentUser: User?
    private var userList: UserList!
    
    private init() {
        loadUserList()
    }
    
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
        let userIndex = userList.users.firstIndex(where: {$0.name.lowercased() == user.name.lowercased()})
        if let userIndex = userIndex {
            print("Save With Value: \(user.preferences.qaCardFilter)")

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
        // Remove the user from the list of users
        let userIndex = userList.users.firstIndex(where: {$0.name.lowercased() == userName.lowercased()})
        if let userIndex = userIndex {
            userList.users.remove(at: userIndex)
            saveUserList()
        }
        
        // Remove the user review file. This is the file containing the review data and has the
        // file name <username>-ReviewList. Itr is in the same folder as the user list.
        let reviewsFileURL = Reviews.reviewsFileName(userName: userName)
        if FileManager.default.fileExists(atPath: reviewsFileURL.absoluteString) {
            do {
                try FileManager.default.removeItem(atPath: reviewsFileURL.absoluteString)
            } catch {}
        }
    }
    
    // Mark:- Load/save user list
    private func loadUserList() {
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
    
    private func saveUserList() {
        let fileURL = usersFileName()
        
        do {
            let data = try JSONEncoder().encode(userList)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save data")
        }
    }
    
    private func usersFileName() -> URL {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return URL(fileURLWithPath: "UserList", relativeTo: directoryURL)
            .appendingPathExtension("json")
    }

}
