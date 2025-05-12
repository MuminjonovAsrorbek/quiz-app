package uz.dev.lesson9.servlet;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.dev.lesson9.config.StartStopListener;
import uz.dev.lesson9.model.AnswerOption;
import uz.dev.lesson9.model.Question;
import uz.dev.lesson9.model.Quiz;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;

/**
 * Created by: asrorbek
 * DateTime: 4/29/25 07:52
 **/

@WebServlet("/createQuiz")
public class CreateQuiz extends HttpServlet {

    private static final int MAX_ANSWER_OPTIONS = 3;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("createQuiz.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        String step = req.getParameter("step");

        if ("quiz".equals(step)) {
            String title = req.getParameter("title");
            String description = req.getParameter("description");

            Quiz quiz = new Quiz();
            quiz.setTitle(title);
            quiz.setDescription(description);
            quiz.setCreatedAt(LocalDateTime.now());
            quiz.setQuestions(new ArrayList<>());

            session.setAttribute("quiz", quiz);
            resp.sendRedirect("createQuiz.jsp");
        } else if ("question".equals(step)) {
            Quiz quiz = (Quiz) session.getAttribute("quiz");
            String content = req.getParameter("content");

            Question question = new Question();
            question.setContent(content);
            question.setAnswerOptions(new ArrayList<>());
            question.setQuiz(quiz);

            session.setAttribute("currentQuestion", question);
            resp.sendRedirect("createQuiz.jsp");
        } else if ("answer".equals(step)) {
            Question currentQuestion = (Question) session.getAttribute("currentQuestion");

            if (currentQuestion.getAnswerOptions().size() >= MAX_ANSWER_OPTIONS) {

                resp.sendRedirect("createQuiz.jsp");
                return;
            }

            String content = req.getParameter("content");
            boolean isCorrect = "true".equals(req.getParameter("isCorrect"));

            AnswerOption answerOption = new AnswerOption();
            answerOption.setContent(content);
            answerOption.setIsCorrect(isCorrect);
            answerOption.setQuestion(currentQuestion);

            currentQuestion.getAnswerOptions().add(answerOption);
            session.setAttribute("currentQuestion", currentQuestion);
            resp.sendRedirect("createQuiz.jsp");
        } else if ("addQuestion".equals(step)) {
            Quiz quiz = (Quiz) session.getAttribute("quiz");
            Question currentQuestion = (Question) session.getAttribute("currentQuestion");

            if (currentQuestion != null) {
                quiz.getQuestions().add(currentQuestion);
                session.setAttribute("quiz", quiz);
                session.removeAttribute("currentQuestion");
            }

            resp.sendRedirect("createQuiz.jsp");
        } else if ("save".equals(step)) {
            Quiz quiz = (Quiz) session.getAttribute("quiz");
            Question currentQuestion = (Question) session.getAttribute("currentQuestion");

            if (currentQuestion != null) {
                quiz.getQuestions().add(currentQuestion);
            }

            EntityManager entityManager = StartStopListener.sessionFactory.createEntityManager();

            entityManager.getTransaction().begin();

            entityManager.persist(quiz);

            entityManager.getTransaction().commit();

            session.removeAttribute("quiz");
            session.removeAttribute("currentQuestion");

            resp.sendRedirect("/quiz");
        }

    }
}
