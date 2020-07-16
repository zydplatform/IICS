/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service;

import com.iics.domain.Systemuser;
import com.iics.utils.general.Assembler;
import java.util.List;
import java.util.logging.Logger;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 *
 * @author samuelwam
 */
@Service("userDetailsService")
public class UserLoginService implements UserDetailsService {
 
    @Autowired
    GenericClassService genericClassService;
    @Autowired
    private Assembler assembler;
    protected final Log logger = LogFactory.getLog(getClass());

    /**
     * Retrieves a user record containing the user's credentials and access.
     *
     * @param username
     * @return
     * @throws UsernameNotFoundException
     * @throws DataAccessException
     */
    @Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException, DataAccessException {
        try{
        logger.info("#################################"+username);
        String[] params4 = {"username"};
        Object[] paramsValues4 = {username};
        String[] fields4 = {"systemuserid", "username", "password"};
        
        List<Object[]> systemuserExist = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fields4, " WHERE r.username=:username", params4, paramsValues4);
        Systemuser systemuser = null;
        logger.info("Uname Passed ::: "+username+" systemuserExist ::: "+systemuserExist+" ");
        if (systemuserExist == null) {
            throw new UsernameNotFoundException("user not found in IICS-SMS DB");
        }
        
        systemuser = new Systemuser((Long) systemuserExist.get(0)[0]);
        systemuser.setUsername((String) systemuserExist.get(0)[1]);
        systemuser.setPassword((String) systemuserExist.get(0)[2]);
        logger.info("Returned Pswd ::: "+systemuserExist.get(0)[2]);

        return assembler.buildUserFromUserEntity(null, systemuser);
        }catch(Exception e){
            e.printStackTrace();
            return assembler.buildUserFromUserEntity(null, null);
        }
    }
    private static final Logger LOG = Logger.getLogger(UserLoginService.class.getName());
}
