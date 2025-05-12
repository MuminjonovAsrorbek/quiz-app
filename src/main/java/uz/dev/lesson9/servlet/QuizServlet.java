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
import java.time.LocalDateTime;
import java.util.List;

/**
 * Created by: asrorbek
 * DateTime: 4/28/25 14:01
 **/

@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        EntityManager entityManager = StartStopListener.sessionFactory.createEntityManager();

        List<Quiz> quizzes = entityManager.createQuery("from quiz", Quiz.class).getResultList();

        request.setAttribute("quizzes", quizzes);
        request.getRequestDispatcher("quiz.jsp").forward(request, response);

    }
}
