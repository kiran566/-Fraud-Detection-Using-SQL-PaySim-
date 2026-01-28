

#  Fraud Detection Using SQL & Machine Learning (PaySim Dataset)

##  Project Overview

Financial fraud is a critical challenge in banking systems, where fraudulent transactions often follow specific hidden patterns.
This project builds an **end-to-end fraud detection system** using **SQL for analysis** and **Machine Learning for prediction**, based on the **PaySim synthetic banking dataset**.

The workflow mirrors **real industry practices**:

> Database → SQL analysis →  → Python → ML model

##  Objectives

 Detect suspicious transaction patterns using SQL
 Identify fraud-prone transaction types
 Engineer fraud-specific features
 Build and evaluate ML models on imbalanced data
 Create a resume-ready, real-world project

---

##  Dataset

* **Source**: PaySim – Synthetic Financial Dataset for Fraud Detection
* **Records**: 6.3 million+ transactions
* **Type**: Banking transactions simulation

### Key Columns

| Column        | Description             |
| ------------- | ----------------------- |
| step          | Time step (hour-based)  |
| type          | Transaction type        |
| amount        | Transaction amount      |
| nameOrig      | Sender account          |
| nameDest      | Receiver account        |
| oldbalanceOrg | Sender balance before   |
| newbalanceOrg | Sender balance after    |
| isFraud       | Fraud label (1 = fraud) |

---

##  Tech Stack

* **Database**: PostgreSQL
* **Query Language**: SQL
* **Programming**: Python
* **Libraries**: Pandas, Scikit-learn, SQLAlchemy
* **ML Models**: Logistic Regression, Random Forest

## Project Architecture

```
PostgreSQL
   ↓
SQL Fraud Analysis
   ↓
Feature Engineering
   ↓
Python (Pandas)
   ↓
Machine Learning Models
   ↓
Fraud Prediction
```

##  SQL Fraud Analysis (Key Insights)

###  High-Frequency Transactions

* Multiple transactions from the same sender within the same hour indicate suspicious behavior.

###  Multiple Receivers from One Sender

* Fraud accounts often send money to many different receivers.

### Balance Drain Pattern

* Fraudulent transactions frequently reduce account balance to **zero**.

### Fraud by Transaction Type

* `TRANSFER` and `CASH_OUT` account for **most fraud cases**.
* `PAYMENT` and `DEBIT` show negligible fraud.

---

##  Feature Engineering

Custom features created using SQL & Python:

* `balance_drain` → Sender balance drops to zero
* High transaction amount indicator
* Transaction frequency per hour
* Encoded transaction types

---

##  Machine Learning Models

### Baseline Model

* **Logistic Regression**
* Used for interpretability and comparison

### Advanced Model(can be used also)

* **Random Forest Classifier**
* Handles non-linearity and imbalance
* Uses `class_weight='balanced'`
  

##Model Evaluation

Fraud detection is a **highly imbalanced problem**, so accuracy is NOT the main metric.

**Key Metrics Used**:

* Precision (Fraud)
* Recall (Fraud)
* Confusion Matrix

##  Feature Importance (Random Forest)

Top fraud indicators:

* Balance drain
* Transaction amount
* TRANSFER transactions
* CASH_OUT transactions

## 📁 Project Structure

```
Fraud-Detection-Using-SQL-PaySim/
│
├── sql/
│   ├── schema.sql
│   ├── fraud_patterns.sql
│   └── balance_drain_analysis.sql
│
├── data/
│   └── fraud_data.csv
│
├── notebooks/
│   ├── eda.ipynb
│   └── ml_model.ipynb
│
├── models/
│   └── fraud_model.pkl
│
└── README.md
```

## 🚀 How to Run

1. Load dataset into PostgreSQL
2. Run SQL scripts for analysis
3. Export engineered features to CSV
4. Train ML models using Python
5. Evaluate and save the model


## 📌 Key Learnings

* SQL is extremely powerful for fraud detection
* Fraud datasets are highly imbalanced
* Recall is more important than accuracy
* Feature engineering matters more than complex models

## This project demonstrates:

* Real-world SQL usage
* End-to-end data pipeline
* Fraud analytics understanding
* Machine learning on imbalanced data

## 👤 Author

**Kiran**
B.Tech CSE
GitHub: [https://github.com/kiran566](https://github.com/kiran566)

