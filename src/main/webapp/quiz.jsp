<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Manager</title>
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
    <h1 class="mb-4 text-center">Quiz Manager</h1>

    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <p class="text-success text-center">${success}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p class="text-danger text-center">${error}</p>
    </c:if>

    <!-- Create New Quiz Button -->
    <div class="text-end mb-4">
        <a href="createQuiz" class="btn btn-primary">➕ Create New Quiz</a>
    </div>

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
                            <a href="viewQuizDetails?id=${quiz.id}" class="btn btn-sm btn-info me-2">View Details</a>
                            <a href="editQuiz?quizId=${quiz.id}" class="btn btn-sm btn-warning me-2">Edit</a>
                            <a href="deleteQuiz?id=${quiz.id}" class="btn btn-sm btn-danger">Delete</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">${quiz.description}</p>
                        <p class="text-muted"><small>Created at: ${quiz.createdAt}</small></p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>