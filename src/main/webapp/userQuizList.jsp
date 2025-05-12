<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Quizzes</title>
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
        .quiz-card {
            transition: transform 0.2s;
        }
        .quiz-card:hover {
            transform: scale(1.02);
        }
        .btn-sm {
            font-size: 0.85rem;
        }
    </style>
</head>
<body>

<div class="container py-5">
    <h1 class="mb-4 text-center">Available Quizzes</h1>

    <!-- Error Message (if any) -->
    <c:if test="${not empty error}">
        <p class="text-danger text-center">${error}</p>
    </c:if>

    <!-- List of Quizzes -->
    <div class="row">
        <c:if test="${empty quizzes}">
            <p class="text-center">No quizzes available.</p>
        </c:if>
        <c:forEach var="quiz" items="${quizzes}" varStatus="quizLoop">
            <div class="col-md-12 mb-4">
                <div class="card quiz-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">${quiz.title}</h5>
                        <div>
                            <a href="takeQuiz?id=${quiz.id}" class="btn btn-sm btn-success">Take Quiz</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">${quiz.description}</p>
                        <p class="text-muted"><small>Created at: ${quiz.createdAt}</small></p>
                        <p class="text-muted"><small>Questions: ${quiz.questions.size()}</small></p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>