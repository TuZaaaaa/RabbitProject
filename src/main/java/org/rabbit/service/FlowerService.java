package org.rabbit.service;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author Rabbit
 */
@WebServlet("/flowerService")
public class FlowerService extends HttpServlet {

    /**
     * 用于判断请求的操作
     */
    static final String ADD = "add";
    static final String MODIFY = "modify";
    static final String DELETE = "delete";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action.equals(ADD)) {

        }
    }


}
