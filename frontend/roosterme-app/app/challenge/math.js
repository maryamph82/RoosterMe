import React, { useState, useEffect } from "react";
import { View, Text, StyleSheet, TextInput, TouchableOpacity } from "react-native";
import { useRouter } from "expo-router";

export default function MathChallenge() {
  const router = useRouter();

  const [questionIndex, setQuestionIndex] = useState(0);
  const [question, setQuestion] = useState("");
  const [answer, setAnswer] = useState("");
  const [correctAnswer, setCorrectAnswer] = useState(null);
  const [feedback, setFeedback] = useState("");

  // توليد سؤال تصادفی
  const generateQuestion = () => {
    const a = Math.floor(Math.random() * 40) + 10;
    const b = Math.floor(Math.random() * 9) + 1;

    const ops = ["+", "-", "*", "/"];
    const op = ops[Math.floor(Math.random() * ops.length)];

    let q, ans;

    switch (op) {
      case "+":
        q = `${a} + ${b} = ?`;
        ans = a + b;
        break;
      case "-":
        q = `${a} - ${b} = ?`;
        ans = a - b;
        break;
      case "*":
        q = `${a} × ${b} = ?`;
        ans = a * b;
        break;
      case "/":
        const m = a - (a % b); // قابل تقسیم
        q = `${m} / ${b} = ?`;
        ans = m / b;
        break;
    }

    setQuestion(q);
    setCorrectAnswer(ans);
  };

  useEffect(() => {
    generateQuestion();
  }, [questionIndex]);

  // بررسی پاسخ
  const checkAnswer = () => {
    if (parseInt(answer) === correctAnswer) {
      setFeedback("correct");
      setTimeout(() => {
        if (questionIndex === 4) {
          router.push("/alarm"); // چالش تمام شد
        } else {
          setQuestionIndex(questionIndex + 1);
          setAnswer("");
          setFeedback("");
        }
      }, 600);
    } else {
      setFeedback("wrong");
      setTimeout(() => setFeedback(""), 700);
    }
  };

  return (
    <View style={styles.container}>

      <View style={styles.card}>

        <Text style={styles.counter}>Q {questionIndex + 1} / 5</Text>

        <View style={styles.questionBox}>
          <Text style={styles.questionMark}>?</Text>
          <Text style={styles.question}>{question}</Text>
        </View>

        <TextInput
          style={[
            styles.input,
            feedback === "correct" && { borderColor: "green" },
            feedback === "wrong" && { borderColor: "red" }
          ]}
          keyboardType="numeric"
          value={answer}
          onChangeText={setAnswer}
        />

        <TouchableOpacity style={styles.btn} onPress={checkAnswer}>
          <Text style={styles.btnText}>Submit</Text>
        </TouchableOpacity>

        {feedback === "correct" && <Text style={styles.correct}>✔ Correct!</Text>}
        {feedback === "wrong" && <Text style={styles.wrong}>✖ Wrong!</Text>}

      </View>

      <View style={styles.keyboardPlaceholder}>
        <Text style={styles.keyboardText}>kybord</Text>
      </View>

    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#4a347f",
    justifyContent: "space-between",
  },
  card: {
    marginTop: 70,
    alignSelf: "center",
    width: "80%",
    backgroundColor: "white",
    padding: 25,
    borderRadius: 20,
    alignItems: "center",
    gap: 20,
  },
  counter: {
    alignSelf: "flex-end",
    fontSize: 16,
    fontWeight: "600",
  },
  questionBox: {
    width: "90%",
    backgroundColor: "#f1f1ff",
    padding: 20,
    borderRadius: 20,
    alignItems: "center",
    gap: 10,
  },
  questionMark: {
    fontSize: 40,
    opacity: 0.6,
  },
  question: {
    fontSize: 22,
    fontWeight: "600",
  },
  input: {
    width: 120,
    height: 60,
    backgroundColor: "#fafafa",
    borderWidth: 2,
    borderColor: "#ccc",
    borderRadius: 12,
    fontSize: 28,
    textAlign: "center",
  },
  btn: {
    backgroundColor: "#5a2ea6",
    paddingVertical: 12,
    paddingHorizontal: 45,
    borderRadius: 12,
    marginTop: 10,
  },
  btnText: {
    color: "white",
    fontSize: 20,
    fontWeight: "bold",
  },
  correct: {
    color: "green",
    fontSize: 20,
    fontWeight: "bold",
  },
  wrong: {
    color: "red",
    fontSize: 20,
    fontWeight: "bold",
  },
  keyboardPlaceholder: {
    height: "25%",
    backgroundColor: "#eee",
    justifyContent: "center",
    alignItems: "center",
  },
  keyboardText: {
    fontSize: 28,
    opacity: 0.4,
  },
});
