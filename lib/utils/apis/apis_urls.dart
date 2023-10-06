const baseUrl = 'https://contact-api-node.onrender.com/api/v1';
// const baseUrl = 'http://localhost:5000/api/v1';

// endpoints

//login
// post method
const loginUrl = '$baseUrl/user/login';

//register
// post method
const registerUrl = '$baseUrl/user/register';

//user profile
// get method
const userProfileUrl = '$baseUrl/user/profile';

//contacts
// get method
const contacts = '$baseUrl/contacts';

//create contact
// post method
const createContact = '$baseUrl/contacts';

//particular contact
// get method followed by /:id
const contactById = '$baseUrl/contacts';

//delete contact
// delete method followed by /:id
const deleteContact = '$baseUrl/contacts';

//update contact
// put method followed by /:id
const updateContact = '$baseUrl/contacts';
