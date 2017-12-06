
public class Customer {

    String firstname;
    String lastname;
    String address;
    String city;
    String state;
    String zipcode;
    String phone;
    String email;

    public Customer(String firstnamevar, String lastnamevar, String addressvar, String cityvar, String statevar, String zipcodevar, String phonevar, String emailvar){
        firstname = firstnamevar;
        lastname = lastnamevar;
        address = addressvar;
        city = cityvar;
        state = statevar;
        zipcode = zipcodevar;
        phone = phonevar;
        email = emailvar;
    }

    public boolean isNull(){
        if(this.firstname == null &&
                this.lastname == null &&
                this.address == null &&
                this.city == null &&
                this.state == null &&
                this.zipcode == null &&
                this.phone == null &&
                this.email == null){
            System.out.println("first name is" + firstname);
            System.out.println("Customer is null");
            return true;}
        return false;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
