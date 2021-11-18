package org.rabbit.util;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

/**
 * @author Rabbit
 */
@WebServlet("/safeCode")
public class SafeCode extends HttpServlet {
    /**
     * 定义静态String类型数组，存储验证码中出现的字符 0,o,Q,I,1,l,去掉
     */
    private static final String[] CHARARRAY ={"2","3","4","5","6","7","8","9"
            ,"A","B","C","D","E","F","G","H","J","K","L","M","N","P","R","S"
            ,"T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","j","k","m"
            ,"n","p","q","r","s","t","u","v","w","x","y","z"};

    /**
     * 定义获取随机颜色的方法,参数为控制参数
     * @param fc
     * @param bc
     * @return
     */
    private Color getRandColor(int fc, int bc){
        Random rand=new Random();
        if(fc>255) {
            fc=255;
        }
        if(bc>255) {
            bc=255;
        }
        int r=fc+rand.nextInt(bc-fc);
        int g=fc+rand.nextInt(bc-fc);
        int b=fc+rand.nextInt(bc-fc);
        return new Color(r,g,b);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doPost( request,  response);
    }


    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("image/jpeg");//设置响应内容类型
        response.setHeader("Cache-Control", "no-cache");//没有缓存
        response.setHeader("Pragma", "no-cache");//没有缓存
        response.setDateHeader("Expires", 0L);//过期时间0秒

        int count=4;
        int width=count*15;
        int height=20;
        int lineNumber=5;//干扰线条数

        BufferedImage image=new BufferedImage(width,height,1);
        //根据//宽,高,图片类型（为RGB）定义图像对象

        Graphics g=image.getGraphics();//得到一个可以绘制内容的图形
        Random random=new Random();
        g.setColor(getRandColor(200,250));//设置画笔随机颜色
        g.fillRect(0, 0, width, height);//使用自定义颜色填充图片
        g.setFont(new Font("Arial",0,19));//设置字体
        g.setColor(getRandColor(160,200));//设置画笔随机颜色

        for(int i=0;i<lineNumber;i++){
            int x1=random.nextInt(width);
            int y1=random.nextInt(height);
            int x2=random.nextInt(width);
            int y2=random.nextInt(height);

            //绘制干扰线
            g.drawLine(x1, y1, x2, y2);
        }

        String sCode="";//保存四位验证码字符
        for(int i=0;i<count;i++){//从静态数组中随机得到字符，并连接成一个字符串
            String temp=CHARARRAY[random.nextInt(CHARARRAY.length)];
            g.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));
            //设置字符随机颜色
            g.drawString(temp, 13*i+6, 16);//将文本绘制到图像
            sCode=sCode+temp;//连接成一个字符串
        }

        request.getSession().setAttribute("safeCode", sCode);//将验证码保存session
        g.dispose();//释放资源

//        javax.servlet.ServletOutputStream imageOut=response.getOutputStream();
//        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(imageOut);
//        encoder.encode(image);//将图像放入响应中

        ImageIO.write(image, /*"GIF"*/ "jpg" /* format desired */ , response.getOutputStream() /* target */ );
    }
}
