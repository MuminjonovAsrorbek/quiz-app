<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Quiz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
    <h2 class="mb-4">Create Quiz</h2>

    <!-- Step 1: Quiz Details -->
    <c:if test="${empty sessionScope.quiz}">
        <div class="card mb-4">
            <div class="card-body">
                <h5>Step 1: Quiz Details</h5>
                <form action="createQuiz" method="post">
                    <input type="hidden" name="step" value="quiz">
                    <div class="mb-3">
                        <label class="form-label">Quiz Title</label>
                        <input type="text" class="form-control" name="title" placeholder="Enter quiz title" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Quiz Description</label>
                        <textarea class="form-control" name="description" placeholder="Enter quiz description" required></textarea>
                    </div>
                    <div class="text-end">
                        <a href="quiz" class="btn btn-secondary me-2">Cancel</a>
                        <button type="submit" class="btn btn-primary">Next: Add Question</button>
                    </div>
                </form>
            </div>
        </div>
    </c:if>

    <!-- Step 2: Add Question -->
    <c:if test="${not empty sessionScope.quiz and empty sessionScope.currentQuestion}">
        <div class="card mb-4">
            <div class="card-body">
                <h5>Step 2: Add Question</h5>
                <form action="createQuiz" method="post">
                    <input type="hidden" name="step" value="question">
                    <div class="mb-3">
                        <label class="form-label">Question Content</label>
                        <input type="text" class="form-control" name="content" placeholder="Enter question text" required>
                    </div>
                    <div class="text-end">
                        <a href="quiz" class="btn btn-secondary me-2">Cancel</a>
                        <button type="submit" class="btn btn-primary">Next: Add Answer Options</button>
                    </div>
                </form>
            </div>
        </div>
    </c:if>

    <!-- Step 3: Add Answer Option -->
    <c:if test="${not empty sessionScope.currentQuestion}">
        <div class="card mb-4">
            <div class="card-body">
                <h5>Step 3: Add Answer Option</h5>
                <form action="createQuiz" method="post">
                    <input type="hidden" name="step" value="answer">
                    <div class="mb-3">
                        <label class="form-label">Answer Content</label>
                        <input type="text" class="form-control" name="content" placeholder="Enter answer option" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-check-label">
                            <input type="checkbox" class="form-check-input" name="isCorrect" value="true">
                            Is Correct?
                        </label>
                    </div>
                    <div class="text-end">
                        <a href="quiz" class="btn btn-secondary me-2">Cancel</a>
                        <!-- Faqat 3 tadan kam bo'lsa "Add Another Answer Option" tugmasini ko'rsatamiz -->
                        <c:if test="${sessionScope.currentQuestion.answerOptions.size() < 3}">
                            <button type="submit" class="btn btn-primary">Add Another Answer Option</button>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>
    </c:if>

    <!-- Display Current Quiz Data -->
    <c:if test="${not empty sessionScope.quiz}">
        <div class="card">
            <div class="card-body">
                <h5>Current Quiz</h5>
                <p><strong>Title:</strong> ${sessionScope.quiz.title}</p>
                <p><strong>Description:</strong> ${sessionScope.quiz.description}</p>
                <hr>
                <h6>Questions</h6>
                <c:forEach var="question" items="${sessionScope.quiz.questions}" varStatus="loop">
                    <div class="question-card mb-3">
                        <strong>${question.content}</strong>
                        <ul class="list-group list-group-flush">
                            <c:forEach var="answer" items="${question.answerOptions}">
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
                <c:if test="${not empty sessionScope.currentQuestion}">
                    <div class="question-card mb-3">
                        <strong>${sessionScope.currentQuestion.content}</strong>
                        <ul class="list-group list-group-flush">
                            <c:forEach var="answer" items="${sessionScope.currentQuestion.answerOptions}">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                        ${answer.content}
                                    <c:if test="${answer.isCorrect}">
                                        <span class="badge bg-success">Correct</span>
                                    </c:if>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${not empty sessionScope.quiz.questions || not empty sessionScope.currentQuestion}">
                    <c:if test="${not empty sessionScope.currentQuestion}">
                        <form action="createQuiz" method="post">
                            <input type="hidden" name="step" value="addQuestion">
                            <button type="submit" class="btn btn-outline-primary me-2">Add Another Question</button>
                        </form>
                    </c:if>
                    <form action="createQuiz" method="post">
                        <input type="hidden" name="step" value="save">
                        <button type="submit" class="btn btn-success">Save Quiz</button>
                    </form>
                </c:if>
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>