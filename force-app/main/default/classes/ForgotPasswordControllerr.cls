public class ForgotPasswordControllerr {
    public String usernameOrEmail { get; set; }
    public String errorMessage { get; set; }

    public PageReference resetPassword() {
        Boolean resetResult = Site.forgotPassword(usernameOrEmail);
        if (!resetResult) {
            errorMessage = 'Password reset failed. Please check the username or email.';
            return null;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Password reset instructions sent to your email.'));
            return null;
        }
    }
}