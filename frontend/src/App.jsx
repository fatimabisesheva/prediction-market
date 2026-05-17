import { useState } from "react";
import { ethers } from "ethers";

import { GOVTOKEN_ABI } from "./abi/GovTokenABI";
import { PREDICTIONMARKET_ABI } from "./abi/PredictionMarketABI";
import { ERC20_ABI } from "./abi/ERC20ABI";

function App() {

  const [account, setAccount] = useState("");
  const [balance, setBalance] = useState("");
  const [status, setStatus] = useState("");

  const GOVTOKEN_ADDRESS =
  "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0";

  const MARKET_ADDRESS =
    "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";

  async function connectWallet() {

    try {

      if (!window.ethereum) {
        alert("Install MetaMask");
        return;
      }

      const accounts =
        await window.ethereum.request({
          method: "eth_requestAccounts",
        });

      const user = accounts[0];

      setAccount(user);

      const provider =
        new ethers.BrowserProvider(window.ethereum);

      const contract =
        new ethers.Contract(
          GOVTOKEN_ADDRESS,
          GOVTOKEN_ABI,
          provider
        );

      const tokenBalance =
        await contract.balanceOf(user);

      setBalance(
        ethers.formatEther(tokenBalance)
      );

      setStatus("Wallet connected!");

    } catch (error) {
      console.log(error);
      setStatus("Connection failed");
    }
  }

  async function approveToken() {

    try {

      setStatus("Approving token...");

      const provider =
        new ethers.BrowserProvider(window.ethereum);

      const signer =
        await provider.getSigner();

      const token =
        new ethers.Contract(
          GOVTOKEN_ADDRESS,
          ERC20_ABI,
          signer
        );

      const tx =
        await token.approve(
          MARKET_ADDRESS,
          ethers.parseEther("1000")
        );

      await tx.wait();

      setStatus("Token approved!");

    } catch (error) {
      console.log(error);
      setStatus("Approve failed");
    }
  }

  async function buyYes() {

    try {

      setStatus("Buying YES shares...");

      const provider =
        new ethers.BrowserProvider(window.ethereum);

      const signer =
        await provider.getSigner();

      const market =
        new ethers.Contract(
          MARKET_ADDRESS,
          PREDICTIONMARKET_ABI,
          signer
        );

      const tx =
        await market.buyYes(
          ethers.parseEther("10")
        );

      await tx.wait();

      setStatus("Bought YES shares!");

    } catch (error) {
      console.log(error);
      setStatus("Buy YES failed");
    }
  }

  async function buyNo() {

    try {

      setStatus("Buying NO shares...");

      const provider =
        new ethers.BrowserProvider(window.ethereum);

      const signer =
        await provider.getSigner();

      const market =
        new ethers.Contract(
          MARKET_ADDRESS,
          PREDICTIONMARKET_ABI,
          signer
        );

      const tx =
        await market.buyNo(
          ethers.parseEther("10")
        );

      await tx.wait();

      setStatus("Bought NO shares!");

    } catch (error) {
      console.log(error);
      setStatus("Buy NO failed");
    }
  }

  return (
    <div
      style={{
        minHeight: "100vh",
        background:
          "linear-gradient(to bottom right, #2b1d16, #4e342e)",
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        fontFamily: "Arial",
      }}
    >
      <div
        style={{
          background: "rgba(255,255,255,0.08)",
          backdropFilter: "blur(10px)",
          padding: "40px",
          borderRadius: "30px",
          width: "500px",
          boxShadow:
            "0 8px 32px rgba(0,0,0,0.3)",
          color: "white",
        }}
      >
        <h1
          style={{
            fontSize: "42px",
            marginBottom: "10px",
          }}
        >
          Prediction Market
        </h1>

        <p
          style={{
            color: "#d7ccc8",
            marginBottom: "30px",
          }}
        >
          Will BTC exceed 100k?
        </p>

        <button
          onClick={connectWallet}
          style={buttonStyle}
        >
          Connect Wallet
        </button>

        <div
          style={{
            display: "flex",
            gap: "10px",
            marginTop: "20px",
          }}
        >
          <button
            onClick={approveToken}
            style={buttonStyle}
          >
            Approve
          </button>

          <button
            onClick={buyYes}
            style={{
              ...buttonStyle,
              background: "#6d4c41",
            }}
          >
            Buy YES
          </button>

          <button
            onClick={buyNo}
            style={{
              ...buttonStyle,
              background: "#8d6e63",
            }}
          >
            Buy NO
          </button>
        </div>

        <div
          style={{
            marginTop: "30px",
            background: "rgba(255,255,255,0.05)",
            padding: "20px",
            borderRadius: "20px",
          }}
        >
          <p>
            <b>Wallet:</b>
            <br />
            {account || "Not connected"}
          </p>

          <p>
            <b>GovToken Balance:</b>
            <br />
            {balance}
          </p>

          <p>
            <b>Status:</b>
            <br />
            {status}
          </p>
        </div>
      </div>
    </div>
  );
}

const buttonStyle = {
  padding: "14px 20px",
  borderRadius: "18px",
  border: "none",
  background: "#5d4037",
  color: "white",
  cursor: "pointer",
  fontWeight: "bold",
  transition: "0.2s",
};

export default App;