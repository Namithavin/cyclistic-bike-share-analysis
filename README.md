# Cyclistic Bike-Share Case Study: Maximizing Annual Memberships
*Google Data Analytics Capstone Project*

## 📊 Live Dashboard
View the full interactive dashboard on Tableau Public:  
👉 [Tableau Public Cyclistic Dashboard](https://public.tableau.com/views/GoogleDataAnalyticsCapstoneCyclisticBikeShareAnalysis/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

---

## 📌 Business Task
Analyze historical bike trip data to identify how **annual members** and **casual riders** use Cyclistic bikes differently, and provide data-backed marketing recommendations to convert casual riders into annual members.

---

## 🛠️ Tools & Technologies Used
- **Google BigQuery:** Data consolidation, deduplication, cleaning, and metric engineering across ~2M raw records.
- **Tableau Public:** Data visualization and interactive dashboard creation.

---

## 🧹 Data Cleaning Highlights (SQL)
- Removed trips lasting under 60 seconds (docking errors / false starts).
- Filtered out rides longer than 24 hours (stolen or unreturned bikes).
- Excluded internal maintenance and testing station logs.
- Removed records with missing geographic coordinates.

---

## 🔍 Key Findings
1. **Commuters vs. Leisure:** Annual members ride consistently Monday through Friday with sharp peaks at 8:00 AM and 5:00 PM. Casual riders dominate weekends with peak afternoon activity.
2. **Ride Duration:** Casual riders ride more (~18 mins) compared to members (~12 mins).
3. **High-Traffic Hubs:** Casual riders concentrate around tourist hubs (e.g., Navy Pier, Millennium Park).

---

## 💡 Top Recommendations
1. **Seasonal/Weekend Memberships:** Create targeted passes for weekend and summer riders.
2. **On-Site Conversion Campaigns:** Deploy marketing prompts and digital signage at the top 5 tourist stations during peak weekend hours.
3. **Ride Credit Incentives:** Offer membership discounts for trips over 15 minutes to appeal to casual riders' longer travel patterns.
