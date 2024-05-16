import React from 'react';
import './App.css';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { CardProvider } from './components/CardContext'; 
import ConfigureCards from './components/ConfigureCards';
import Box from './components/Box';
import Strip from './components/Strip';
import StripTwo from './components/StripTwo';
import StripThree from './components/StripThree';
import NavBar from './components/NavBar';
import Footer from './components/Footer';
import ConfirmDeck from './components/ConfirmDeck';
import StartGame from './components/StartGame';
import Lore from './components/Lore';  
import Rules from './components/Rules';  
import Turn from './components/Turn'; 
import OutputData from './components/OutputData'; 
import GameConfiguration from './components/GameConfiguration'; 
import GameStats from './components/GameStats'; 






function App() {
  return (
    <CardProvider> 
      <Router>
        <div>
          <NavBar />
          <Routes>
            <Route path="/" element={<><Box /><StripTwo /><Strip /><StripThree /></>} />
            <Route path="/confirm" element={<ConfirmDeck />} />
            <Route path="/lore" element={<Lore />} />
            <Route path="/start" element={<StartGame />} />
            <Route path="/rules" element={<Rules />} />
            <Route path="/turn" element={<Turn />} />
            <Route path="/configurecards" element={<ConfigureCards />} />
            <Route path="/outputdata" element={<OutputData />} />
            <Route path="/gameconfiguration" element={<GameConfiguration />} />
            <Route path="/gamestats" element={<GameStats />} />


          </Routes>
          <Footer />
        </div>
      </Router>
    </CardProvider>
  );
}

export default App;
