# README #

Simple nginx honeypot with health point.

### What is this repository for? ###

Nginx response 410 (Gone) for all requests except requests for /health_point. For health point nginx returns 204 (No content).

Goal of this repo is to create honeypot and redirect all evil bots to nowhere.
