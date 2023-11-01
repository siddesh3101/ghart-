import React, { useState } from "react";
import { useEffect } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import HMPLogo from "../../assets/logo.png";
import "./Navbar.css";
import gsap from "gsap";
import { useAuthContext } from "../../hooks/useAuthContext";
import useLogout from "../../hooks/useLogout";
import { FaRegUserCircle } from "react-icons/fa";
function Navbar(props) {
  const navigate = useNavigate();
  const [isNavExpanded, setIsNavExpanded] = useState(false);
  const location = useLocation();

  function animate() {
    gsap.from(".navbarAnimation", {
      duration: 1,
      y: -100,
      opacity: 0,
    });
  }
  // useEffect(() => {
  //   animate();
  // }, []);

  function handleClick() {
    setIsNavExpanded(!isNavExpanded);
  }

  const navbarData = [
    { name: "Rent", link: "/rent", id: "rent" },
    { name: "Buy", link: "/buy", id: "buy" },
    { name: "Sell", link: "/sell", id: "sell" },
    { name: "Design", link: "/design", id: "design" },
    { name: "Maps", link: "/map", id: "map" },
  ];
  const { user } = useAuthContext();
  const { logout } = useLogout();
  return (
    <nav className="landing-navbar navbarAnimation">
      <div className="navbar-logo navbarAnimation flex justify-center items-center">
        <img src={HMPLogo} onClick={() => navigate("/")} />
        <h1 className="font-bold text-sm">APNA GHAR</h1>
      </div>
      <div className={isNavExpanded ? "navbar-menu expanded" : "navbar-menu "}>
        <ul>
          {navbarData.map((item, index) => {
            return (
              <li
                key={index}
                id="id"
                style={
                  location.pathname.split("/")[1] == item.id
                    ? { color: "var(--blue)" }
                    : {}
                }
              >
                <Link
                  to={item.link}
                  id={item.name.toLowerCase()}
                  onClick={handleClick}
                >
                  {item.name}
                </Link>
              </li>
            );
          })}
          {!user && (
            <div className="flex navbar-buttons">
              <li>
                <button
                  onClick={() => navigate("/login")}
                  className="btn-secondary"
                >
                  Login
                </button>
              </li>
              <li>
                <button
                  onClick={() => navigate("/login")}
                  className="btn-primary"
                >
                  Sign up
                </button>
              </li>
            </div>
          )}
          {user && (
            <div className="flex navbar-buttons items-center">
              <li className="flex items-center gap-4">
                <FaRegUserCircle style={{ width: "25px", height: "25px" }} />
                <p>{user?.name.split(" ")[0]}</p>
              </li>
              {/* <li>
                <button onClick={() => logout()} className="btn-primary">
                  Logout
                </button>
              </li> */}
            </div>
          )}
        </ul>
      </div>
      <button className="hamburger" onClick={handleClick}>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          className="h-5 w-5"
          viewBox="0 0 20 20"
          fill="white"
        >
          <path
            fillRule="evenodd"
            d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM9 15a1 1 0 011-1h6a1 1 0 110 2h-6a1 1 0 01-1-1z"
            clipRule="evenodd"
          />
        </svg>
      </button>
    </nav>
  );
}

export default Navbar;
