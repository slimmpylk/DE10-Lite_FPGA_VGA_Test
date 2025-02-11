### VGA Display on DE10-Lite

## Creators leeviekd & slimmpylk

This project demonstrates how to use the DE10-Lite board to generate a simple VGA output. We used this setup to explore how the board could function in a GPU-like role, and the result is a display of three colored bars.
How It Works

    Clock Division
    The 50 MHz clock on the DE10-Lite is divided by two to obtain a 25 MHz pixel clock, which is required for 640×480 VGA timing.

    Timing Counters
        A horizontal counter generates the timing for each line (total 800 counts, including 640 active pixels and blanking intervals).
        A vertical counter manages the frame timing (total 525 counts, including 480 active lines and blanking intervals).

    Sync Signals
    Hsync and Vsync are driven low for specific portions of each line/frame, in accordance with the 640×480 @ 60 Hz standard.

    Color Output
        The screen is divided into three horizontal sections.
        Each section is filled with one of the primary colors: red, green, or blue.
        Outside the active region, the color signals are set to black.

<img src="https://github.com/user-attachments/assets/b69c75f6-40d1-4d4e-b1f5-a0187bc6c11a" width="300">



File Description

    vgadisplay.vhd: Contains the top-level VHDL module. It handles clock division, generates Hsync and Vsync, and produces the RGB signals for the color bars.
    vht file is for testbench for quartus.

Usage

    Synthesize and program vgadisplay.vhd onto your DE10-Lite board.
    Connect a VGA cable from the DE10-Lite to a monitor.
    Power on your board and observe three horizontal bars in red, green, and blue.
