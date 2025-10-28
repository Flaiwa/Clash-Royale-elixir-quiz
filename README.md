# Clash Royale Elixir Quiz

This is a small iOS app built with **SwiftUI**.  
The idea is simple: the app shows you a random Clash Royale card, and you have to guess how much **Elixir** it costs. You always get three possible answers to choose from.  

---

## Features
- Random Clash Royale cards as quiz questions  
- Multiple choice answers
- Score counter with direct feedback (correct / wrong)  
- All card data comes from the official **Clash Royale API**

---

## Requirements
- iOS 17 or later  
- Xcode 15 or later  
- Internet connection  
- A Clash Royale API token (see setup below)

---

## Setup: Clash Royale API
This project uses the official [Clash Royale API](https://developer.clashroyale.com/).

1. Log in at [developer.clashroyale.com](https://developer.clashroyale.com/) with your Supercell ID.  
2. Create a new API key.  
   - You need to whitelist your current public IP address.  
   - If your IP changes, you have to create/update the key again.  
3. Copy the token.  
4. Open `ClashRoyaleAPI.swift` and replace the placeholder with your token:

   ```swift
   private let token = "YOUR_API_TOKEN"
