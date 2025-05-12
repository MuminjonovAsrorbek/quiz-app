package uz.dev.lesson9.servlet;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.dev.lesson9.config.StartStopListener;
import uz.dev.lesson9.model.Quiz;

import java.io.IOException;
import java.util.List;

/**
 * Created by: asrorbek
 * DateTime: 4/29/25 12:40
 **/

@WebServlet("/userQuizzes")
public class UserQuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        EntityManager entityManager = StartStopListener.sessionFactory.createEntityManager();

        List<Quiz> quizzes = entityManager.createQuery("from quiz", Quiz.class).getResultList();

        req.setAttribute("quizzes", quizzes);

        req.getRequestDispatcher("userQuizList.jsp").forward(req, resp);

    }
}
