package org.rabbit.util;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import java.io.IOException;

/**
 * @author Rabbit
 */
@WebFilter( value = "/*",
            initParams = {
                    @WebInitParam(name = "encoding", value = "utf-8")
            })
public class CharacterFilter implements Filter {
    private String encoding = "";
    @Override
    public void init(FilterConfig filterConfig) {
        this.encoding = filterConfig.getInitParameter("encoding");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        if (encoding != null) {
            servletRequest.setCharacterEncoding(encoding);
            servletRequest.setCharacterEncoding(encoding);
            servletResponse.setContentType("text/html;charset=" + encoding);
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
}
