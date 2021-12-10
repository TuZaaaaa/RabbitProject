package org.rabbit.service;

import org.rabbit.dao.OrderDao;
import org.rabbit.vo.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @author Rabbit
 */
@WebServlet("/orderService")
public class OrderService extends HttpServlet {

    /** * 用于判断请求的操作
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

    OrderDao orderDao = new OrderDao();

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
                orderAdd(req, resp);
                break;
            case DELETE:
                System.out.println("delete");
                int orderId2 = Integer.parseInt(req.getParameter("orderId"));
                int rel = orderDao.orderDelete(orderId2);
                System.out.println("rel = " + rel);
                if(rel == 1) {
                    resp.getWriter().println("<script>alert('删除成功');location.href='orderService?action=queryAll'</script>");
                } else {
                    resp.getWriter().println("<script>alert('删除失败');history.go(-1)</script>");
                }
                break;
            case MODIFY:
                System.out.println("modify");
                Integer orderId = Integer.valueOf(req.getParameter("orderId"));
                Order order = orderDao.orderQueryOne(orderId);
                req.getSession().setAttribute("order-modify", order);
                resp.sendRedirect("orderTable.jsp");
                break;
            case UPDATE:
                System.out.println("update");
                orderUpdate(req, resp);
                break;
            case DETAIL:
                System.out.println("detail");
                Integer orderId3 = Integer.valueOf(req.getParameter("orderId"));
                Order order3 = orderDao.orderQueryOne(orderId3);
                req.getSession().setAttribute("order-detail", order3);
                resp.sendRedirect("orderTable.jsp");
                break;
            case QUERY_ALL:
                System.out.println("queryAll");
                List<Order> orderList = orderDao.orderQueryAll();
                if(orderList == null) {
                    System.out.println("异常");
                }
                Integer orderId1 = orderList.get(0).getOrderId();
                System.out.println(orderId1 + "orderId1");
                req.getSession().setAttribute("orderList", orderList);
                resp.sendRedirect("orderTable.jsp");
                break;
            default:
        }
    }

    /**
     * 添加订单
     */
    protected void orderAdd(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1.接收数据
        Integer orderId = Integer.valueOf(req.getParameter("order-id"));
        Order temp = orderDao.orderQueryOne(orderId);
        if (temp == null) {
            System.out.println("异常");
            return;
        }
        if (temp.getOrderId() != null) {
            resp.getWriter().println("<script>alert('订单编号已经存在');history.go(-1)</script>");
            return;
        }
        int flowerId = Integer.parseInt(req.getParameter("flower-id"));
        String orderAddress = req.getParameter("order-address");
        String orderDepict = req.getParameter("order-depict");
        String orderTime = req.getParameter("order-time");
        Date time = null;
        try {
            time = new SimpleDateFormat("yyyy-MM-dd").parse(orderTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        // 2.封装订单信息
        Order order = new Order(orderId, flowerId, orderAddress, orderDepict, time, 0);
        // 3.调用方法完成添加
        int rel = orderDao.orderAdd(order);
        // 4.处理结果
        if(rel == 1) {
            resp.getWriter().println("<script>alert('添加成功');location.href='orderService?action=queryAll'</script>");
        } else{
            resp.getWriter().println("<script>alert('添加失败');history.go(-1)</script>");
        }
    }

    /**
     * 修改订单信息
     */
    protected void orderUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 1.接收数据
        Integer orderId = Integer.valueOf(req.getParameter("order-id"));
        int flowerId = Integer.parseInt(req.getParameter("flower-id"));
        String orderAddress = req.getParameter("order-address");
        String orderDepict = req.getParameter("order-depict");
//        String orderTime = req.getParameter("order-time");
        int orderFlag = Integer.parseInt(req.getParameter("order-flag"));
        Order order = new Order(orderId, flowerId, orderAddress, orderDepict, orderFlag);
        // 3.调用方法完成修改
        int rel = orderDao.orderUpdate(order);
        // 4.处理结果
        if(rel == 1) {
            resp.getWriter().println("<script>alert('修改成功');location.href='orderService?action=queryAll'</script>");
        } else{
            resp.getWriter().println("<script>alert('修改失败');history.go(-1)</script>");
        }
    }

}