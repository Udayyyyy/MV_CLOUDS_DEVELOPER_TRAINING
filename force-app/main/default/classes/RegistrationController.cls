public class RegistrationController {
    public String username { get; set; }
    public String email { get; set; }
    public String firstName { get; set; }
    public String lastName { get; set; }
    public String errorMessage { get; set; }

    public PageReference registerUser() {
        if (String.isBlank(username) || String.isBlank(email) || String.isBlank(firstName) || String.isBlank(lastName)) {
            errorMessage = 'All fields are required.';
            return null;
        }

        User newUser = new User(
            Username = username,
            Email = email,
            FirstName = firstName,
            LastName = lastName,
            ProfileId = '00e5j000000sfM7AAI'
        );

         
        insert newUser;

        return null;  
    }
}