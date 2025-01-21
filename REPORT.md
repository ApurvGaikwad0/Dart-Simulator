# MP Report

## Team

- Name: Apurv Gaikwad 
- AID: A20569178

## Self-Evaluation Checklist

"I apologize for the previous mistake; due to an oversight, I accidentally pushed the wrong file to the repository. Please consider this version, which accurately reflects the intended submission for MP-1. Thank you for your understanding and consideration."

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:

- [x] The simulator builds without error
- [x] The simulator runs on at least one configuration file without crashing
- [x] Verbose output (via the `-v` flag) is implemented
- [x] I used the provided starter code
- The simulator runs correctly (to the best of my knowledge) on the provided configuration file(s):
  - [x] conf/sim1.yaml
  - [x] conf/sim2.yaml
  - [x] conf/sim3.yaml
  - [x] conf/sim4.yaml
  - [x] conf/sim5.yaml

## Summary and Reflection

For this project, I built a queueing system simulator that handles different types of processes like one-time (singleton), repeating (periodic), and random (stochastic) events. I added a verbose mode to show detailed output during the simulation and used exponential distributions to manage random events. The simulator was designed to ensure that all events are processed in the correct order.

One of the challenges I faced was dealing with random event generation for stochastic processes. Understanding and applying exponential distributions was key to solving this issue. Debugging and ensuring the simulator worked across all configuration files, especially the more complex ones like sim4.yaml and sim5.yaml, was also a learning experience.

Overall, I enjoyed learning how different process types affect the simulation, and I found debugging the event ordering to be a useful learning experience.