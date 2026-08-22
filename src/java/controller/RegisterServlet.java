/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.Database;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Xua Nhan
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/view/register.jsp")
                .forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String err_username="" , err_name="" , err_repassword="";
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        boolean err = false;
        
        if(!repassword.matches(password)){
            err_repassword="mật khẩu không trùng khớp ";
            request.getSession().setAttribute("err_repassword", err_repassword);
            err = true;
        }else{
            err_repassword="";
            request.getSession().removeAttribute("err_email");
        }
        
        if(Database.getUsertDao().findName(name)!=null){
            err_name="tên nhân vật này đã cps";
            request.getSession().setAttribute("err_name", err_name);
            err = true;
        }
        
        if(Database.getUsertDao().findUserName(username)!=null){
            err_username="tên đăng nhập này đã có";
            request.getSession().setAttribute("err_username", err_username);
            err = true;
        }
        
        if(err){
            response.sendRedirect("register");
        }else{
            if(Database.getUsertDao().find(username, password)!=null){
                request.getSession().setAttribute("exist_user", "user đã tồn tại");
                response.sendRedirect("register");
            }else{
                Database.getUsertDao().insertUser(name, username, password);
                request.getSession().invalidate();
                response.sendRedirect("login");
            }
        }
        
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
