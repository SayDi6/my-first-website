<!DOCTYPE html>
<html>
<head>
  <title>Anonymous Confession Wall</title>
</head>
<body>

<h2>🕵️ Anonymous Confession Wall</h2>

<button onclick="connectWallet()">Connect Wallet</button>

<br><br>

<input id="message" placeholder="Write your confession..." />
<button onclick="postConfession()">Post (small fee)</button>

<br><br>

<input id="tipIndex" placeholder="Confession index" />
<button onclick="tip()">Tip ❤️</button>

<script src="https://cdn.jsdelivr.net/npm/ethers@5.7.2/dist/ethers.min.js"></script>

<script>
let provider;
let signer;
let contract;

const contractAddress = "0x4f1ab8fcc85aaa20ffe3105add56b2d2185aa3db";

// ABI (simplified)
const abi = [
  "function postConfession(string memory _message) payable",
  "function tipConfession(uint256 index) payable"
];

async function connectWallet() {
  provider = new ethers.providers.Web3Provider(window.ethereum);
  await provider.send("eth_requestAccounts", []);
  signer = provider.getSigner();
  contract = new ethers.Contract(contractAddress, abi, signer);
  alert("Wallet Connected");
}

async function postConfession() {
  const msg = document.getElementById("message").value;

  const tx = await contract.postConfession(msg, {
    value: ethers.utils.parseEther("0.00001")
  });

  await tx.wait();
  alert("Confession Posted!");
}

async function tip() {
  const index = document.getElementById("tipIndex").value;

  const tx = await contract.tipConfession(index, {
    value: ethers.utils.parseEther("0.00001")
  });

  await tx.wait();
  alert("Tipped!");
}
</script>

</body>
</html>
