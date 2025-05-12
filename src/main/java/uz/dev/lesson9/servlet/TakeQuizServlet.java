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
import java.util.Objects;

/**
 * Created by: asrorbek
 * DateTime: 4/29/25 12:46
 **/

@WebServlet("/takeQuiz")
public class TakeQuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String id = req.getParameter("id");

        if (id == null || id.isEmpty()) {

            req.setAttribute("error", "Quiz id is empty");

            req.getRequestDispatcher("takeQuiz.jsp").forward(req, resp);

            return;

        }

        EntityManager entityManager = StartStopListener.sessionFactory.createEntityManager();

        entityManager.getTransaction().begin();

        Quiz quiz = entityManager.find(Quiz.class, Integer.parseInt(id));

        if (Objects.isNull(quiz)) {

            req.setAttribute("error", "Quiz not found");

            req.getRequestDispatcher("takeQuiz.jsp").forward(req, resp);

            return;

        }

        req.setAttribute("quiz", quiz);

        req.getRequestDispatcher("takeQuiz.jsp").forward(req, resp);

    }
}
