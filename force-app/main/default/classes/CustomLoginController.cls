public class CustomLoginController {
    public String username { get; set; }
    public String password { get; set; }
    public String errorMessage { get; set; }

    public PageReference login() {
         
        if (String.isBlank(username) || String.isBlank(password)) {
            errorMessage = 'Username and password are required.';
            return null;
        }

         
        PageReference loginResult = Site.login(username, password, '/home'); // Change '/home' to your desired redirect page
        
        if (loginResult == null) {
            errorMessage = 'Invalid username or password.';
            return null;
        } else {
            return loginResult;
        }
    }
}