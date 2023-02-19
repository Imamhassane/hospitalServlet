package ui;


import lombok.SneakyThrows;
import model.Medcin;
import model.Service;
import service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet( urlPatterns = {"/service/*" })
public class ServiceServlet extends HttpServlet {
     IService serviceService = new ServiceService();
     ISpecialite specialiteService = new SpecialiteService();
     IMedcin medcinService = new MedcinService();

    @SneakyThrows
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        switch (action){
            case "save":
                Service service = new Service();
                serviceService.add(save(service, request));
                request.setAttribute("succes" , "Service ajouté avec succés!");
                break;
            case "update":
                long id = Long.parseLong(request.getParameter("id"));
                serviceService.add(save(serviceService.find(id), request));
                request.setAttribute("succes" , "Service modifié avec succés!");
                break;
            default:
                break;
        }
        response.sendRedirect(request.getContextPath() +"/service/list");
    }

    @SneakyThrows
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getRequestURI();
        HttpSession session = request.getSession(true);
        long id = 0;
        if (request.getParameter("id") != null){
            id = Long.parseLong(request.getParameter("id"));
        }
        switch (action){
            case "/hospital/service/list" :
                request.setAttribute("serviceList" , serviceService.findAll());
                getServletContext().getRequestDispatcher("/WEB-INF/pages/service/list.jsp").forward(request , response);
                break;
            case "/hospital/service/remove" :
                if (remove(id)) {
                    session.setAttribute("successRemove", "Service supprimé avec succés");
                } else {
                    session.setAttribute("errorRemove", "Ce service est rattaché à une spécialité ou un medcin");
                }
                response.sendRedirect(request.getContextPath() +"/service/list");
                break;
            default :
                break;
        }
    }

    public boolean remove (long id) throws Exception {
        Service service = serviceService.find(id);
        boolean isInSpecialite = specialiteService.findService(service);
        boolean isInMedcin = medcinService.findService(service);
        if (!isInSpecialite && !isInMedcin){
            serviceService.remove(service);
            return true;
        }else{
            return false;
        }

    }
    public Service save(Service service , HttpServletRequest request){
        String libelle = request.getParameter("libelleService");
        service.setLibelle(libelle);
        return service;
    }
}
