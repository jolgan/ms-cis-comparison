# CIS-to-MS Conversion Predictors: A Cross-Population Comparison of Mexican and Lithuanian Clinical Cohorts
The central question: which patients with Clinically Isolated Syndrome (CIS) went on to develop Multiple Sclerosis (MS), and which clinical signs predicted it?

## Overview

<!-- Briefly describe the project: what question it answers, why it matters, and the approach taken. -->
This is a complete data analysis of clinical predictors of MS, an autoimmune disease without a cure. It can affect vision, mobility, balance, cognitive function, and in severe cases, can be fatal. Treatments exist that slow progression significantly, but none reverse existing damage. This makes early diagnosis critically important. The datasets used follow patients who experienced a first neurological episode (Clinically Isolated Syndrome, or CIS) and track which ones went on to develop MS, comparing clinical signs between those who converted and those who did not. I care particularly about this topic because my great-aunt battled MS. Witnessing her deterioration as a child - from an independent, courageous woman to wheelchair-bound, then bedridden - was rapid and heart-wrenchingly unfair. She eventually succumbed to pneumonia in hospital.

## Data Sources

| Dataset | Population | Source | Notes |
|---------|------------|--------|-------|
| `data/raw/lithuanian_cis.xlsx` | Lithuanian | <!-- Institution / publication --> | <!-- n, follow-up period, etc. --> |
| `data/raw/mexican_cis.xlsx` | Mexican | <!-- Institution / publication --> | <!-- n, follow-up period, etc. --> |

<!-- Add any data access restrictions or citations here. -->

## Tools Used

- Python (pandas, scikit-learn, matplotlib, seaborn)
- Jupyter Notebooks
- SQL
- Power BI

## Key Findings

<!-- Summarise the most important results once the analysis is complete. -->

- TBD

## How to Run

### 1. Clone the repository

```bash
git clone https://github.com/jolgan/ms-cis-comparison.git
cd ms-cis-comparison
```

### 2. Create and activate a virtual environment

```bash
python -m venv .venv
# Windows
.venv\Scripts\activate
# macOS / Linux
source .venv/bin/activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

### 4. Run the notebooks

Open the `notebooks/` folder in Jupyter Lab or VS Code and run in order.

---

*Analysis by Jolene Gan*
