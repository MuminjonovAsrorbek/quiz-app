<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Details</title>
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
            background-color: #007bff;
            color: white;
            border-radius: 10px 10px 0 0;
        }
        .question-card, .answer-option {
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #fff;
        }
    </style>
</head>
<body>

<div class="container py-5">
    <h1 class="mb-4 text-center">Quiz Details</h1>

    <!-- Back to Quiz Manager Button -->
    <div class="text-end mb-4">
        <a href="quiz" class="btn btn-secondary">⬅ Back to Quiz Manager</a>
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
                <p class="text-muted"><small>Created at: ${quiz.createdAt}</small></p>
                <hr>
                <h6>Questions</h6>
                <c:if test="${empty quiz.questions}">
                    <p>No questions available for this quiz.</p>
                </c:if>
                <c:forEach var="question" items="${quiz.questions}" varStatus="questionLoop">
                    <div class="question-card mb-3">
                        <strong>${question.content}</strong>
                        <ul class="list-group list-group-flush">
                            <c:forEach var="answer" items="${question.answerOptions}" varStatus="answerLoop">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                        ${answer.content}
                                    <c:if test="${answer.isCorrect}">
                                        <span class="badge bg-success">Correct</span>
                                    </c:if>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>