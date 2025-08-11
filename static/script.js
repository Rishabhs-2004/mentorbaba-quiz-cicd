let currentQuestion = 0;
let totalQuestions = document.querySelectorAll('.question-box').length;

function showQuestion(index) {
    const questions = document.querySelectorAll('.question-box');
    questions.forEach((q, i) => {
        q.style.display = i === index ? 'block' : 'none';
    });
}

function nextQuestion() {
    if (currentQuestion < totalQuestions - 1) {
        currentQuestion++;
        showQuestion(currentQuestion);
        resetTimer();
    }
}

function prevQuestion() {
    if (currentQuestion > 0) {
        currentQuestion--;
        showQuestion(currentQuestion);
        resetTimer();
    }
}

// Timer
let timeLeft = 30;
let timer;

function startTimer() {
    timer = setInterval(() => {
        timeLeft--;
        document.getElementById('timer').textContent = timeLeft;
        if (timeLeft === 0) {
            clearInterval(timer);
            nextQuestion();
        }
    }, 1000);
}

function resetTimer() {
    clearInterval(timer);
    timeLeft = 30;
    document.getElementById('timer').textContent = timeLeft;
    startTimer();
}

// Start on load
window.onload = () => {
    showQuestion(currentQuestion);
    startTimer();
};
