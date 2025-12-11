import { MaterialIcons } from "@expo/vector-icons";
import { useRouter } from "expo-router";
import { StyleSheet, Text, TouchableOpacity, View } from "react-native";



export default function AlarmScreen() {
  const router = useRouter();

  return (
    <View style={styles.container}>
      
      {/* Header */}
      <View style={styles.header}>
        <MaterialIcons name="alarm-on" size={40} color="#004d40" />
        <Text style={styles.headerText}>Alarm</Text>
      </View>

      {/* Alarm Card */}
      <View style={styles.alarmCard}>
        <MaterialIcons name="check-circle" size={32} color="green" />


        {/* Time */}
        <View style={styles.daysContainer}>
          {["1", "2",":" , "1", "5"].map((item, index) => (
            <View key={index} style={styles.dayCircle}>
              <Text style={styles.dayText}>{item}</Text>
            </View>
          ))}
        </View>
      </View>

      {/* Add Button */}
      <TouchableOpacity style={styles.addButton}onPress={() => router.push("/addAlarm")}>
        <Text style={styles.addText}>+</Text>
      </TouchableOpacity>

    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#acc0c3ff",
    padding: 20,
  },

  header: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    marginBottom: 20,
    gap: 10,
  },

  headerText: {
    fontSize: 32,
    fontWeight: "300",
    fontFamily: "serif",
  },

  alarmCard: {
    flexDirection: "row",
    backgroundColor: "white",
    padding: 20,
    borderRadius: 15,
    alignItems: "center",
    justifyContent: "space-between",
    shadowColor: "#000",
    shadowOpacity: 0.1,
    shadowRadius: 5,
    elevation: 5,
  },

  daysContainer: {
    flexDirection: "row",
    gap: 8,
  },

  dayCircle: {
    backgroundColor : 'black' ,
    width: 28,
    height: 28,
    borderRadius: 2,
    alignItems: "center",
    justifyContent: "center",
  },

  dayText: {
    color: "white",
    fontSize: 14,
    fontWeight: "bold",
  },

  addButton: {
    width: 60,
    height: 60,
    backgroundColor: "white",
    borderRadius: 30,
    justifyContent: "center",
    alignItems: "center",
    position: "absolute",
    bottom: 30,
    right: 30,
    shadowColor: "#000",
    shadowOpacity: 0.2,
    shadowRadius: 5,
    elevation: 6,
  },

  addText: {
    fontSize: 32,
    fontWeight: "bold",
  },
});
