<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Result</title>
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
    </style>
</head>
<body>

<div class="container py-5">
    <h1 class="mb-4 text-center">Quiz Result</h1>

    <!-- Back to Quiz List Button -->
    <div class="text-end mb-4">
        <a href="userQuizzes" class="btn btn-secondary">⬅ Back to Quiz List</a>
    </div>

    <!-- Error Message (if any) -->
    <c:if test="${not empty error}">
        <p class="text-danger text-center">${error}</p>
    </c:if>

    <!-- Quiz Result -->
    <c:if test="${not empty quiz}">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">${quiz.title}</h5>
            </div>
            <div class="card-body">
                <p class="text-muted">${quiz.description}</p>
                <hr>
                <h6>Your Result</h6>
                <p><strong>Correct Answers:</strong> ${correctAnswers} / ${totalQuestions}</p>
                <p><strong>Percentage:</strong> ${percentage}%</p>
                <c:if test="${percentage >= 80}">
                    <p class="text-success">Great job! You passed the quiz.</p>
                </c:if>
                <c:if test="${percentage < 80}">
                    <p class="text-warning">You scored below 80%. Try again!</p>
                </c:if>
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>