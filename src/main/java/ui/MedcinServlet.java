package ui;


import lombok.SneakyThrows;
import model.Medcin;
import model.Personne;
import model.Specialite;
import service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet( urlPatterns = {"/medcin/*" })
public class MedcinServlet extends HttpServlet {
    IService serviceService = new ServiceService();
    ISpecialite specialiteService = new SpecialiteService();
    IMedcin medcinIService = new MedcinService();
    IPersonne personneServiceIService = new PersonneService();
    @SneakyThrows
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        switch (action){
            case "save":
                Medcin medcin = new Medcin();
                medcinIService.add(save(request,medcin));
                request.setAttribute("success" , "Medcin ajouté avec succés!");
                break;
            case "update":
                long id = Long.parseLong(request.getParameter("id"));
                medcinIService.add(save(request, medcinIService.find(id)));
                request.setAttribute("success" , "Medcin modifié avec succés!");
                break;
            default:
                break;
        }

        response.sendRedirect(request.getContextPath() +"/medcin/list");
    }

    @SneakyThrows
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getRequestURI();
        HttpSession session = request.getSession(true);
        request.setAttribute("serviceList" , serviceService.findAll());
        request.setAttribute("specialiteList" , specialiteService.findAll());
        request.setAttribute("form","medcin");
        /*check email*/
        List<Personne> personnes = personneServiceIService.findAll();
        List<String> emails= new ArrayList<>();
        for (Personne p : personnes){
            if (p.getEmail() != null){
                emails.add(p.getEmail());
            }
        }
        request.setAttribute("emails" , emails);
        /* action and redirection*/
        switch (action){
            case "/hospital/medcin/list" :
                long count = medcinIService.count();
                String tittle = count > 0 ? "Liste des medcins" : "Liste vide";
                request.setAttribute("count", count);
                request.setAttribute("tittle", tittle);
                request.setAttribute("medcinList" , medcinIService.findAll());
                getServletContext().getRequestDispatcher("/WEB-INF/pages/medcin/list.jsp").forward(request , response);
                break;
            case "/hospital/medcin/remove" :
                long id = Long.parseLong(request.getParameter("id"));
                medcinIService.remove(medcinIService.find(id));
                session.setAttribute("successRemoveMedcin", "Medcin supprimé avec succés");
                response.sendRedirect(request.getContextPath() +"/medcin/list");
                break;
            default :
                break;
        }
    }

    public Medcin save(HttpServletRequest request, Medcin medcin) throws Exception {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String[] specialites = request.getParameterValues("specialite[]");

        List<Specialite> specialiteList = new ArrayList<>();

        medcin.setPrenom(request.getParameter("prenom"));
        medcin.setNom(request.getParameter("nom"));
        medcin.setAdresse(request.getParameter("adresse"));
        medcin.setEmail(request.getParameter("email"));
        medcin.setPassword(request.getParameter("password"));
        medcin.setSalaire(Integer.parseInt(request.getParameter("salaire")));
        medcin.setDatenaissance(simpleDateFormat.parse(request.getParameter("naissance")));
        medcin.setDateembauche(simpleDateFormat.parse(request.getParameter("embauche")));
        medcin.setService(serviceService.find(Long.parseLong(request.getParameter("service"))));
        medcin.setMatricule(medcin.getNom()+medcin.getId());
        for (String specialite: specialites){
            specialiteList.add(specialiteService.find(Long.parseLong(specialite)));
        }
        medcin.setSpecialites(specialiteList);

        return medcin;
    }
}
