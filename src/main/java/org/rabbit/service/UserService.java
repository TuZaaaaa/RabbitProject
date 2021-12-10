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
import java.util.List;

/**
 * @author Rabbit
 */

@WebServlet("/userService")
public class UserService extends HttpServlet {

    /**
     * 用于判断请求的操作
     */
    static final String ADD = "add";
    /**
     * 用于传输回显的数据
     */
    static final String MODIFY = "modify";
    /**
     * 用于更新数据
     */
    static final String UPDATE = "update";
    static final String QUERY_ALL = "queryAll";
    static final String DETAIL = "detail";
    static final String DELETE = "delete";
    /**
     * 登录注册相关
     */
    static final String LOGIN = "login";
    static final String REGISTER = "register";
    static final String LOGOUT = "logout";

    /**
     * 修改个人信息
     */
    static final String INFOMODIFY = "infoModify";

    UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        System.out.println(action);
        if(action == null || "".equals(action)) {
            resp.sendRedirect("login.jsp");
            return;
        }


        // 登录操作
        switch (action) {
            case LOGIN:
                login(req, resp, session);
                break;
            case LOGOUT:
                session.removeAttribute("user");
                resp.sendRedirect("login.jsp");
                break;
            case INFOMODIFY:
                infoModify(req, resp);
                break;
            case ADD:
                System.out.println("add");
                userAdd(req, resp);
                break;
            case DELETE:
                System.out.println("delete");
                int userId2 = Integer.parseInt(req.getParameter("userId"));
                int rel = userDao.userDelete(userId2);
                if(rel == 1) {
                    resp.getWriter().println("<script>alert('删除成功');location.href='userService?action=queryAll'</script>");
                } else{
                    resp.getWriter().println("<script>alert('删除失败');history.go(-1)</script>");
                }
                break;
            case MODIFY:
                System.out.println("modify");
                int userId = Integer.parseInt(req.getParameter("userId"));
                User user = userDao.userQueryOne(userId);
                req.getSession().setAttribute("user-modify", user);
                resp.sendRedirect("userTable.jsp");
                break;
            case UPDATE:
                System.out.println("update");
                userUpdate(req, resp);
                break;
            case DETAIL:
                System.out.println("detail");
                Integer userId1 = Integer.valueOf(req.getParameter("userId"));
                User user1 = userDao.userQueryOne(userId1);
                req.getSession().setAttribute("user-detail", user1);
                resp.sendRedirect("userTable.jsp");
                break;
            case QUERY_ALL:
                System.out.println("queryAll");
                List<User> userList = userDao.userQueryAll();
                if(userList == null) {
                    System.out.println("异常");
                }
                req.getSession().setAttribute("userList", userList);
                resp.sendRedirect("userTable.jsp");
                break;
            default:
        }
    }

    /**
     * 登录操作
     */
    private void login(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        // 接收数据
        String userName = req.getParameter("user_name");
        String userPassword = req.getParameter("user_password");
        int userFlag = Integer.parseInt(req.getParameter("user_flag"));
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
                System.out.println(user.getUserId() + "userId;");
                resp.sendRedirect("index.jsp");
                return;
            } else {
                // unsuccess jump to login 用 session 封装错误信息
                session.setAttribute("info", "账号或密码错误");
                resp.sendRedirect("login.jsp");
            }
            session.removeAttribute("user");;
        } else {
            session.setAttribute("info", "验证码错误");
            resp.sendRedirect("login.jsp");
        }
    }

    /**
     * 添加用户息
     */
    protected void userAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 1.接收数据
        int userId = Integer.parseInt(req.getParameter("user-id"));
        User temp = userDao.userQueryOne(userId);
        if (temp == null) {
            System.out.println("异常");
            return;
        }
        if (temp.getUserId() != null) {
            resp.getWriter().println("<script>alert('用户编号已经存在');history.go(-1)</script>");
            return;
        }
        String userName = req.getParameter("user-name");
        String userPassword = req.getParameter("user-password");
        String userTelephone = req.getParameter("user-telephone");
        String userEmail = req.getParameter("user-email");
        String userAddress = req.getParameter("user-address");
        int userFlag = Integer.parseInt(req.getParameter("user-flag"));
        // 2.封装用户信息
        User user = new User(userId, userName, userPassword, userTelephone, userEmail, userAddress, userFlag);
        // 3.调用方法完成添加
        int rel = userDao.userAdd(user);
        // 4.处理结果
        if(rel == 1) {
            resp.getWriter().println("<script>alert('添加成功');location.href='userService?action=queryAll'</script>");
        } else{
            resp.getWriter().println("<script>alert('添加失败');history.go(-1)</script>");
        }
    }


    /**
     * 修改用户信息
     */
    protected void userUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 1.接收数据
        int userId = Integer.parseInt(req.getParameter("user-id2"));
        String userName = req.getParameter("user-name2");
        String userPassword = req.getParameter("user-password2");
        String userTelephone = req.getParameter("user-telephone2");
        String userEmail = req.getParameter("user-email2");
        String userAddress = req.getParameter("user-address2");
        int userFlag = Integer.parseInt(req.getParameter("user-flag2"));

        User user = new User(userId, userName, userPassword, userTelephone,  userEmail, userAddress, userFlag);
        // 3.调用方法完成修改
        int rel = userDao.userUpdate(user);
        // 4.处理结果
        if(rel == 1) {
            resp.getWriter().println("<script>alert('修改成功');location.href='userService?action=queryAll'</script>");
        } else{
            resp.getWriter().println("<script>alert('修改失败');history.go(-1)</script>");
        }
    }

    /**
     * 修改个人信息
     */
    protected void infoModify(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int userId = Integer.parseInt(req.getParameter("user-id2"));
        String userName = req.getParameter("user-name2");
        String userPassword = req.getParameter("user-password2");
        String userTelephone = req.getParameter("user-telephone2");
        String userEmail = req.getParameter("user-email2");
        String userAddress = req.getParameter("user-address2");
        int userFlag;
        if ("管理员".equals(req.getParameter("user-flag2"))) {
            userFlag = 1;
        } else if("用户".equals(req.getParameter("user-flag2"))) {
            userFlag = 1;
        } else {
            userFlag = Integer.parseInt(req.getParameter("user-flag2"));
        }

        User user = new User(userId, userName, userPassword, userTelephone,  userEmail, userAddress, userFlag);
        // 3.调用方法完成修改
        int rel = userDao.userUpdate(user);
        // 4.处理结果
        if(rel == 1) {
            req.getSession().setAttribute("user", user);
            resp.getWriter().println("<script>alert('修改成功');location.href='userInfo.jsp'</script>");
        } else{
            resp.getWriter().println("<script>alert('修改失败');history.go(-1)</script>");
        }
    }
}