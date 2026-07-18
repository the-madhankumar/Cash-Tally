# 💰 Cash Tally+

> **Count Cash. Track UPI. Reconcile Instantly.**

A lightweight, offline-first cash reconciliation application designed for cashiers, retail shops, grocery stores, and small businesses. Cash Tally+ helps you quickly count physical cash, record multiple UPI payments, and instantly compare the total received against the expected bill amount.

---

<p align="center">

![Platform](https://img.shields.io/badge/Platform-Android-success)
![Offline](https://img.shields.io/badge/Offline-Yes-brightgreen)
![License](https://img.shields.io/badge/License-MIT-blue)
![Version](https://img.shields.io/badge/Version-v1.0-orange)
![Status](https://img.shields.io/badge/Status-MVP-informational)

</p>

---

# ✨ Features

## 💵 Cash Counting

Quickly enter the quantity of each denomination.

Supported denominations:

| Denomination | Supported |
|--------------|-----------|
| ₹500 | ✅ |
| ₹200 | ✅ |
| ₹100 | ✅ |
| ₹50 | ✅ |
| ₹20 | ✅ |
| ₹10 | ✅ |
| ₹5 | ✅ |
| ₹2 | ✅ |
| ₹1 | ✅ |

Cash total updates instantly as values are entered.

---

## 📱 Multiple UPI Payments

Unlike traditional cash tally applications, Cash Tally+ supports **unlimited UPI entries**.

Each UPI payment contains:

- Amount
- Timestamp
- Delete option

Example

| Amount | Time |
|---------|------|
| ₹350 | 10:15 AM |
| ₹120 | 10:17 AM |
| ₹500 | 10:21 AM |

Users can:

- ➕ Add unlimited entries
- ❌ Remove any entry
- 🕒 Automatically record timestamps

---

## 📊 Live Grand Total

The application continuously calculates

```
Grand Total

=

Cash Total

+

UPI Total
```

No "Calculate" button required.

Everything updates automatically.

---

## ✅ Smart Difference Indicator

If an expected bill amount is entered, Cash Tally+ immediately shows whether the payment is:

🟢 Exact

```
Expected : ₹1500

Received : ₹1500

Status : Exact
```

---

🔴 Less

```
Expected : ₹1500

Received : ₹1450

Less By : ₹50
```

---

🟠 Extra

```
Expected : ₹1500

Received : ₹1600

Extra By : ₹100
```

---

## 🔄 One-Tap Reset

Reset clears

- Expected Amount
- Cash Counts
- UPI Entries
- Totals

Perfect for the next customer.

---

# 🎯 Why Cash Tally+?

Traditional cash tally apps usually focus only on physical cash counting.

Cash Tally+ improves the workflow by supporting:

✅ Cash Counting

✅ Multiple UPI Payments

✅ Expected Bill Comparison

✅ Automatic Difference Detection

✅ Offline Operation

✅ Minimal User Input

Everything is optional.

No mandatory fields.

No login.

No internet.

No waiting.

---

# 🚀 Target Users

Designed for

- 🛒 Grocery Stores
- 🏪 Retail Shops
- 💊 Medical Shops
- ☕ Cafés
- 🍽 Restaurants
- 🧾 Billing Counters
- 🏢 Small Businesses
- 👤 Personal Accounting

---

# 📱 User Interface

```
------------------------------------------------

Expected Amount

[ ₹________ ]

Status

🟢 Exact

or

🔴 Less ₹50

or

🟠 Extra ₹100

------------------------------------------------

Cash

₹500 [ ]

₹200 [ ]

₹100 [ ]

₹50  [ ]

₹20  [ ]

₹10  [ ]

₹5   [ ]

₹2   [ ]

₹1   [ ]

Cash Total

₹1450

------------------------------------------------

UPI

Amount : ₹350

Time   : 10:15

[X]

----------------------

Amount : ₹200

Time   : 10:18

[X]

----------------------

+ Add UPI

UPI Total

₹550

------------------------------------------------

Grand Total

₹2000

------------------------------------------------

Reset
```

---

# ⚙ Functional Requirements

## Expected Amount

- Optional input
- Used only for comparison
- Can remain empty

---

## Cash Entry

- Enter note counts
- Live calculation
- No limit on quantity

---

## UPI Management

- Unlimited entries
- Automatic timestamps
- Remove individual entries

---

## Live Calculations

Automatically updates

- Cash Total
- UPI Total
- Grand Total
- Difference
- Status

No refresh required.

---

## Optional Inputs

All inputs are optional.

The application works with:

| Scenario | Supported |
|----------|-----------|
| Cash Only | ✅ |
| UPI Only | ✅ |
| Expected Amount Only | ✅ |
| Mixed Cash + UPI | ✅ |
| Empty Screen | ✅ |

---

# 🧮 Calculation Engine

## Cash Total

```
Cash Total

=

Σ(Denomination × Count)
```

Example

```
₹500 × 2 = ₹1000

₹200 × 1 = ₹200

₹100 × 3 = ₹300

Cash Total = ₹1500
```

---

## UPI Total

```
UPI Total

=

Σ(UPI Amount)
```

---

## Grand Total

```
Grand Total

=

Cash Total

+

UPI Total
```

---

## Difference

```
Difference

=

Grand Total

−

Expected Amount
```

Rules

```
Difference > 0

→ Extra ₹Difference

Difference < 0

→ Less ₹Difference

Difference = 0

→ Exact
```

---

# ⚡ Non-Functional Requirements

## Performance

- Calculations under **100 ms**
- Instant UI updates

---

## Reliability

- Accurate arithmetic
- No rounding issues
- No calculation errors

---

## Usability

- Large buttons
- Numeric keypad-friendly
- Minimal typing
- One-hand operation

---

## Availability

- Fully Offline
- No Internet Required

---

## Portability

Responsive on

- Android
- Tablets
- Desktop Browsers
- iOS (Future)

---

# 🏗 MVP Roadmap

## Phase 1

- Expected Amount
- Cash Entry
- Cash Total
- Status Banner

---

## Phase 2

- Dynamic UPI Entries
- Add/Remove UPI
- Automatic Timestamp
- UPI Total

---

## Phase 3

- Grand Total
- Difference Indicator
- Live Updates

---

## Phase 4

- Responsive UI
- Animations
- Color-coded Status
- UX Improvements

---

# 🚀 Future Enhancements

- 📜 Transaction History
- 📊 Daily Summary
- 📄 Export PDF
- 📈 Export Excel
- ☁ Cloud Backup
- 🔄 Device Synchronization
- 🌙 Dark Mode
- 🔍 Search Transactions
- 🧾 Invoice Number Support
- 👤 Customer Name
- 🎤 Voice Input
- 📷 QR Scanner
- 📦 Barcode Scanner
- 💱 Custom Denominations

---

# ✅ Acceptance Criteria

The application is complete when:

- Expected amount can be entered (optional)
- Cash totals update instantly
- Unlimited UPI entries are supported
- Every UPI entry records amount and timestamp
- Grand Total is always accurate
- Status displays
  - Exact
  - Less by ₹X
  - Extra by ₹X
- All fields remain optional
- Reset clears the application state

---

# 💡 Design Philosophy

Cash Tally+ is built around one principle:

> **Fast enough to use during live billing without slowing down the cashier.**

The application minimizes taps, avoids unnecessary validation, works completely offline, and performs every calculation in real time.

---

# 📌 Version

**Current Version:** `v1.0`

---

# 📄 License

This project is licensed under the **MIT License**.

---

# ❤️ Built For

Small businesses, shop owners, and cashiers who need a simple, fast, and reliable way to reconcile cash and digital payments.

---

<p align="center">

### **Cash Tally+**

**Simple. Fast. Accurate.**

</p>
