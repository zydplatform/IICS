/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils.general; 

/**
 *
 * @author gilberto
 */
import com.iics.domain.Systemuser;
import com.iics.service.GenericClassService;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.logging.Logger;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 *
 * @author gilberto
 */
@Service("assembler")
public class Assembler {

    @Autowired
    GenericClassService genericClassService;
    @SuppressWarnings("FieldNameHidesFieldInSuperclass")
    private final Log logger = LogFactory.getLog(getClass());

    /**
     *
     * @param object 
     * @param systemuser
     * @return User
     */
    public User buildUserFromUserEntity(Object object, Systemuser systemuser) {
        String username = "";
        String password = "";
        boolean enabled = false;
        boolean accountNonExpired = false;
        boolean credentialsNonExpired = false;
        boolean accountNonLocked = false;
        Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

        if (systemuser != null) {
            logger.info("User Name ------------------ "+systemuser);
            username = systemuser.getUsername();
            password = systemuser.getPassword();
            enabled = Boolean.TRUE;
            accountNonExpired = Boolean.TRUE;
            credentialsNonExpired = Boolean.TRUE;
            accountNonLocked = Boolean.TRUE;

        }
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        User user = new User(username, password, enabled,
                accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);

        return user;
    }
    private static final Logger LOG = Logger.getLogger(Assembler.class.getName());
}
