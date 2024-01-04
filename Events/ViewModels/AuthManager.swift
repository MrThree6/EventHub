

import Foundation
import Supabase

class AuthManager: ObservableObject {
    @Published var nameTextField: String = ""
    @Published var emailTextField: String = ""
    @Published var passwordTextField: String = ""
    @Published var dateOfBirthTextField: String = ""
    @Published var isEmailLoading: Bool = false
    @Published var isSignUpLoading: Bool = false
    @Published var goToRootView: Bool = false
    @Published var appUser: AppUser? = nil
    private let authApi: AuthApiProtocol = AuthApi(client: Shared.client)
    private let databaseApi: DatabaseApiProtocol = DatabaseApi(client: Shared.client)
    @Published var isAdmin: Bool = false
    @Published var isSignInLoading: Bool = false

    
    
    
    
    func signIn() {
        DispatchQueue.main.async {
            self.isSignInLoading = true
        }
        Task{
            if await emailValidatorSignIn(email: emailTextField).0 {
                do {
                    let uuid = try await authApi.signIn(email: emailTextField, password: passwordTextField)
                    let appUser = try await databaseApi.getUser(userId: uuid)
                    
                    
                    DispatchQueue.main.async {
                        self.isAdmin = appUser.isAdmin
                        self.isSignInLoading = false
                        self.appUser = appUser
                        self.goToRootView = true
                    }
                } catch {
                    print("SignInViewModel-signIn: \(error)")
                }
            }
        }
    }
    
    
    
    
    
    
    func signUp() {
        self.isSignUpLoading = true
        Task{
            if await isFormValid() {
                do {
                    let userUuid = try await authApi.signUp(email: emailTextField, password: passwordTextField)
                    let tempAppUser = AppUser(id: userUuid, name: nameTextField, email: emailTextField.lowercased(), isAdmin: isAdmin)
                    try await databaseApi.addNewUser(user: tempAppUser)
                    DispatchQueue.main.async {
                        self.isSignUpLoading = false
                        self.appUser = tempAppUser
                        self.goToRootView = true
                    }
                } catch {
                    // TODO: handle error
                    print("SignUpViewModel-signUp: \(error)")
                }
            }
        }
    }

    
    
    func emailValidatorSignIn(email: String) async -> (Bool, String) {
        DispatchQueue.main.async {
            self.isEmailLoading = true
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if emailPredicate.evaluate(with: email) {
            // Check email is not already taken
            let isRegistered = await authApi.isEmailTaken(email: email)
            DispatchQueue.main.async {
                self.isEmailLoading = false
            }
            if isRegistered {
                return (true, "")
            } else {
                return (false, "Email not found.")
            }
        } else {
            DispatchQueue.main.async {
                self.isEmailLoading = false
            }
            return (false, "Not valid email.")
        }
    }
    
    
    func emailValidatorSignUp(email: String) async -> (Bool, String) {
        DispatchQueue.main.async {
            self.isEmailLoading = true
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if emailPredicate.evaluate(with: email) {
            // Check email is not already taken
            let isTaken = await authApi.isEmailTaken(email: email)
            DispatchQueue.main.async {
                self.isEmailLoading = false
            }
            if isTaken {
                return (false, "Email already registered")
            } else {
                return (true, "")
            }
        } else {
            DispatchQueue.main.async {
                self.isEmailLoading = false
            }
            return (false, "Not valid email.")
        }
    }

    func passwordValidator(password: String) -> (Bool, String) {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        if passwordPredicate.evaluate(with: password) {
            return (true, "")
        }
        return (false, "Password should contain:\n\t- 8 Characters.\n\t- At least one digit")
    }

    private func isFormValid() async -> Bool {
        let isEmailValid = await emailValidatorSignUp(email: emailTextField).0
        let isPasswordValid = passwordValidator(password: passwordTextField).0
        return !nameTextField.isEmpty && isEmailValid && isPasswordValid
    }
    
}
