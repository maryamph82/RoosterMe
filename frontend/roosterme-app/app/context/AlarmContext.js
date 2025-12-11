import React, { createContext, useContext, useState } from "react";

const AlarmContext = createContext();

export const AlarmProvider = ({ children }) => {
  const [alarms, setAlarms] = useState([]);

  const addAlarm = (alarm) => {
    setAlarms((prev) => [...prev, alarm]);
  };

  return (
    <AlarmContext.Provider value={{ alarms, addAlarm }}>
      {children}
    </AlarmContext.Provider>
  );
};

export const useAlarm = () => useContext(AlarmContext);
