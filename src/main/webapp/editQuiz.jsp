<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Quiz</title>
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

        .btn-sm {
            font-size: 0.85rem;
        }
    </style>
</head>
<body>

<div class="container py-5">
    <h1 class="mb-4 text-center">Edit Quiz</h1>

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
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="mb-0">Edit Quiz Details</h5>
            </div>
            <div class="card-body">
                <form action="editQuiz" method="post">
                    <input type="hidden" name="action" value="updateQuiz">
                    <input type="hidden" name="quizId" value="${quiz.id}">
                    <div class="mb-3">
                        <label class="form-label">Quiz Title</label>
                        <input type="text" class="form-control" name="title" value="${quiz.title}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Quiz Description</label>
                        <textarea class="form-control" name="description" required>${quiz.description}</textarea>
                    </div>
                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">Update Quiz</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Questions Section -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">Questions</h5>
            </div>
            <div class="card-body">
                <c:if test="${empty quiz.questions}">
                    <p>No questions available for this quiz.</p>
                </c:if>
                <c:forEach var="question" items="${quiz.questions}" varStatus="questionLoop">
                    <div class="question-card mb-3">
                        <!-- Edit Question Form -->
                        <form action="editQuiz" method="post" class="mb-2">
                            <input type="hidden" name="action" value="updateQuestion">
                            <input type="hidden" name="quizId" value="${quiz.id}">
                            <input type="hidden" name="questionId" value="${question.id}">
                            <div class="d-flex justify-content-between align-items-center">
                                <input type="text" class="form-control me-2 question-content" name="content"
                                       value="${question.content}" required>
                                <div>
                                    <button type="submit" class="btn btn-sm btn-warning me-2">Update</button>
                                    <a href="editQuiz?action=deleteQuestion&quizId=${quiz.id}&questionId=${question.id}"
                                       class="btn btn-sm btn-danger">Delete</a>
                                </div>
                            </div>
                        </form>

                        <!-- Answer Options -->
                        <ul class="list-group list-group-flush">
                            <c:forEach var="answer" items="${question.answerOptions}" varStatus="answerLoop">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <form action="editQuiz" method="post"
                                          class="d-flex w-100 align-items-center answer-option-form">
                                        <input type="hidden" name="action" value="updateAnswer">
                                        <input type="hidden" name="quizId" value="${quiz.id}">
                                        <input type="hidden" name="answerId" value="${answer.id}">
                                        <input type="text" class="form-control me-2 answer-content" name="content"
                                               value="${answer.content}" required>
                                        <div class="form-check me-2">
                                            <input type="radio" class="form-check-input correct-answer"
                                                   name="correctAnswer_${question.id}"
                                                   value="${answer.id}" ${answer.isCorrect ? 'checked' : ''}>
                                            <label class="form-check-label">Is Correct?</label>
                                        </div>
                                        <div>
                                            <a href="editQuiz?action=deleteAnswer&quizId=${quiz.id}&answerId=${answer.id}"
                                               class="btn btn-sm btn-danger">Delete</a>
                                        </div>
                                    </form>
                                </li>
                            </c:forEach>
                        </ul>

                        <!-- Add Answer Option -->
                        <form action="editQuiz" method="post" class="mt-2">
                            <input type="hidden" name="action" value="addAnswer">
                            <input type="hidden" name="quizId" value="${quiz.id}">
                            <input type="hidden" name="questionId" value="${question.id}">
                            <div class="input-group">
                                <input type="text" class="form-control" name="content" placeholder="New answer option"
                                       required>
                                <div class="input-group-text">
                                    <input type="checkbox" name="isCorrect" value="true">
                                    <label class="ms-2">Is Correct?</label>
                                </div>
                                <button type="submit" class="btn btn-sm btn-success">Add Answer</button>
                            </div>
                        </form>
                    </div>
                </c:forEach>

                <!-- Add Question -->
                <form action="editQuiz" method="post" class="mt-3">
                    <input type="hidden" name="action" value="addQuestion">
                    <input type="hidden" name="quizId" value="${quiz.id}">
                    <div class="input-group">
                        <input type="text" class="form-control" name="content" placeholder="New question" required>
                        <button type="submit" class="btn btn-sm btn-success">Add Question</button>
                    </div>
                </form>
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Har bir savol uchun radio button larni boshqarish
    document.querySelectorAll('.question-card').forEach(questionCard => {
        const radioButtons = questionCard.querySelectorAll('.correct-answer');
        const answerForms = questionCard.querySelectorAll('.answer-option-form');
        const answerInputs = questionCard.querySelectorAll('.answer-content');

        // Radio button tanlanganda avtomatik yuborish
        radioButtons.forEach(radio => {
            radio.addEventListener('change', function () {
                // Barcha radio button larni tekshirish
                radioButtons.forEach(otherRadio => {
                    if (otherRadio !== radio) {
                        otherRadio.checked = false;
                    }
                });

                // Formani avtomatik yuborish
                const form = radio.closest('form');
                if (form) {
                    const hiddenInput = document.createElement('input');
                    hiddenInput.type = 'hidden';
                    hiddenInput.name = 'isCorrect';
                    hiddenInput.value = 'true';
                    form.appendChild(hiddenInput);
                    form.submit();
                }
            });
        });

        // AnswerOption content o'zgartirilganda avtomatik yuborish
        answerInputs.forEach(input => {
            input.addEventListener('change', function () {
                const form = input.closest('form');
                if (form) {
                    form.submit();
                }
            });
        });
    });
</script>
</body>
</html>