import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv('../CSVs/StateAnalysisResult.csv')
data=data.head(10)
year = data['State of Filing'].astype(str) 
total = data['Total']

plt.figure(figsize=(10, 6))

plt.grid(True, linestyle='--', alpha=0.5, zorder=0)
bars = plt.bar(year, total, color='lightblue', width=0.5, zorder=3)

plt.xlabel('State', fontsize=12)
plt.ylabel('Total', fontsize=12)
plt.title('Analysis of Total Lawsuits from States', fontsize=14)

plt.xticks(fontsize=10, rotation=45)  # Adjust rotation as needed
plt.yticks(fontsize=10)

for i, value in enumerate(total):
    plt.text(year[i], value, str(value), ha='center', va='bottom', fontsize=10)
#note = "Data source: https://www.accessibility.com/digital-lawsuits"
#plt.annotate(note, xy=(.2, -0.15), xycoords='axes fraction', ha='center', fontsize=10, color='grey',
#           xytext=(0, 10), textcoords='offset points')

plt.tight_layout()
plt.show()
