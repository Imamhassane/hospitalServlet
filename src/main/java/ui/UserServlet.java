package ui;


import lombok.SneakyThrows;
import model.Medcin;
import model.Personne;
import model.Service;
import service.IPersonne;
import service.IService;
import service.PersonneService;
import service.ServiceService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/" , "/logout" , "/login"})
public class UserServlet extends HttpServlet {
    IPersonne personneService = new PersonneService();

    @SneakyThrows
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Personne personne = personneService.findByEmailAndPassword( email , password);
        response.getWriter().println(session.getAttribute("userConnected"));
        if (personne != null){
            session.setAttribute("userConnected" , personne);
            response.getWriter().println(session.getAttribute("userConnected"));

            response.sendRedirect(request.getContextPath() +"/medcin/list");
        }else{
            request.setAttribute("errorLogin","login ou mot de pass incorrect!");
            getServletContext().getRequestDispatcher("/WEB-INF/pages/connexion.jsp").forward(request , response);
        }

    }

    @SneakyThrows
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getRequestURI();

        if ("/hospital/logout".equals(action)) {
            HttpSession session = request.getSession(false);
            session.setAttribute("userConnected" , null);
            session.invalidate();
        }
        getServletContext().getRequestDispatcher("/WEB-INF/pages/connexion.jsp").forward(request , response);

        /*Personne personne = new Personne();
        personne.setEmail("admin@gmail.com");
        personne.setNom("admin");
        personne.setPassword("admin");
        personne.setPassword("passer");
        personneService.add(personne);*/

    }
}
