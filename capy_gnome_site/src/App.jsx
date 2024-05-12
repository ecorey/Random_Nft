import React from 'react';
import './App.css';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { CardProvider } from './components/CardContext'; 
import EnterDefenseCards from './components/EnterDefenseCards';
import Box from './components/Box';
import Strip from './components/Strip';
import StripTwo from './components/StripTwo';
import NavBar from './components/NavBar';
import Footer from './components/Footer';
import ConfirmDeck from './components/ConfirmDeck';
import StartGame from './components/StartGame';
import Lore from './components/Lore';  
import Rules from './components/Rules';  
import Turn from './components/Turn'; 
import OutputData from './components/OutputData'; 





function App() {
  return (
    <CardProvider> 
      <Router>
        <div>
          <NavBar />
          <Routes>
            <Route path="/" element={<><Box /><StripTwo /><Strip /></>} />
            <Route path="/confirm" element={<ConfirmDeck />} />
            <Route path="/lore" element={<Lore />} />
            <Route path="/start" element={<StartGame />} />
            <Route path="/rules" element={<Rules />} />
            <Route path="/turn" element={<Turn />} />
            <Route path="/enterdefensecards" element={<EnterDefenseCards />} />
            <Route path="/outputdata" element={<OutputData />} />

          </Routes>
          <Footer />
        </div>
      </Router>
    </CardProvider>
  );
}

export default App;
