import React, { useState } from "react";
import { useAuthContext } from "./useAuthContext";
import axios from "axios";
import { useNavigate } from "react-router-dom";

function useLogin() {
  const [error, setError] = useState(null);
  const [isLoading, setIsLoading] = useState(null);
  const { dispatch } = useAuthContext();
  const navigate = useNavigate();

  const login = async (email, password) => {
    setIsLoading(true);
    setError(null);
    console.log(email, password);
    const response = await axios
      .post(`${process.env.REACT_APP_BACKEND_URL}/login`, {
        email: email,
        password: password,
      })
      .catch((error) => {
        alert(error.response.data.message);
        setIsLoading(false);
      });
    const json = await response.data;
    if (json && json.status != toString(200)) {
      localStorage.setItem("user", JSON.stringify(json.data));
      dispatch({ type: "LOGIN", payload: json.data });
      setIsLoading(false);
      //refresh the window
      navigate("/");
      // window.location.reload();
    } else {
      alert("Invalid Credentials");
    }
  };
  return { login, isLoading, error };
}

export default useLogin;
