package com.escl.citi.validation.validator;

import com.escl.citi.data.dto.SystemUserDto;
import com.escl.citi.data.dto.UserDto;
import com.escl.citi.entity.User;
import com.escl.citi.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class UserValidator implements Validator {

    @Autowired
    private UserService userService;

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        SystemUserDto userDto = (SystemUserDto) o;

        if (userDto.getId() == null) {
            validateNewUser(userDto, errors);
        } else {
            validateExistingUser(userDto, errors);
        }

    }

    private void validateNewUser(SystemUserDto user, Errors errors) {
        if (user.getPassword().isEmpty()){
            errors.rejectValue("password", "password.empty", "Hasło nie może być puste");
        }

        if (!user.getPassword().isEmpty() && !user.getPassword().equals(user.getPasswordConfirm())) {
            errors.rejectValue("password", "password.equal", "Hasła nie są Identyczne");
            errors.rejectValue("passwordConfirm", "password.equal", "Hasła nie są Identyczne");
        }

        if (userService.findByUsername(user.getUsername()) != null) {
            errors.rejectValue("username", "Duplicate.userForm.username");
        }

        if (userService.findByEmail(user.getEmail()) != null) {
            errors.rejectValue("email", "Duplicate.userForm.email");
        }
    }

    private void validateExistingUser(SystemUserDto user, Errors errors) {

        User userByEmail = userService.findByEmail(user.getEmail());
        User userByUsername = userService.findByUsername(user.getUsername());


        if (userByUsername != null && !userByUsername.getId().equals(user.getId())) {
            errors.rejectValue("username", "Duplicate.userForm.username");
        }

        if (userByEmail != null && !userByEmail.getId().equals(user.getId())) {
            errors.rejectValue("email", "Duplicate.userForm.email");
        }

        if (!user.getPassword().isEmpty() && !user.getPassword().equals(user.getPasswordConfirm())) {
            errors.rejectValue("password", "password.equal", "Hasła nie są Identyczne");
            errors.rejectValue("passwordConfirm", "password.equal", "Hasła nie są Identyczne");
        }

    }
}