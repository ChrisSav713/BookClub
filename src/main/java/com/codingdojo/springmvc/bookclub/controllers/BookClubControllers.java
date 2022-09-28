package com.codingdojo.springmvc.bookclub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.codingdojo.springmvc.bookclub.models.Book;
import com.codingdojo.springmvc.bookclub.models.LoginUser;
import com.codingdojo.springmvc.bookclub.models.User;
import com.codingdojo.springmvc.bookclub.services.BookService;
import com.codingdojo.springmvc.bookclub.services.UserService;

@Controller
public class BookClubControllers {
    
    // Add once service is implemented:
    @Autowired
    private UserService userServ;
    @Autowired
    private BookService bookServ;
    
    @GetMapping("/")
    public String index(Model model) {
    
        // Bind empty User and LoginUser objects to the JSP
        // to capture the form input
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "index.jsp";
    }
    
    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") User newUser, 
            BindingResult result, Model model, HttpSession session) {
        
    	User user = userServ.register(newUser, result);
        // TO-DO Later -- call a register method in the service 
        // to do some extra validations and create a new user!
        
        if(result.hasErrors()) {
            // Be sure to send in the empty LoginUser before 
            // re-rendering the page.
            model.addAttribute("newLogin", new LoginUser());
            return "index.jsp";
        }
        
        // No errors! 
        // TO-DO Later: Store their ID from the DB in session, 
        // in other words, log them in.
        session.setAttribute("userId", user.getId());
        return "redirect:/home";
    }
    
    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, 
            BindingResult result, Model model, HttpSession session) {
        
        // Add once service is implemented:
        User user = userServ.login(newLogin, result);
        if(user == null) {
        	model.addAttribute("newUser", new User());
        	return "index.jsp";
        }
        if(result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "index.jsp";
        }
    	        
        // No errors! 
        // TO-DO Later: Store their ID from the DB in session, 
        // in other words, log them in.
        session.setAttribute("userId", user.getId());
        
        return "redirect:/home";
    }
    
    @GetMapping("/home")
    public String dashboard(HttpSession session, Model model) {
    	if(session.getAttribute("userId") == null) {
    		return "redirect:/logout";
    	}	    	
    	Long userId = (Long) session.getAttribute("userId");
    	model.addAttribute("user", userServ.findById(userId));
    	List<Book> books = bookServ.allBooks();
    	model.addAttribute("books", books);
    	return "dashboard.jsp";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
    	session.setAttribute("userId", null);
    	return "redirect:/";
    }
    
    @GetMapping(value="/books/new")
    public String newBook(Model model, HttpSession session) {
    	model.addAttribute("book", new Book());
    	User user = userServ.findById((Long)session.getAttribute("userId"));
    	model.addAttribute("user", user);
    	return "NewBook.jsp";
    }
    
    @PostMapping("/books/create")
    public String createBook(@Valid @ModelAttribute("book") Book book, BindingResult result) {
    	if(result.hasErrors()) {
    		return "NewBook.jsp";
    	} else {
    		bookServ.createBook(book);
    		return "redirect:/home";
    	}
    }
    
    @GetMapping("/books/{id}/edit")
    public String editBook(@PathVariable("id") Long id, Model model, HttpSession session) {
    	Book book = bookServ.findBook(id);
    	model.addAttribute("book", book);
    	User user = userServ.findById((Long)session.getAttribute("userId"));
    	model.addAttribute("user", user);
    	return "EditBook.jsp";
    }
    
    @RequestMapping(value="/books/{id}/update", method=RequestMethod.PUT)
    public String updateBook(@PathVariable("id") Long id, HttpSession session, Model model, @Valid @ModelAttribute("book") Book book, BindingResult result) {
    	if(result.hasErrors()) {
    		return "EditBook.jsp";
    	} else {
    		bookServ.updateBook(book);
    		return "redirect:/home";
    	}    	
    }
    
    @GetMapping("/books/{id}/view")
    public String viewBook(@PathVariable("id") Long id, Model model, HttpSession session) {
    	Book book = bookServ.findBook(id);
    	model.addAttribute("book", book);
    	User user = userServ.findById((Long)session.getAttribute("userId"));
    	model.addAttribute("user", user);
    	return "ViewBook.jsp";
    }
    
    @RequestMapping(value="books/{id}/delete", method=RequestMethod.DELETE)
    public String destroyBook(@PathVariable("id") Long id) {
    	bookServ.deleteBook(id);
    	return "redirect:/home";
    }
    
}
