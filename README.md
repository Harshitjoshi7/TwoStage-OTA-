# 2-Stage Miller Compensated OTA Design

**Guided by: Siddharth Singh Parihar Sir**

---

## Project Description
A high-performance two-stage Operational Transimpedance Amplifier (OTA) designed using a PMOS input differential pair and NMOS active loads. This project focuses on the fundamental design flow from schematic capture in **Synopsys Custom Compiler** to verification in **LTspice**. The design emphasizes balancing Gain-Bandwidth Product (GBW) and stability (Phase Margin) for analog signal processing.

## Performance Summary
| Parameter | Value |
| :--- | :--- |
| **DC Gain** | ~45 dB |
| **GBW** | 10.3 MHz |
| **Phase Margin** | 48.6° |
| **Supply Voltage** | 1.05V |
| **Technology** | 105nm Generic Models |

## Architecture
The circuit utilizes a **Miller compensation capacitor (C16)** to perform pole-splitting. This technique moves the dominant pole to a lower frequency and the secondary pole to a higher frequency, ensuring stability and preventing oscillation in a closed-loop configuration.



## Project Metadata
* **Designer:** [Your Name]
* **Guide:** Siddharth Singh Parihar Sir
* **Tools Used:** Synopsys Custom Compiler, LTspice XVII (via Bottles/Wine)
* **Operating System:** AlmaLinux 8 (Flatpak/Bottles environment)

## How to Simulate
1. Navigate to the `/sim` folder.
2. Open the `ota_master_testbench.sp` file in **LTspice**.
3. **Choose Analysis:** Toggle the comments (`*`) in the "SIMULATION COMMANDS" section to switch between:
   * **.AC**: For Bode Plots (Gain & Phase).
   * **.TRAN**: For time-domain sine wave analysis.
   * **.OP**: For DC operating point verification.
4. Run the simulation and compare results with the screenshots provided in the `/docs` folder.
