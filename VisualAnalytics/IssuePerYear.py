import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv('../CSVs/issue_per_year.csv')

grouped_data = data.groupby('Keyword')

plt.figure(figsize=(10, 6))

colors = ['blue', 'lightblue', 'purple', 'violet', 'lightgreen']

for i, (issue, group) in enumerate(grouped_data):
    plt.plot(group['year'], group['count'], marker='o', label=issue, color=colors[i])

plt.xlabel('Year', fontsize=12)
plt.ylabel('Count', fontsize=12)
plt.title('Trend of Issues Over Years', fontsize=14)
plt.legend(fontsize=10)
plt.grid(True, linestyle='--', alpha=0.5)

plt.tight_layout()
plt.show()
