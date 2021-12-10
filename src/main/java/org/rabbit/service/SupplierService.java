package org.rabbit.service;

import org.rabbit.dao.SupplierDao;
import org.rabbit.vo.FlowerType;
import org.rabbit.vo.Supplier;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @author Rabbit
 */
@WebServlet("/supplierService")
public class SupplierService extends HttpServlet {

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

    SupplierDao supplierDao = new SupplierDao();

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
                supplierAdd(req, resp);
                break;
            case DELETE:
                System.out.println("delete");
                int supplierId2 = Integer.parseInt(req.getParameter("supplierId"));
                int rel = supplierDao.supplierDelete(supplierId2);
                if(rel == 1) {
                    resp.getWriter().println("<script>alert('删除成功');location.href='supplierService?action=queryAll'</script>");
                } else{
                    resp.getWriter().println("<script>alert('删除失败');history.go(-1)</script>");
                }
                break;
            case MODIFY:
                System.out.println("modify");
                int supplierId = Integer.parseInt(req.getParameter("supplierId"));
                Supplier supplier = supplierDao.supplierQueryOne(supplierId);
                req.getSession().setAttribute("supplier-modify", supplier);
                resp.sendRedirect("supplierTable.jsp");
                break;
            case UPDATE:
                System.out.println("update");
                supplierUpdate(req, resp);
                break;
            case QUERY_ALL:
                System.out.println("queryAll");
                List<Supplier> supplierList = supplierDao.supplierQueryAll();
                if(supplierList == null) {
                    System.out.println("异常");
                }
                req.getSession().setAttribute("supplierList", supplierList);
                resp.sendRedirect("supplierTable.jsp");
                break;
            default:
        }

    }
    /**
     * 添加供应商信息
     */
    protected void supplierAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 1.接收数据
        int supplierId = Integer.parseInt(req.getParameter("supplier-id"));
        Supplier temp = supplierDao.supplierQueryOne(supplierId);
        if (temp == null) {
            System.out.println("异常");
            return;
        }
        if (temp.getSupplierId() != null) {
            resp.getWriter().println("<script>alert('供应商编号已经存在');history.go(-1)</script>");
            return;
        }
        String supplierName = req.getParameter("supplier-name");
        String supplierAddress = req.getParameter("supplier-address");
        // 2.封装鲜花类型信息
        Supplier supplier = new Supplier(supplierId, supplierName, supplierAddress);
        // 3.调用方法完成添加
        int rel = supplierDao.supplierAdd(supplier);
        // 4.处理结果
        if(rel == 1) {
            resp.getWriter().println("<script>alert('添加成功');location.href='supplierService?action=queryAll'</script>");
        } else{
            resp.getWriter().println("<script>alert('添加失败');history.go(-1)</script>");
        }
    }

    /**
     * 修改供应商信息
     */
    protected void supplierUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 1.接收数据
        int supplierId = Integer.parseInt(req.getParameter("supplier-id2"));
        String supplierName = req.getParameter("supplier-name2");
        String supplierAddress = req.getParameter("supplier-address2");

        Supplier supplier = new Supplier(supplierId, supplierName, supplierAddress);
        // 3.调用方法完成修改
        int rel = supplierDao.supplierUpdate(supplier);
        // 4.处理结果
        if(rel == 1) {
            resp.getWriter().println("<script>alert('修改成功');location.href='supplierService?action=queryAll'</script>");
        } else{
            resp.getWriter().println("<script>alert('修改失败');history.go(-1)</script>");
        }
    }
}