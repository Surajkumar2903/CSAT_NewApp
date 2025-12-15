

# CSAT_NewApp

## Overview

**CSAT_NewApp** is a SwiftUI-based iOS application designed to collect **Customer Satisfaction (CSAT)** feedback in an engaging and user-friendly way.
The app focuses on **smooth animations, contextual feedback capture, and positive reinforcement** to encourage users to share their experience.

The flow is intentionally lightweight and intuitive, making feedback feel like a natural part of the user journey rather than a forced action.

---

## Key Features

### ⭐ CSAT Feedback Flow

* Star-based rating system (1–5)
* Contextual quick feedback options based on rating
* Optional free-text feedback
* Automatic handling of positive feedback (4–5 stars)

### 🎉 Celebration & Feedback Reinforcement

* A **confetti animation** is shown when:

  * User submits feedback
  * User selects a positive rating (greater than 3 stars)
* Confetti is timed carefully to:

  * Appear immediately
  * Transition smoothly into the Thank You state
  * Stop gracefully after the animation completes

This creates a **reward-based feedback loop**, improving completion rates and user sentiment.

---

## 🎨 Animations & Effects

### Confetti Effect

* Celebration-style confetti (not coin-based)
* Originates from the lower portion of the screen
* Spreads naturally around the center
* Synced with the “Thank You” screen to avoid race conditions
* Optimized to avoid GPU / IOSurface issues

### UI Animations

* Smooth state transitions using SwiftUI animations
* Morphing SF Symbols on the Intro screen
* Subtle timing delays to maintain visual hierarchy and clarity

---

## 🧭 Intro / Onboarding Experience

The app includes a **multi-page animated Intro screen** that:

* Uses expressive SF Symbols
* Highlights interaction, feedback importance, and delight
* Guides the user before entering the main experience

---

## 🌿 Branch Information

Please use the correct branch depending on what you want to review:

### 🔹 `Suraj` Branch

* Contains the **Intro / Onboarding screen**
* Includes morphing symbols and onboarding animations
* Demonstrates entry-point flow before the main app

👉 Use this branch if you want to review **UI, animations, and onboarding experience**.

---

### 🔹 `developer` Branch

* Contains the **assigned task implementation**
* Focuses on CSAT logic, feedback flow, and state handling
* No onboarding screen

👉 Use this branch if you want to review **functional requirements and task completion**.

---

## 🛠 Tech Stack

* **SwiftUI**
* **Combine**
* MVVM architecture
* SF Symbols
* Custom animations & transitions

---

## 📌 Notes

* The app is optimized to avoid common animation and GPU issues.
* All animations are synchronized with state changes for stability.
* Code is structured for easy extension and production readiness.

---

If you want, I can also:

* Add screenshots section placeholders
* Write a **Setup / Run Instructions** section
* Create a **Features checklist**
* Prepare a **submission-ready README** for interviews or assignments

Just tell me.
