package uz.dev.lesson9.servlet;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.dev.lesson9.config.StartStopListener;
import uz.dev.lesson9.model.AnswerOption;
import uz.dev.lesson9.model.Question;
import uz.dev.lesson9.model.Quiz;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by: asrorbek
 * DateTime: 4/29/25 12:50
 **/

@WebServlet("/submitQuiz")
public class SubmitQuizResult extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String quizId = req.getParameter("quizId");
        if (quizId == null || quizId.isEmpty()) {
            req.setAttribute("error", "Quiz ID is missing.");
            req.getRequestDispatcher("takeQuiz.jsp").forward(req, resp);
            return;
        }

        try (EntityManager entityManager = StartStopListener.sessionFactory.createEntityManager()) {
            Quiz quiz = entityManager.find(Quiz.class, Integer.parseInt(quizId));
            if (quiz == null) {
                req.setAttribute("error", "Quiz not found.");
                req.getRequestDispatcher("takeQuiz.jsp").forward(req, resp);
                return;
            }

            Map<Integer, Integer> userAnswers = new HashMap<>();
            for (Question question : quiz.getQuestions()) {
                String answerId = req.getParameter("answer_" + question.getId());
                if (answerId != null) {
                    userAnswers.put(question.getId(), Integer.parseInt(answerId));
                }
            }

            int correctAnswers = 0;
            for (Question question : quiz.getQuestions()) {
                Integer selectedAnswerId = userAnswers.get(question.getId());
                if (selectedAnswerId != null) {
                    for (AnswerOption answer : question.getAnswerOptions()) {
                        if (answer.getId().equals(selectedAnswerId) && answer.getIsCorrect()) {
                            correctAnswers++;
                            break;
                        }
                    }
                }
            }

            int totalQuestions = quiz.getQuestions().size();
            double percentage = totalQuestions > 0 ? (correctAnswers * 100.0) / totalQuestions : 0;


            req.setAttribute("quiz", quiz);
            req.setAttribute("correctAnswers", correctAnswers);
            req.setAttribute("totalQuestions", totalQuestions);
            req.setAttribute("percentage", percentage);
            req.getRequestDispatcher("quizResult.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", "Error processing quiz submission: " + e.getMessage());
            req.getRequestDispatcher("takeQuiz.jsp").forward(req, resp);
        }

    }
}
