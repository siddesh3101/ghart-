import React, { useState } from "react";
import "./styles/Login.css";
import { useNavigate, Link } from "react-router-dom";
import logo from "..//assets/logo.png";
import useLogin from "../hooks/useLogin";

function Login() {
  const navigate = useNavigate();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const { login } = useLogin();

  const handleSubmit = async (event) => {
    event.preventDefault();
    await login(email, password);
  };
  return (
    <div className="login-wrapper">
      <div className="content-wrapper mt-36">
        <div className="login-form-container">
          <form className="login-form">
            <h1 className=" text-2xl my-2">Login</h1>
            <input
              type="email"
              placeholder="Email"
              onChange={(e) => setEmail(e.target.value)}
            />
            <input
              type="password"
              placeholder="Password"
              onChange={(e) => setPassword(e.target.value)}
            />
            <button onClick={(e) => handleSubmit(e)}>Login</button>
            <div className="login-subtitle">
              <p>New Here?</p>
              <Link to="/signup">Signup</Link>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}

export default Login;
