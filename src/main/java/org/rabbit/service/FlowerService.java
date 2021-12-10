package org.rabbit.service;

import org.rabbit.dao.FlowerDao;
import org.rabbit.dao.FlowerTypeDao;
import org.rabbit.dao.SupplierDao;
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
    static final String QUERY_MULTIPLE = "queryMultiple";

    /**
     * 购买相关
     */
    static final String SHOPPING = "shopping";
    static final String SHOPDETAIL = "shopDetail";


    FlowerDao flowerDao = new FlowerDao();
    FlowerTypeDao flowerTypeDao = new FlowerTypeDao();
    SupplierDao supplierDao = new SupplierDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        String action = req.getParameter("action");
        System.out.println("action : " + action);
        if(action == null || "".equals(action)) {
            resp.sendRedirect("login.jsp");
            return;
        }

        switch (action) {
            case ADD:
                System.out.println("add");
                flowerAdd(req, resp);
                break;
            case DELETE:
                System.out.println("delete");
                Integer flowerId2 = Integer.valueOf(req.getParameter("flowerId"));
                int rel = flowerDao.flowerDelete(flowerId2);
                System.out.println("rel = " + rel);
                if(rel == 1) {
                    resp.getWriter().println("<script>alert('删除成功');location.href='flowerService?action=queryAll'</script>");
                } else{
                    resp.getWriter().println("<script>alert('删除失败');history.go(-1)</script>");
                }
                break;
            case MODIFY:
                System.out.println("modify");
                Integer flowerId = Integer.valueOf(req.getParameter("flowerId"));
                Flower flower = flowerDao.flowerQueryOne(flowerId);
                req.getSession().setAttribute("flower-modify", flower);
                resp.sendRedirect("flowerTable.jsp");
                break;
            case UPDATE:
                System.out.println("update");
                flowerUpdate(req, resp);
                break;
            case DETAIL:
                System.out.println("detail");
                Integer flowerId1 = Integer.valueOf(req.getParameter("flowerId"));
                Flower flower1 = flowerDao.flowerQueryOne(flowerId1);
                // 获取类型名称
                String typeName = flowerTypeDao.flowerTypeQueryOne(flower1.getTypeId()).getTypeName();
                // 获取供应商名称
                String supplierName = supplierDao.supplierQueryOne(flower1.getSupplierId()).getSupplierName();
                req.getSession().setAttribute("flower-detail", flower1);
                req.getSession().setAttribute("flower-typeName", typeName);
                req.getSession().setAttribute("flower-supplierName", supplierName);
                resp.sendRedirect("flowerTable.jsp");
                break;
            case SHOPDETAIL:
                System.out.println("shopDetail");
                Integer flowerId3 = Integer.valueOf(req.getParameter("flowerId"));
                Flower flower3 = flowerDao.flowerQueryOne(flowerId3);
                // 获取类型名称
                String typeName3 = flowerTypeDao.flowerTypeQueryOne(flower3.getTypeId()).getTypeName();
                // 获取供应商名称
                String supplierName3 = supplierDao.supplierQueryOne(flower3.getSupplierId()).getSupplierName();
                req.getSession().setAttribute("flower-info-buy", flower3);
                req.getSession().setAttribute("flower-typeName", typeName3);
                req.getSession().setAttribute("flower-supplierName", supplierName3);
                resp.sendRedirect("shopping.jsp");
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
            case QUERY_MULTIPLE:
                System.out.println("queryMultiple");
                String flowerName = req.getParameter("flower-name");
                String typeId = req.getParameter("type-id");
                String supplierId = req.getParameter("supplier-id");
                if ("".equals(flowerName) && "".equals(typeId) && "".equals(supplierId)) {
                    req.getSession().removeAttribute("flowerList");
                    resp.getWriter().print("<script>alert('请填写查询条件');location.href='flowerTable.jsp'</script>");
                }
                String sql = "select * from tb_flower where 1 = 1 ";
                if (!("".equals(flowerName))) {
                    sql += "and flower_name like '%"+ flowerName +"%' ";
                }
                if (!("".equals(typeId))) {
                    sql += "and type_id = '"+ typeId +"' ";
                }
                if (!("".equals(supplierId))) {
                    sql += "and supplier_id = '"+ supplierId +"'";
                }
                List<Flower> flowerList1 = flowerDao.flowerQueryMultiple(sql);
                req.getSession().setAttribute("flowerList", flowerList1);
                // 选项回填
                req.getSession().setAttribute("back-flower", flowerName);
                req.getSession().setAttribute("back-type", typeId);
                req.getSession().setAttribute("back-supplier", supplierId);
                System.out.println("type" + typeId + "type");
                resp.sendRedirect("flowerTable.jsp");
                break;
            case SHOPPING:
                System.out.println("shopping");
                List<Flower> flowerList3 = flowerDao.flowerQueryAll();
                if(flowerList3 == null) {
                    System.out.println("异常");
                }
                req.getSession().setAttribute("flowerList", flowerList3);
                resp.sendRedirect("shopping.jsp");
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
            resp.getWriter().println("<script>alert('添加成功');location.href='flowerService?action=queryAll'</script>");
        } else{
            resp.getWriter().println("<script>alert('添加失败');history.go(-1)</script>");
        }
    }

    /**
     * 修改鲜花信息
     */
    protected void flowerUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 1.接收数据
        Integer flowerId = Integer.parseInt(req.getParameter("flower-id"));
        String flowerName = req.getParameter("flower-name");
        int typeId = Integer.parseInt(req.getParameter("type-id"));
        BigDecimal flowerPrice = new BigDecimal(req.getParameter("flower-price"));
        int flowerStock = Integer.parseInt(req.getParameter("flower-stock"));
        int flowerSell = Integer.parseInt(req.getParameter("flower-sell"));
        int supplierId = Integer.parseInt(req.getParameter("supplier-id"));
        Flower flower = new Flower(flowerId, flowerName, typeId, flowerPrice, flowerStock, flowerSell, supplierId);
        // 3.调用方法完成修改
        int rel = flowerDao.flowerUpdate(flower);
        // 4.处理结果
        if(rel == 1) {
            resp.getWriter().println("<script>alert('修改成功');location.href='flowerService?action=queryAll'</script>");
        } else{
            resp.getWriter().println("<script>alert('修改失败');history.go(-1)</script>");
        }
    }
}