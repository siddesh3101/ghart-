import "./Hero.css";
import CountUp from "react-countup";
import { motion } from "framer-motion";
import SearchBar from "../SearchBar/SearchBar";
import HeroImage from "../../../assets/hero1.png";
const Hero = () => {
  return (
    <section className="hero-wrapper">
      <div className="paddings innerWidth flexCenter hero-container">
        {/* left side */}
        <div className="flexColStart hero-left">
          <div className="hero-title">
            {/* <div className="orange-circle" /> */}
            <motion.h1
              initial={{ y: "2rem", opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{
                duration: 2,
                type: "ease-in",
              }}
            >
              Buy, Sell, Design <br />
              We've Got You
              <br /> Covered
            </motion.h1>
          </div>
          <div className="flexColStart secondaryText flexhero-des">
            <span>Discover a fanstastic platform to buy, sell, rent, </span>
            <span>or design properties</span>
          </div>

          <div className="flex items-start justify-center gap-16">
            <div className="flexColCenter stat">
              <span>
                <CountUp start={49000} end={50000} duration={4} />{" "}
                <span>+</span>
              </span>
              <span className="secondaryText">Users</span>
            </div>

            <div className="flexColCenter stat">
              <span>
                <CountUp start={9000} end={10000} duration={4} /> <span>+</span>
              </span>
              <span className="secondaryText">Properties</span>
            </div>
          </div>
          <SearchBar />
        </div>

        {/* right side */}
        <div className="flexCenter hero-right">
          <motion.div
            initial={{ x: "7rem", opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            transition={{
              duration: 2,
              type: "ease-in",
            }}
            className="image-container"
          >
            <img src={HeroImage} alt="houses" />
          </motion.div>
        </div>
      </div>
    </section>
  );
};

export default Hero;
