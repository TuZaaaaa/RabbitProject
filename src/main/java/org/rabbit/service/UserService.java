package org.rabbit.service;

import org.rabbit.dao.UserDao;
import org.rabbit.vo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @author Rabbit
 */

@WebServlet("/userService")
public class UserService extends HttpServlet {

    /**
     * 用于判断请求的操作
     */
    static final String LOGIN = "login";
    static final String REGISTER = "register";
    static final String LOGOUT = "logout";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        System.out.println("action:" + action);

        if(action == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 登录操作
        if (action.equals(LOGIN)) {
            // 接收数据
            String userName = req.getParameter("user_name");
            String userPassword = req.getParameter("user_password");
            String userFlag = req.getParameter("user_flag");
            String safeCode = req.getParameter("safe_code");

            // 1. 判断验证码
            if (safeCode.equalsIgnoreCase((String) session.getAttribute("safeCode"))) {
                // 2. 判断账号和密码
                User user = new User();
                user.setUserName(userName);
                user.setUserPassword(userPassword);
                user.setUserFlag(userFlag);
                UserDao userDao = new UserDao();
                user = userDao.login(user);
                if(user != null) {
                    // success jump to index
                    session.setAttribute("user", user);
                    resp.sendRedirect("index.jsp");
                    return;
                } else {
                    // unsuccess jump to login 用 session 封装错误信息
                    session.setAttribute("info", "账号或密码错误");
                    resp.sendRedirect("login.jsp");
                }
                session.setAttribute("user", user);
            } else {
                session.setAttribute("info", "验证码错误");
                resp.sendRedirect("login.jsp");
                return;
            }
        }
    }
}