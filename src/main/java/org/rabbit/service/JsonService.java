package org.rabbit.service;

import com.google.gson.Gson;
import org.rabbit.vo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author Rabbit
 */
@WebServlet("/jsonService")
public class JsonService extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json; charset=utf-8");
        User user = new User(1001, "张三", "123", "1234657909", "zs@gmail.com", "吉林省长春市", 1);
        List<User> list = Arrays.asList(user);
        resp.getWriter().write(new Gson().toJson(list));
//        resp.getWriter().write(new Gson().toJson(user));
    }
}
