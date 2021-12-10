package org.rabbit.service;

import org.rabbit.dao.FlowerTypeDao;
import org.rabbit.vo.FlowerType;

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
@WebServlet("/flowerTypeService")
public class FlowerTypeService extends HttpServlet {

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

    FlowerTypeDao flowerTypeDao = new FlowerTypeDao();

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
                flowerTypeAdd(req, resp);
                break;
            case DELETE:
                System.out.println("delete");
                int flowerId2 = Integer.parseInt(req.getParameter("typeId"));
                int rel = flowerTypeDao.flowerTypeDelete(flowerId2);
                System.out.println("rel = " + rel);
                if(rel == 1) {
                    resp.getWriter().println("<script>alert('删除成功');location.href='flowerTypeService?action=queryAll'</script>");
                } else{
                    resp.getWriter().println("<script>alert('删除失败');history.go(-1)</script>");
                }
                break;
            case MODIFY:
                System.out.println("modify");
                int typeId = Integer.parseInt(req.getParameter("typeId"));
                FlowerType flowerType = flowerTypeDao.flowerTypeQueryOne(typeId);
                req.getSession().setAttribute("type-modify", flowerType);
                resp.sendRedirect("flowerTypeTable.jsp");
                break;
            case UPDATE:
                System.out.println("update");
                flowerTypeUpdate(req, resp);
                break;
            case QUERY_ALL:
                System.out.println("queryAll");
                List<FlowerType> flowerTypeList = flowerTypeDao.flowerTypeQueryAll();
                if(flowerTypeList == null) {
                    System.out.println("异常");
                }
                req.getSession().setAttribute("typeList", flowerTypeList);
                resp.sendRedirect("flowerTypeTable.jsp");
                break;
            default:
        }
    }

    /**
     * 添加鲜花类型信息
     */
    protected void flowerTypeAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 1.接收数据
        int typeId = Integer.parseInt(req.getParameter("type-id"));
        FlowerType temp = flowerTypeDao.flowerTypeQueryOne(typeId);
        if (temp == null) {
            System.out.println("异常");
            return;
        }
        if (temp.getTypeId() != null) {
            resp.getWriter().println("<script>alert('类型编号已经存在');history.go(-1)</script>");
            return;
        }
        String typeName = req.getParameter("type-name");
        String typeDepict = req.getParameter("type-depict");
        // 2.封装鲜花类型信息
        FlowerType flowerType = new FlowerType(typeId, typeName, typeDepict);
        // 3.调用方法完成添加
        int rel = flowerTypeDao.flowerTypeAdd(flowerType);
        // 4.处理结果
        if(rel == 1) {
            resp.getWriter().println("<script>alert('添加成功');location.href='flowerTypeService?action=queryAll'</script>");
        } else{
            resp.getWriter().println("<script>alert('添加失败');history.go(-1)</script>");
        }
    }

    /**
     * 修改鲜花类型信息
     */
    protected void flowerTypeUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 1.接收数据
        int typeId = Integer.parseInt(req.getParameter("type-id2"));
        String typeName = req.getParameter("type-name2");
        String typeDepict = req.getParameter("type-depict2");

        FlowerType flowerType = new FlowerType(typeId, typeName, typeDepict);
        // 3.调用方法完成修改
        int rel = flowerTypeDao.flowerTypeUpdate(flowerType);
        // 4.处理结果
        if(rel == 1) {
            resp.getWriter().println("<script>alert('修改成功');location.href='flowerTypeService?action=queryAll'</script>");
        } else{
            resp.getWriter().println("<script>alert('修改失败');history.go(-1)</script>");
        }
    }
}
