import { createContext, useContext, useReducer } from "react";
import { useEffect } from "react";
import axios from "axios";
export const PropertyContext = createContext();

export function authReducer(state, action) {
  switch (action.type) {
    case "LOAD":
      return action.payload;
    default:
      return state;
  }
}

export function PropertyContextProvider({ children }) {
  const [state, dispatch] = useReducer(authReducer, {
    data: null,
  });
  async function fetchDetails() {
    const url = `${process.env.REACT_APP_BACKEND_URL}/getProperty`;
    const data = await axios.get(url);
    if (data) {
      const store = data?.data;
      console.log(store);
      dispatch({
        type: "LOAD",
        payload: {
          data: store,
        },
      });
    }
  }
  useEffect(() => {
    fetchDetails();
  }, []);
  return (
    <PropertyContext.Provider value={{ ...state, dispatch }}>
      {children}
    </PropertyContext.Provider>
  );
}

export function usePropertyContext() {
  const context = useContext(PropertyContext);

  if (!context) {
    throw Error("Using PropertContext outside the PropertContextProvider");
  }

  return context;
}
