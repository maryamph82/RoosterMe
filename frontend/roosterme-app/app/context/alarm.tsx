import { useEffect, useState } from "react";
import { View, Text, FlatList, Switch } from "react-native";
import { api } from "../../services/api";
import { Alarm } from "../../types/Alarm";


export default function AlarmsScreen() {
  const [alarms, setAlarms] = useState<Alarm[]>([]);

useEffect(() => {
  const fetchAlarms = async () => {
    try {
      const response = await api.get<Alarm[]>("/alarms");
      setAlarms(response.data);
    } catch (error) {
      console.log("API ERROR:", error);
    }
  };

  fetchAlarms();
}, []);

  return (
    <View style={{ flex: 1, padding: 20 }}>
      <Text style={{ fontSize: 22, marginBottom: 16 }}>⏰ آلارم‌ها</Text>

      <FlatList
        data={alarms}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <View
            style={{
              flexDirection: "row",
              justifyContent: "space-between",
              padding: 12,
              marginBottom: 8,
              backgroundColor: "#eee",
              borderRadius: 8,
            }}
          >
            <Text style={{ fontSize: 18 }}>{item.time}</Text>
            <Switch value={item.enabled} />
          </View>
        )}
      />
    </View>
  );
}
