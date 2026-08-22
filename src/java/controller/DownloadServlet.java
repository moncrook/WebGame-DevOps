package controller;

import data.dao.DownloadDao;
import data.impl.DownloadImpl;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Download;

@WebServlet(name = "DownloadServlet", urlPatterns = {"/download", "/tai-game"})
public class DownloadServlet extends HttpServlet {

    private DownloadDao downloadDAO;

    @Override
    public void init() {
        downloadDAO = new DownloadImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        List<Download> downloads = downloadDAO.getAllDownloads();
        request.setAttribute("downloads", downloads);

        request.getRequestDispatcher("/view/taigame.jsp").forward(request, response);
    }
}