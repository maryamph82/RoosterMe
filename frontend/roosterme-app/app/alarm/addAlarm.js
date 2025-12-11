import React, { useState } from "react";
import { View, Text, StyleSheet, TextInput, TouchableOpacity } from "react-native";
import { useRouter } from "expo-router";
import { useAlarm } from "/context/AlarmContext";

export default function AddAlarm() {
  const [hour, setHour] = useState("");
  const [minute, setMinute] = useState("");

  const { addAlarm } = useAlarm();
  const router = useRouter();

  const saveAlarm = () => {
    if (!hour || !minute) return;

    const newAlarm = {
      id: Date.now(),
      time: `${hour.padStart(2, "0")}:${minute.padStart(2, "0")}`,
      active: true,
    };

    addAlarm(newAlarm);

    router.back();
  };

  return (
    <View style={styles.container}>
      <View style={styles.card}>
        <Text style={styles.title}>Set Alarm</Text>

        <View style={styles.inputRow}>
          <TextInput
            style={styles.input}
            placeholder="HH"
            maxLength={2}
            keyboardType="number-pad"
            value={hour}
            onChangeText={setHour}
          />

          <Text style={styles.colon}>:</Text>

          <TextInput
            style={styles.input}
            placeholder="MM"
            maxLength={2}
            keyboardType="number-pad"
            value={minute}
            onChangeText={setMinute}
          />
        </View>

        <TouchableOpacity style={styles.saveButton} onPress={saveAlarm}>
          <Text style={styles.saveText}>Save Alarm</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#d9d9d9",
    justifyContent: "center",
    alignItems: "center",
  },

  card: {
    width: "80%",
    backgroundColor: "#b2ebf2",
    padding: 30,
    borderRadius: 20,
    alignItems: "center",
    gap: 20,
    shadowColor: "#000",
    shadowOpacity: 0.15,
    shadowRadius: 10,
    elevation: 8,
  },

  title: {
    fontSize: 24,
    fontWeight: "bold",
  },

  inputRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: 10,
  },

  input: {
    width: 70,
    height: 70,
    fontSize: 32,
    textAlign: "center",
    backgroundColor: "white",
    borderRadius: 15,
    borderWidth: 1,
    borderColor: "#aaa",
  },

  colon: {
    fontSize: 40,
    fontWeight: "bold",
  },

  saveButton: {
    backgroundColor: "#00796b",
    paddingVertical: 15,
    paddingHorizontal: 40,
    borderRadius: 12,
    marginTop: 10,
  },

  saveText: {
    color: "white",
    fontSize: 18,
    fontWeight: "bold",
  },
});
