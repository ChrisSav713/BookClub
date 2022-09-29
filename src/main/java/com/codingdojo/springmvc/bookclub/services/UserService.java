package com.codingdojo.springmvc.bookclub.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.codingdojo.springmvc.bookclub.models.LoginUser;
import com.codingdojo.springmvc.bookclub.models.User;
import com.codingdojo.springmvc.bookclub.repositories.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepo;
	
	// This method will be called from the controller
    // whenever a user submits a registration form.
    
    public User register(User newUser, BindingResult result) {
    
        // Reject if email is taken (present in database)
    	Optional<User> potentialUser = userRepo.findByEmail(newUser.getEmail());
    	if(potentialUser.isPresent()) {
    		result.rejectValue("email", "Matches", "Email already exists");
    	}
    	
        // Reject if password doesn't match confirmation
    	if(!newUser.getPassword().equals(newUser.getConfirm())) {
    		result.rejectValue("confirm", "Matches", "The Confirm Password must match Password!");
    	}
    	
        // Return null if result has errors
    	if(result.hasErrors()) {
    		return null;
    	}

    	// Hash and set password, save user to database
    	String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
    	newUser.setPassword(hashed);
    	
    	
    	return userRepo.save(newUser);
    }

    // This method will be called from the controller
    // whenever a user submits a login form.
    public User login(LoginUser newLoginObject, BindingResult result) {
    	// TO-DO - Reject values:
        
    	// Find user in the DB by email
        // Reject if NOT present
    	Optional<User> potentialUser = userRepo.findByEmail(newLoginObject.getEmail());
    	if(!potentialUser.isPresent()) {
    		result.rejectValue("email", "Matches", "User doesn't exist");
    		return null;
    	}
            	
        // Reject if BCrypt password match fails
    	if(!BCrypt.checkpw(newLoginObject.getPassword(), potentialUser.get().getPassword())) {
    	    result.rejectValue("password", "Matches", "Invalid Password!");
    	}
    	
        // Return null if result has errors
    	if(result.hasErrors()) {
    		return null;
    	}
    	
        // Otherwise, return the user object
        return potentialUser.get();
    }

	public User findById(Long userId) {
		// TODO Auto-generated method stub
		return userRepo.findById(userId).get();
	}
}
