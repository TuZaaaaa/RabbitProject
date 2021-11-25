package org.rabbit.service;

import org.rabbit.dao.FlowerDao;
import org.rabbit.vo.Flower;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

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
    static final String QUERY_ALL = "queryAll";
    static final String DETAIL = "detail";
    static final String DELETE = "delete";


    FlowerDao flowerDao = new FlowerDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        String action = req.getParameter("action");
        System.out.println(action);
        if(action == null || "".equals(action)) {
            resp.sendRedirect("login.jsp");
            return;
        }

        switch (action) {
            case ADD:
                System.out.println("add");
                flowerAdd(req, resp);
                break;
            case QUERY_ALL:
                System.out.println("queryAll");
                List<Flower> flowerList = flowerDao.flowerQueryAll();
                if(flowerList == null) {
                    System.out.println("异常");
                }
                req.getSession().setAttribute("flowerList", flowerList);
                resp.sendRedirect("flowerTable.jsp");
                break;
            case MODIFY:
                System.out.println("modify");
                Integer flowerId = Integer.valueOf(req.getParameter("flowerId"));
                Flower flower = flowerDao.flowerQueryOne(flowerId);
                req.getSession().setAttribute("flower-modify", flower);
                resp.sendRedirect("flowerTable.jsp");
                break;
            case DETAIL:
                System.out.println("detail");
                Integer flowerId1 = Integer.valueOf(req.getParameter("flowerId"));
                Flower flower1 = flowerDao.flowerQueryOne(flowerId1);
                req.getSession().setAttribute("flower-detail", flower1);
                resp.sendRedirect("flowerTable.jsp");
                break;
            case DELETE:
                System.out.println("delete");
                Integer flowerId2 = Integer.valueOf(req.getParameter("flowerId"));
                resp.sendRedirect("flowerTable.jsp");
                break;
            default:
        }
    }

    /**
     * 添加鲜花
     */
    protected void flowerAdd(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1.接收数据
        Integer flowerId = Integer.valueOf(req.getParameter("flower-id"));
        Flower temp = flowerDao.flowerQueryOne(flowerId);
        if (temp == null) {
            System.out.println("异常");
            return;
        }
        if (temp.getFlowerId() != null) {
            resp.getWriter().println("<script>alert('鲜花编号已经存在');history.go(-1)</script>");
            return;
        }
        String flowerName = req.getParameter("flower-name");
        int typeId = Integer.parseInt(req.getParameter("type-id"));
        BigDecimal flowerPrice = new BigDecimal(req.getParameter("flower-price"));
        int flowerStock = Integer.parseInt(req.getParameter("flower-stock"));
        int flowerSell = Integer.parseInt(req.getParameter("flower-sell"));
        int supplierId = Integer.parseInt(req.getParameter("supplier-id"));
        // 2.封装鲜花信息
        Flower flower = new Flower(flowerId, flowerName, typeId, flowerPrice, flowerStock, flowerSell, supplierId);
        // 3.调用方法完成添加
        int rel = flowerDao.flowerAdd(flower);
        // 4.处理结果
        if(rel == 1) {
            resp.getWriter().println("<script>alert('添加成功');history.go(-1)</script>");
        } else{
            resp.getWriter().println("<script>alert('添加失败');history.go(-1)</script>");
        }
    }
}