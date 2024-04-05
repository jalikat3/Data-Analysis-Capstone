import pandas as pd
import matplotlib.pyplot as plt

# Read data from CSV
data = pd.read_csv('./Results_CSV/Industry_ConsumerGoods.csv')

# Sort the data by industry and filing year
data = data.sort_values(by=['Industry', 'Filing_Year'])

# Group the data by industry
grouped_data = data.groupby('Industry')

plt.figure(figsize=(10, 6))

# Plot each industry's trend
for industry, group in grouped_data:
    plt.plot(group['Filing_Year'], group['Count of Industry Lawsuits'], marker='o', label=industry)

plt.xlabel('Year', fontsize=12)
plt.ylabel('Count of Industry Lawsuits', fontsize=12)
plt.title('Trend of Industry Lawsuits Over Years', fontsize=14)
plt.legend(fontsize=10)
plt.grid(True, linestyle='--', alpha=0.5)

plt.tight_layout()
plt.show()
