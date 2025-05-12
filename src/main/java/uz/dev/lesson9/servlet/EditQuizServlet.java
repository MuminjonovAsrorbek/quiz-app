package uz.dev.lesson9.servlet;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
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
import java.util.Objects;

/**
 * Created by: asrorbek
 * DateTime: 4/29/25 10:13
 **/

@WebServlet("/editQuiz")
public class EditQuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String quizId = req.getParameter("quizId");
        String action = req.getParameter("action");

        try (EntityManager entityManager = StartStopListener.sessionFactory.createEntityManager()) {

            Quiz quiz = entityManager.find(Quiz.class, Integer.parseInt(quizId));
            if (quiz == null) {
                req.setAttribute("error", "Quiz not found.");
                req.getRequestDispatcher("editQuiz.jsp").forward(req, resp);
                return;
            }
            if ("deleteQuestion".equals(action)) {
                String questionId = req.getParameter("questionId");
                Question question = entityManager.find(Question.class, Integer.parseInt(questionId));
                if (question != null && question.getQuiz().getId().equals(quiz.getId())) {
                    entityManager.getTransaction().begin();
                    quiz.getQuestions().remove(question);
                    entityManager.getTransaction().commit();
                }
            } else if ("deleteAnswer".equals(action)) {
                String answerId = req.getParameter("answerId");
                AnswerOption answer = entityManager.find(AnswerOption.class, Integer.parseInt(answerId));
                if (answer != null) {
                    Question question = answer.getQuestion();
                    if (question != null && question.getQuiz().getId().equals(quiz.getId())) {
                        entityManager.getTransaction().begin();
                        question.getAnswerOptions().remove(answer);
                        entityManager.getTransaction().commit();
                    }
                }
            }

            quiz = entityManager.find(Quiz.class, Integer.parseInt(quizId));
            req.setAttribute("quiz", quiz);
            req.getRequestDispatcher("editQuiz.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error processing request: " + e.getMessage());
            req.getRequestDispatcher("editQuiz.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String quizId = req.getParameter("quizId");
        String action = req.getParameter("action");

        EntityManager entityManager = null;
        try {
            entityManager = StartStopListener.sessionFactory.createEntityManager();
            entityManager.getTransaction().begin();

            Quiz quiz = entityManager.find(Quiz.class, Integer.parseInt(quizId));
            if (quiz == null) {
                req.setAttribute("error", "Quiz not found.");
                req.getRequestDispatcher("editQuiz.jsp").forward(req, resp);
                return;
            }
            if ("updateQuiz".equals(action)) {
                String title = req.getParameter("title");
                String description = req.getParameter("description");
                quiz.setTitle(title);
                quiz.setDescription(description);
                entityManager.merge(quiz);
            } else if ("addQuestion".equals(action)) {
                String content = req.getParameter("content");
                Question question = new Question();
                question.setContent(content);
                question.setQuiz(quiz);
                question.setAnswerOptions(new java.util.ArrayList<>());
                quiz.getQuestions().add(question);
                entityManager.persist(question);
            } else if ("updateQuestion".equals(action)) {
                String questionId = req.getParameter("questionId");
                String content = req.getParameter("content");
                Question question = entityManager.find(Question.class, Integer.parseInt(questionId));
                if (question != null && question.getQuiz().getId().equals(quiz.getId())) {
                    question.setContent(content);
                    entityManager.merge(question);
                }
            } else if ("addAnswer".equals(action)) {
                String questionId = req.getParameter("questionId");
                String content = req.getParameter("content");
                boolean isCorrect = "true".equals(req.getParameter("isCorrect"));
                Question question = entityManager.find(Question.class, Integer.parseInt(questionId));
                if (question != null && question.getQuiz().getId().equals(quiz.getId())) {
                    if (isCorrect) {
                        for (AnswerOption existingAnswer : question.getAnswerOptions()) {
                            if (existingAnswer.getIsCorrect()) {
                                existingAnswer.setIsCorrect(false);
                                entityManager.merge(existingAnswer);
                            }
                        }
                    }
                    AnswerOption answer = new AnswerOption();
                    answer.setContent(content);
                    answer.setIsCorrect(isCorrect);
                    answer.setQuestion(question);
                    question.getAnswerOptions().add(answer);
                    entityManager.persist(answer);
                }
            } else if ("updateAnswer".equals(action)) {
                String answerId = req.getParameter("answerId");
                String content = req.getParameter("content");
                boolean isCorrect = "true".equals(req.getParameter("isCorrect"));
                AnswerOption answer = entityManager.find(AnswerOption.class, Integer.parseInt(answerId));
                if (answer != null && answer.getQuestion().getQuiz().getId().equals(quiz.getId())) {
                    if (isCorrect) {
                        Question question = answer.getQuestion();
                        for (AnswerOption otherAnswer : question.getAnswerOptions()) {
                            if (!otherAnswer.getId().equals(answer.getId()) && otherAnswer.getIsCorrect()) {
                                otherAnswer.setIsCorrect(false);
                                entityManager.merge(otherAnswer);
                            }
                        }
                    }
                    answer.setContent(content);
                    answer.setIsCorrect(isCorrect);
                    entityManager.merge(answer);
                }
            }

            entityManager.getTransaction().commit();

            quiz = entityManager.find(Quiz.class, Integer.parseInt(quizId));
            req.setAttribute("quiz", quiz);
            req.getRequestDispatcher("editQuiz.jsp").forward(req, resp);
        } catch (Exception e) {
            if (entityManager != null && entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            req.setAttribute("error", "Error processing request: " + e.getMessage());
            req.getRequestDispatcher("editQuiz.jsp").forward(req, resp);
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }
    }
}
