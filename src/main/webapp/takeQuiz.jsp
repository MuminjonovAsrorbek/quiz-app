<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Take Quiz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #28a745;
            color: white;
            border-radius: 10px 10px 0 0;
        }
        .question-card {
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #fff;
        }
    </style>
</head>
<body>

<div class="container py-5">
    <h1 class="mb-4 text-center">Take Quiz</h1>

    <!-- Back to Quiz List Button -->
    <div class="text-end mb-4">
        <a href="userQuizzes" class="btn btn-secondary">⬅ Back to Quiz List</a>
    </div>

    <!-- Error Message (if any) -->
    <c:if test="${not empty error}">
        <p class="text-danger text-center">${error}</p>
    </c:if>

    <!-- Quiz Details -->
    <c:if test="${empty quiz}">
        <p class="text-center">Quiz not found.</p>
    </c:if>
    <c:if test="${not empty quiz}">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">${quiz.title}</h5>
            </div>
            <div class="card-body">
                <p class="text-muted">${quiz.description}</p>
                <p class="text-muted"><small>Questions: ${quiz.questions.size()}</small></p>
                <hr>

                <!-- Quiz Form -->
                <form action="submitQuiz" method="post">
                    <input type="hidden" name="quizId" value="${quiz.id}">
                    <c:forEach var="question" items="${quiz.questions}" varStatus="questionLoop">
                        <div class="question-card">
                            <h6>${questionLoop.count}. ${question.content}</h6>
                            <c:forEach var="answer" items="${question.answerOptions}" varStatus="answerLoop">
                                <div class="form-check">
                                    <input type="radio" class="form-check-input" name="answer_${question.id}" value="${answer.id}" required>
                                    <label class="form-check-label">${answer.content}</label>
                                </div>
                            </c:forEach>
                        </div>
                    </c:forEach>
                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">Submit Quiz</button>
                    </div>
                </form>
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>