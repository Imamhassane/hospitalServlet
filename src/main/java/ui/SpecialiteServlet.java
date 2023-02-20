package ui;


import lombok.SneakyThrows;
import model.Medcin;
import model.Service;
import model.Specialite;
import service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet( urlPatterns = {"/specialite/*" })
public class SpecialiteServlet extends HttpServlet {
    IService serviceService = new ServiceService();
    ISpecialite specialiteService = new SpecialiteService();
    IMedcin medcinService = new MedcinService();

    @SneakyThrows
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        switch (action){
            case "save":
                Specialite specialite = new Specialite();
                specialiteService.add(save(specialite, request));
                request.setAttribute("success" , "Specialite ajoutée avec succés!");
                break;
            case "update":
                long id = Long.parseLong(request.getParameter("id"));
                specialiteService.add(save(specialiteService.find(id),request));
                request.setAttribute("success" , "Specialite modifiée avec succés!");
                break;
            default:
                break;
        }
        response.sendRedirect(request.getContextPath() +"/specialite/list");
    }

    @SneakyThrows
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getRequestURI();
        HttpSession session = request.getSession(true);
        long id = 0;
        if (request.getParameter("id") != null){
            id = Long.parseLong(request.getParameter("id"));
        }
        List<String> names= new ArrayList<>();
        for (Specialite s : specialiteService.findAll()){
            if (s.getLibelle() != null){
                names.add(s.getLibelle());
            }
        }
        request.setAttribute("names" , names);
        switch (action){
            case "/hospital/specialite/list" :
                request.setAttribute("specialiteList" , specialiteService.findAll());
                request.setAttribute("serviceList", serviceService.findAll());
                getServletContext().getRequestDispatcher("/WEB-INF/pages/specialite/list.jsp").forward(request , response);
                break;
            case "/hospital/specialite/remove" :
                if (remove(id)) {
                    session.setAttribute("successRemove", "Specialite supprimé avec succés");
                } else {
                    session.setAttribute("errorRemove", "Cette Specialite est rattaché à un medcin");
                }
                response.sendRedirect(request.getContextPath() +"/specialite/list");
                break;
            default :
                break;
        }
    }
    public boolean remove (long id) throws Exception {
        boolean result = false ;
        Specialite specialite = specialiteService.find(id);
        boolean isInMedcin = medcinService.findSpecialite(specialite);
        if (!isInMedcin){
            specialiteService.remove(specialite);
            result =  true;
        }
        return result;
    }
    public Specialite save(Specialite specialite , HttpServletRequest request) throws Exception {
        String libelle = request.getParameter("LibelleSpecialite");
        Service service = serviceService.find(Long.parseLong(request.getParameter("service")));
        specialite.setLibelle(libelle);
        specialite.setService(service);
        return specialite;
    }
}
