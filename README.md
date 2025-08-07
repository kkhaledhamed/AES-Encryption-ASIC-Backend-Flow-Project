# 🔐 AES Encryption – ASIC Backend Flow Project

**ADI Digital IC Design Internship Assignment**  
Under the supervision of **Eng. Mohamed Ewais**  
📅 August 2025  
🧑‍🤝‍🧑 Team D: Khaled Mohamed, Galal Mohamed, Mohamed Abdel-Hay, Youssef Ahmed, Nadim Abdelrahman and me Khaled A. Hamed

---

## 📌 Objective

This project demonstrates a complete **ASIC backend flow** for the **AES-128 encryption core** across **three different toolchains and technology nodes**:

1. **OpenLane Flow** – 130nm open-source flow  
2. **Synopsys ICC Flow** – 45nm commercial toolchain  
3. **ADFlow** – 22nm internal Analog Devices flow with optimized setup

Each flow covers the full RTL-to-GDSII pipeline, including:
- Synthesis
- Floorplanning
- Placement and Clock Tree Synthesis
- Routing
- Static Timing Analysis (STA)
- Power Analysis
- Physical Verification (DRC/LVS)
- Parasitic Extraction
- GDSII Generation
- IR Drop Simulation

---

## 🔄 AES Architecture

AES-128 is a **symmetric block cipher**:
- 128-bit plaintext input  
- 10 rounds: `SubBytes → ShiftRows → MixColumns → AddRoundKey`  
- Final round skips MixColumns  
- Key expansion generates 10 round keys  
- Outputs 128-bit ciphertext

---

## 🧪 Flows Used

### 🔸 1. OpenLane Flow – **130nm Open-Source**

- Tools: Yosys, OpenROAD, Magic, Netgen, KLayout
- Synthesis strategy exploration using `-synth_explore`
- Strategy chosen: **AREA3**
- RTL simulation: SystemVerilog testbench
- Post-route parasitics used for STA and power estimation
- DRC and LVS with Magic/Netgen
- GDSII exported via KLayout

#### 🔹 Key Stats:
- Tech node: 130nm
- Post-route utilization: **33%**
- Instances: 139,182
- Registers: 4000
- Leakage Power: 1.215 mW
- Switching Power: 30.41 mW
- Static IR Drop: 22.83 mV
- DRC Violations: 980
- LVS: ✅ PASS
- Formality: ✅ PASS

---

### 🔸 2. Synopsys ICC Flow – **45nm Commercial Tool**

- Tools: Design Compiler, IC Compiler, PrimeTime, VCS
- Parasitics: SPEF + VCD for dynamic power
- Vectorless and vector-based IR drop analysis
- GDSII + DRC/LVS via ICC + Calibre
- Power grid and voltage source optimization
- Simulation with SystemVerilog TB to generate activity

#### 🔹 Key Stats:
- Tech node: 45nm
- Total Power: 238.92 mW  
  - Internal: 99.20 mW  
  - Switching: 126.24 mW  
  - Leakage: 13.48 mW  
- Hold Slack: +0.02 ns
- Setup Slack: +0.15 ns
- Max IR Drop: 30 mV
- Scan chain: 3712 FFs
- GDSII snapshot included

---

### 🔸 3. ADFlow – **22nm Analog Devices Internal Flow**

- Highly optimized internal PDK at ADI
- Used ICC2, PrimeTime, internal scripts
- Superior timing, area, and power compared to other flows
- Best clock closure, lowest power profile
- Met all timing and power targets

#### 🔹 Key Stats:
- Tech node: 22nm
- Clock period: 1 ns
- All WNS/TNS met
- Very low IR drop and leakage
- Compact area with high-density cell placement
- Used NAND2_X1 as dominant standard cell

---

## 📊 Comparison Table

| Metric              | ADFlow (22nm) | Synopsys ICC (45nm) | OpenLane (130nm) |
|---------------------|---------------|----------------------|------------------|
| Clock Period        | 1 ns          | 1 ns                 | 4 ns             |
| Area                | 🔽 Smallest   | Medium               | 🔼 Largest(Bad)  |
| Power               | 🔽 Lowest     | Medium (238 mW)      | High             |
| Leakage             | 🔽 Least      | 13.48 mW             | 1.21 mW          |
| IR Drop             | 🔽 Very low   | ~30 mV               | ~23 mV           |
| Utilization         | 🔼 Highest    | Low                  | Medium (33%)     |
| Timing Closure      | ✅ Met        | ✅ Met               | ❌ Violated      |
| GDSII Export        | ✅            | ✅                   | ✅               |
| DRC Violations      | 0             | 0                    | 980              |

---

## 🔍 Internal Hierarchy (OpenLane View)

| Module        | Instances | Key Submodules        |
|---------------|-----------|------------------------|
| AES_Encryption | 1         | Top-level              |
| DFF_128        | 10        | Pipeline Registers     |
| Key            | 10        | Key Expansion + SBox   |
| Mix_Column     | 9         | GF(2^8) Mult LUTs      |
| Sub_Bytes      | 10        | 16 SBox Instances      |
| Round_reg      | 10        | State Storage          |

---

## 🧠 Technical Skills Practiced

- RTL-to-GDSII full backend flow  
- IR Drop Simulation (vectorless and vector-based)  
- Formality Checks (RTL vs Netlist)  
- Static Timing Analysis (Hold & Setup)  
- Power-aware placement and routing  
- Scan Insertion  
- SPEF/VCD/SAIF generation  
- GDSII export and DRC/LVS clean design

---

## 📸 Screenshots Included

- GDSII Layout
- Power Grid
- Logic Cell Usage (NAND2_X1)
- STA Reports
- IR Drop Maps
- Timing Paths (reg2out, in2reg)
- DRC & LVS Logs

---

## 📎 Resources

🔗 [Google Drive Folder with Reports & Screenshots](https://drive.google.com/drive/u/0/folders/1wMn32byrnx4u5NvuAwUfP6imW4w4H0SG)  
🔗 [OpenLane GitHub](https://github.com/The-OpenROAD-Project/OpenLane)  
🔗 [Synopsys ICC](https://www.synopsys.com/implementation-and-signoff/rtl-to-gdsii/icc2.html)  
🔗 [KLayout for GDSII](https://www.klayout.de/)  
🔗 [OpenSTA](https://github.com/The-OpenROAD-Project/OpenSTA)

---

## 🙏 Acknowledgments

Special thanks to **Eng. Mohamed Ewais** for mentoring and guidance throughout this internship.  
A heartfelt thank you to my amazing teammates:  
**Galal Mohamed**, **Mohamed Abdel-Hay**, **Youssef Ahmed**, **Nadim Abdelrahman**, and **Khaled Mohamed** — your teamwork made this possible!

---

## 🔮 Future Work

- Add assertion-based and UVM verification  
- MCMM timing across corners  
- Functional coverage for AES  
- PPA optimization with gate sizing  
- Power-aware scan insertion  
- Scripting automation for entire flow

---

## 📜 License

This project is part of a student academic internship and is intended for learning and research purposes only.  
**© Analog Devices, Inc**. – 2025

